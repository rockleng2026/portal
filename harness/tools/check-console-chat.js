#!/usr/bin/env node
/*
 * 控制台的「数字员工 → 对话」回归检查。
 *
 * 这个 bug 只在真浏览器里才看得见：点了 A 员工的对话，再点一个还没绑定终端的员工，
 * 面板不关，于是屏幕上还是 A 的对话——看起来就是「每个数字员工点出来都一样」。
 *
 * 这里用 jsdom 跑真正的控制台脚本，对着**真平台**点一遍：
 *   - 每个数字员工点「对话」，面板里必须是**它自己**那台终端的记录；
 *   - 别的终端的记录不许混进来；
 *   - 没有终端的员工点「对话」，面板必须关掉，不能留着上一个人的对话。
 *
 * 用法（需要 node 与 jsdom）：
 *   cd /tmp && npm install jsdom
 *   node harness/tools/check-console-chat.js
 *
 * 它读 ~/.harness/platform.env 里的自然人账号来登录，所以账号要能访问控制台。
 */
'use strict';

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { JSDOM, VirtualConsole } = require('jsdom');

const CONSOLE_DIR = path.join(__dirname, '..', 'harness-platform', 'src', 'main', 'resources', 'static', 'console');
const BASE_URL = process.env.HARNESS_BASE_URL || 'http://127.0.0.1:18080';

let js = fs.readFileSync(path.join(CONSOLE_DIR, 'console.js'), 'utf8');

js += `
;(async function () {
  const log = (...a) => console.log(...a);
  const env = require('child_process').execSync(
    "source ~/.harness/platform.env; printf '%s\\\\n%s\\\\n' \\"$HARNESS_HUMAN_CLIENT_ID\\" \\"$HARNESS_HUMAN_SECRET\\"",
    { shell: '/bin/bash', encoding: 'utf8' }).trim().split('\\n');
  $('#clientId').value = env[0];
  $('#clientSecret').value = env[1];
  $('#baseUrl').value = '${BASE_URL}';
  $('#loginBtn').dispatchEvent(new window.Event('click', { bubbles: true }));
  await new Promise(r => setTimeout(r, 4000));
  if ($('#loginError').textContent) {
    log('登录失败：' + $('#loginError').textContent);
    process.exit(2);
  }
  log('员工 ' + state.agents.length + ' 个，终端 ' + state.terminals.length + ' 台');

  const buttons = Array.from(document.querySelectorAll('#agentsTable button[data-act="chat"]'));
  let problems = 0;
  for (const b of buttons) {
    const id = b.dataset.id;
    const agent = state.agents.find(a => a.agentId === id);
    const name = agent ? (agent.name || agent.agentKey) : id;
    const terminal = state.terminals.find(t => t.agentId === id
      && (!agent || !agent.terminalId || agent.terminalId === t.terminalId));
    b.dispatchEvent(new window.Event('click', { bubbles: true }));
    await new Promise(r => setTimeout(r, 2500));
    const visible = !$('#chat').classList.contains('hidden');
    const entries = Array.from(document.querySelectorAll('#chatLog .chat-msg')).map(n => n.textContent);
    const subtitle = $('#chatSubtitle').textContent;

    if (!terminal) {
      const ok = !visible && entries.length === 0;
      if (!ok) problems++;
      log((ok ? 'OK   ' : 'FAIL ') + name.padEnd(10) + ' 没有终端 -> 面板关闭=' + !visible
        + ' 条目=' + entries.length + '  提示=' + $('#toast').textContent);
      continue;
    }
    const expected = (await api('GET', '/api/harness/tasks?terminalId='
      + encodeURIComponent(terminal.terminalId) + '&limit=20')) || [];
    const expectedPrompts = expected.map(t => t.prompt);
    const shown = entries.filter(e => e.startsWith('我')).map(e => e.replace(/^我/, '').slice(0, 40));
    const foreign = shown.filter(p => p && !expectedPrompts.some(e => e.startsWith(p.slice(0, 20))));
    const ok = visible && subtitle === name && foreign.length === 0;
    if (!ok) problems++;
    log((ok ? 'OK   ' : 'FAIL ') + name.padEnd(10) + ' 终端=' + terminal.terminalId.slice(0, 8)
      + ' 副标题=' + subtitle + ' 条目=' + entries.length + ' 别的终端的内容=' + foreign.length);
  }
  log(problems === 0 ? '\\n全部通过' : '\\n有 ' + problems + ' 处不对');
  process.exit(problems === 0 ? 0 : 1);
})().catch(e => { console.error(e); process.exit(1); });
`;

const vc = new VirtualConsole();
vc.on('log', (...a) => console.log(...a));
vc.on('jsdomError', (e) => console.error('jsdomError:', e.message));

const dom = new JSDOM(fs.readFileSync(path.join(CONSOLE_DIR, 'index.html'), 'utf8'), {
  url: BASE_URL + '/console/index.html',
  runScripts: 'outside-only',
  virtualConsole: vc,
});
const { window } = dom;
window.require = require;
window.process = process;
// jsdom exposes `crypto` as a read-only getter, so it has to be replaced, not assigned.
Object.defineProperty(window, 'crypto', { value: require('crypto').webcrypto, configurable: true });
window.TextEncoder = TextEncoder;
window.TextDecoder = TextDecoder;
window.fetch = (url, opts) => fetch(url, opts);
window.eval(js);
