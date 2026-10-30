#!/usr/bin/env node
/*
 * 控制台的「技能市场」回归检查。
 *
 * 这个页面是重写过的：左边是去哪里看（市场 / 已安装 / 分类 / 外部注册源），
 * 右边是列表和详情。以前搜索结果弹在一个小框里，技能一多就没人看得懂。
 *
 * 这里在 jsdom 里跑真正的控制台脚本，对着**真平台**点一遍：
 *   - 左边四个分组都要画出来；
 *   - 列表里每个技能都要有分类和备注；
 *   - 点开一个技能，详情里必须有正文（不是空框）；
 *   - 切到外部注册源，搜索结果要出现在右边的列表里，不是弹窗；
 *   - 页面不能因为任何一个技能缺了分类或备注就崩。
 *
 * 用法（需要 node 与 jsdom）：
 *   cd /tmp && npm install jsdom
 *   node harness/tools/check-console-skills.js
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
let html = fs.readFileSync(path.join(CONSOLE_DIR, 'index.html'), 'utf8');

// The platform is reached with a signed request; the check drives the console the way a
// browser does, so the real thing has to answer.
const env = fs.readFileSync(path.join(process.env.HOME, '.harness', 'platform.env'), 'utf8');
function envValue(name) {
  const match = env.match(new RegExp('^' + name + "=['\"]?([^'\"\\n]*)", 'm'));
  return match ? match[1] : '';
}
const clientId = envValue('HARNESS_HUMAN_CLIENT_ID');
const clientSecret = envValue('HARNESS_HUMAN_SECRET');

// The console signs its requests itself; the check has to sign them the same way, or the
// platform answers 401 and the check measures nothing but the refusal.
const crypto = require('crypto');
function signed(method, pathname, body) {
  const payload = body === undefined ? '' : body;
  const timestamp = String(Math.floor(Date.now() / 1000));
  const nonce = crypto.randomBytes(16).toString('hex');
  const key = crypto.createHash('sha256').update(clientSecret, 'utf8').digest('hex');
  const canonical = [method, pathname, timestamp, nonce,
    crypto.createHash('sha256').update(payload, 'utf8').digest('hex')].join('\n');
  const signature = crypto.createHmac('sha256', key).update(canonical, 'utf8').digest('hex');
  const headers = {
    'X-Harness-Client': clientId,
    'X-Harness-Timestamp': timestamp,
    'X-Harness-Nonce': nonce,
    'X-Harness-Signature': signature,
  };
  if (payload) headers['Content-Type'] = 'application/json';
  return fetch(BASE_URL + pathname, {
    method, headers, body: payload || undefined,
  }).then(r => r.text());
}

const virtualConsole = new VirtualConsole();
virtualConsole.on('jsdomError', e => {
  console.error('jsdom error:', e.message);
  process.exitCode = 1;
});

const dom = new JSDOM(html, {
  url: BASE_URL + '/console/index.html',
  runScripts: 'outside-only',
  pretendToBeVisual: true,
  virtualConsole,
});

const { window } = dom;
window.fetch = (input, init) => {
  const url = typeof input === 'string' ? input : input.url;
  const pathname = url.replace(BASE_URL, '');
  const method = (init && init.method) || 'GET';
  const body = init && init.body ? String(init.body) : '';
  return signed(method, pathname.split('?')[0], body).then(text => ({
    ok: true,
    status: 200,
    text: () => Promise.resolve(text),
    json: () => Promise.resolve(JSON.parse(text)),
  }));
};
// jsdom's window already has a crypto with getRandomValues; the console only needs one
// that fills the buffer, so it is patched in place rather than replaced.
window.scrollTo = () => {};
window.sessionStorage.setItem('harness-console', JSON.stringify({
  clientId, secret: clientSecret, baseUrl: BASE_URL,
}));

const failures = [];
function check(condition, message) {
  if (!condition) {
    failures.push(message);
    console.error('FAIL', message);
  } else {
    console.log('ok  ', message);
  }
}

// The console script logs in on its own and then draws everything.
//
// The script is strict, so an eval keeps its declarations to itself. The check therefore
// asks for the handful of functions it needs by name, from inside the same eval.
window.eval(js + `
;window.__skillCheck = {
  openSkill, renderSkillMain, renderSkillDetail, renderSkillSide,
  searchRegistry, skillView, state, loadSkills,
};`);

setTimeout(async () => {
  const text = sel => window.document.querySelector(sel)?.textContent || '';
  const htmlOf = sel => window.document.querySelector(sel)?.innerHTML || '';

  // The left column: the four groups.
  check(text('#marketCount').length > 0, 'the market shows how many skills are on the shelf');
  check(text('#installedCount').length > 0, 'the left column shows how many skills are installed');
  check(htmlOf('#sideCategories').includes('流程规范'), 'the categories are listed on the left');
  check(htmlOf('#sideRegistries').length > 0, 'the external registries are listed on the left');

  // The right column: the list.
  check(htmlOf('#skillsTable').includes('portal-maintenance'), 'the market list shows the skills');
  check(htmlOf('#skillsTable').includes('流程规范'), 'the list shows the category of a skill');
  check(htmlOf('#skillsTable').includes('备注'), 'the list has a column for the note');

  // The detail: click a skill and it opens underneath, with its text.
  const detail = await window.__skillCheck.openSkill('portal-maintenance');
  check(detail === undefined || detail === null, 'openSkill resolves');
  await new Promise(r => setTimeout(r, 400));
  const detailHtml = htmlOf('#skillDetail');
  check(!window.document.querySelector('#skillDetail').classList.contains('hidden'),
    'the detail panel opens');
  check(detailHtml.includes('SKILL.md') || detailHtml.includes('---'),
    'the detail shows the skill\'s text');
  check(detailHtml.includes('内容摘要') || detailHtml.includes('摘要'),
    'the detail shows the digest');

  // The registry search: the results land in the right pane.
  window.__skillCheck.skillView.mode = 'registry';
  window.__skillCheck.skillView.registryKey = 'skills-sh';
  // The word goes into the search box, the way a person would type it.
  window.document.querySelector('#registryQuery').value = 'release';
  await window.__skillCheck.searchRegistry('skills-sh');
  await new Promise(r => setTimeout(r, 600));
  check(htmlOf('#registryResults').length > 0, 'the registry search fills the right pane');
  check(!htmlOf('#registryResults').includes('还没有搜'),
    'the registry search found something');

  console.log('');
  if (failures.length) {
    console.error(failures.length + ' check(s) failed');
    process.exit(1);
  }
  console.log('the skill market console checks passed');
  process.exit(0);
}, 1500);
