/* Harness 控制台前端。
 *
 * 平台接口是 HMAC 签名认证的（03 §9），不是 Cookie。这里的浏览器端自己做签名，
 * 所以控制台不需要后端再开一个"免鉴权"的洞——密钥只留在这一页的内存里。
 *
 * SHA-256/HMAC 用纯 JS 实现，而不是 WebCrypto：WebCrypto 只在 https 或 localhost 下可用，
 * 而这台机器常常是通过局域网 IP 用 http 访问的。
 */
'use strict';

// ---------------------------------------------------------------- SHA-256 / HMAC

const K = [
  0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
  0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
  0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
  0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
  0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
  0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
  0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
  0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2];

function sha256(bytes) {
  const h = [0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19];
  const len = bytes.length;
  const bitLenHi = Math.floor((len / 0x20000000) >>> 0);
  const bitLenLo = (len << 3) >>> 0;
  const withPad = new Uint8Array((((len + 8) >> 6) + 1) << 6);
  withPad.set(bytes);
  withPad[len] = 0x80;
  const dv = new DataView(withPad.buffer);
  dv.setUint32(withPad.length - 8, bitLenHi, false);
  dv.setUint32(withPad.length - 4, bitLenLo, false);

  const w = new Uint32Array(64);
  for (let off = 0; off < withPad.length; off += 64) {
    for (let i = 0; i < 16; i++) w[i] = dv.getUint32(off + i * 4, false);
    for (let i = 16; i < 64; i++) {
      const s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >>> 3);
      const s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >>> 10);
      w[i] = (w[i - 16] + s0 + w[i - 7] + s1) >>> 0;
    }
    let [a, b, c, d, e, f, g, hh] = h;
    for (let i = 0; i < 64; i++) {
      const S1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25);
      const ch = (e & f) ^ (~e & g);
      const t1 = (hh + S1 + ch + K[i] + w[i]) >>> 0;
      const S0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22);
      const maj = (a & b) ^ (a & c) ^ (b & c);
      const t2 = (S0 + maj) >>> 0;
      hh = g; g = f; f = e; e = (d + t1) >>> 0;
      d = c; c = b; b = a; a = (t1 + t2) >>> 0;
    }
    h[0] = (h[0] + a) >>> 0; h[1] = (h[1] + b) >>> 0; h[2] = (h[2] + c) >>> 0; h[3] = (h[3] + d) >>> 0;
    h[4] = (h[4] + e) >>> 0; h[5] = (h[5] + f) >>> 0; h[6] = (h[6] + g) >>> 0; h[7] = (h[7] + hh) >>> 0;
  }
  const out = new Uint8Array(32);
  const odv = new DataView(out.buffer);
  h.forEach((v, i) => odv.setUint32(i * 4, v >>> 0, false));
  return out;
}

function rotr(x, n) { return ((x >>> n) | (x << (32 - n))) >>> 0; }

function hmacSha256(keyBytes, messageBytes) {
  const block = 64;
  let key = keyBytes;
  if (key.length > block) key = sha256(key);
  const padded = new Uint8Array(block);
  padded.set(key);
  const oKey = new Uint8Array(block);
  const iKey = new Uint8Array(block);
  for (let i = 0; i < block; i++) { oKey[i] = padded[i] ^ 0x5c; iKey[i] = padded[i] ^ 0x36; }
  const inner = new Uint8Array(block + messageBytes.length);
  inner.set(iKey);
  inner.set(messageBytes, block);
  const innerHash = sha256(inner);
  const outer = new Uint8Array(block + innerHash.length);
  outer.set(oKey);
  outer.set(innerHash, block);
  return sha256(outer);
}

function utf8(str) { return new TextEncoder().encode(str); }
function toHex(bytes) { return Array.from(bytes).map(b => b.toString(16).padStart(2, '0')).join(''); }

// ---------------------------------------------------------------- 会话

const session = { clientId: '', secret: '', baseUrl: '', key: null };

function hexToBytes(hex) {
  const out = new Uint8Array(hex.length / 2);
  for (let i = 0; i < out.length; i++) out[i] = parseInt(hex.substr(i * 2, 2), 16);
  return out;
}

function setSession(clientId, secret, baseUrl) {
  session.clientId = clientId;
  session.secret = secret;
  session.baseUrl = baseUrl.replace(/\/+$/, '');
  // 签名密钥 = hex(sha256(secret)) 的 ASCII 字节（平台侧存的就是这个）
  session.key = utf8(toHex(sha256(utf8(secret))));
}

function nonce() {
  const buf = new Uint8Array(16);
  (window.crypto || {}).getRandomValues ? window.crypto.getRandomValues(buf)
    : buf.forEach((_, i) => buf[i] = Math.floor(Math.random() * 256));
  return toHex(buf);
}

async function api(method, path, body) {
  const payload = body === undefined ? null : JSON.stringify(body);
  const bodyBytes = payload === null ? new Uint8Array(0) : utf8(payload);
  const ts = String(Math.floor(Date.now() / 1000));
  const nc = nonce();
  // The signature covers the path WITHOUT the query string: the platform signs
  // request.getRequestURI(), which does not include it. The query is still sent.
  const signedPath = path.split('?')[0];
  const canonical = utf8(method.toUpperCase() + '\n' + signedPath + '\n' + ts + '\n' + nc + '\n'
    + toHex(sha256(bodyBytes)));
  const signature = toHex(hmacSha256(session.key, canonical));

  const headers = {
    'X-Harness-Client': session.clientId,
    'X-Harness-Timestamp': ts,
    'X-Harness-Nonce': nc,
    'X-Harness-Signature': signature,
  };
  if (payload !== null) headers['Content-Type'] = 'application/json';

  const res = await fetch(session.baseUrl + path, {
    method, headers, body: payload === null ? undefined : payload,
  });
  const text = await res.text();
  let parsed = null;
  try { parsed = text ? JSON.parse(text) : null; } catch (e) { parsed = { raw: text }; }
  if (!res.ok) {
    const code = parsed && parsed.error ? parsed.error.code : 'HTTP_' + res.status;
    const msg = parsed && parsed.error ? parsed.error.message : text;
    const err = new Error(code + ': ' + msg);
    err.code = code;
    err.status = res.status;
    throw err;
  }
  return parsed;
}

// ---------------------------------------------------------------- 小工具

const $ = (sel) => document.querySelector(sel);
const $$ = (sel) => Array.from(document.querySelectorAll(sel));

function esc(value) {
  return String(value === null || value === undefined ? '' : value)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

function toast(message, kind) {
  const el = $('#toast');
  el.textContent = message;
  el.className = 'toast ' + (kind || '');
  setTimeout(() => el.classList.add('hidden'), 3200);
}

function when(iso) {
  if (!iso) return '-';
  const d = new Date(iso);
  return isNaN(d) ? String(iso) : d.toLocaleString('zh-CN', { hour12: false });
}

function statusTag(status) {
  const map = {
    active: 'ok', online: 'ok', approved: 'ok', done: 'ok', released: 'ok', ok: 'ok', allow: 'ok',
    draft: 'grey', pending: 'warn', running: 'info', offline: 'bad', revoked: 'bad', failed: 'bad',
    denied: 'bad', reject: 'bad', retired: 'grey', paused: 'warn', suspected: 'bad', unbound: 'grey',
    binding: 'warn', expired: 'grey', cancelled: 'grey', used: 'info',
  };
  const cls = map[String(status).toLowerCase()] || 'grey';
  return '<span class="tag ' + cls + '">' + esc(status) + '</span>';
}

function levelTag(level) {
  const cls = level >= 3 ? 'bad' : level === 2 ? 'warn' : 'info';
  return '<span class="tag ' + cls + '">L' + level + '</span>';
}

function table(columns, rows, emptyText) {
  if (!rows || rows.length === 0) {
    return '<div class="empty">' + esc(emptyText || '暂无数据') + '</div>';
  }
  let html = '<table><thead><tr>';
  columns.forEach(c => html += '<th>' + esc(c.title) + '</th>');
  html += '</tr></thead><tbody>';
  rows.forEach(row => {
    html += '<tr>';
    columns.forEach(c => html += '<td class="' + (c.cls || '') + '">' + (c.render(row) || '') + '</td>');
    html += '</tr>';
  });
  return html + '</tbody></table>';
}

// ---------------------------------------------------------------- 弹窗

function modal(title, fields, onOk) {
  $('#modalTitle').textContent = title;
  const body = $('#modalBody');
  body.innerHTML = fields.map(f => {
    if (f.type === 'select') {
      return '<label>' + esc(f.label) + '<select id="f-' + f.name + '">'
        + f.options.map(o => '<option value="' + esc(o.value) + '"' + (o.selected ? ' selected' : '') + '>'
        + esc(o.label) + '</option>').join('') + '</select></label>';
    }
    if (f.type === 'textarea') {
      return '<label>' + esc(f.label) + '<textarea id="f-' + f.name + '" rows="3">'
        + esc(f.value || '') + '</textarea></label>';
    }
    return '<label>' + esc(f.label) + '<input id="f-' + f.name + '" type="'
      + (f.type || 'text') + '" value="' + esc(f.value === undefined ? '' : f.value) + '"></label>';
  }).join('');
  $('#modal').classList.remove('hidden');
  $('#modalOk').onclick = async () => {
    const values = {};
    fields.forEach(f => {
      const el = $('#f-' + f.name);
      values[f.name] = el ? el.value : '';
    });
    $('#modal').classList.add('hidden');
    try {
      await onOk(values);
    } catch (e) {
      toast(e.message, 'bad');
    }
  };
  $('#modalCancel').onclick = () => $('#modal').classList.add('hidden');
}

function confirmBox(title, message, onOk) {
  $('#modalTitle').textContent = title;
  $('#modalBody').innerHTML = '<p>' + esc(message) + '</p>';
  $('#modal').classList.remove('hidden');
  $('#modalOk').onclick = async () => {
    $('#modal').classList.add('hidden');
    try { await onOk(); } catch (e) { toast(e.message, 'bad'); }
  };
  $('#modalCancel').onclick = () => $('#modal').classList.add('hidden');
}

// ---------------------------------------------------------------- 数据

const state = { agents: [], terminals: [], approvals: [], grants: [], switches: [], events: [], audit: [], tasks: [] };

async function loadAll() {
  const [agents, terminals, approvals, grants, switches, audit] = await Promise.all([
    api('GET', '/api/harness/agent'),
    api('GET', '/api/harness/terminal'),
    api('GET', '/api/harness/approval?limit=50'),
    api('GET', '/api/harness/grant'),
    api('GET', '/api/harness/killswitch'),
    api('GET', '/api/harness/audit?limit=50'),
  ]);
  state.agents = agents || [];
  state.terminals = terminals || [];
  state.approvals = approvals || [];
  state.grants = grants || [];
  state.switches = switches || [];
  state.audit = audit || [];
  try {
    state.events = (await api('GET', '/api/harness/event/poll?limit=100')) || [];
  } catch (e) { state.events = []; }
  renderAll();
}

function renderAll() {
  renderOverview();
  renderAgents();
  renderTerminals();
  renderGrants();
  renderApprovals();
  renderSwitches();
  renderEvents();
  renderAudit();
}

function renderOverview() {
  const online = state.terminals.filter(t => t.status === 'online').length;
  const pending = state.approvals.filter(a => a.status === 'pending').length;
  const suspected = state.events.filter(e => e.status === 'suspected').length;
  const levels = [0, 0, 0, 0, 0];
  state.agents.forEach(a => { if (a.autonomyLevel >= 0 && a.autonomyLevel <= 4) levels[a.autonomyLevel]++; });
  const kpis = [
    { label: '数字员工', value: state.agents.length, cls: '' },
    { label: '在线终端', value: online + ' / ' + state.terminals.length, cls: online ? 'ok' : 'warn' },
    { label: '待审批', value: pending, cls: pending ? 'warn' : 'ok' },
    { label: '注入降级事件', value: suspected, cls: suspected ? 'bad' : 'ok' },
    { label: '生效的 Kill-Switch', value: state.switches.filter(s => s.active).length, cls: state.switches.filter(s => s.active).length ? 'bad' : 'ok' },
    { label: '自主等级分布', value: 'L0:' + levels[0] + ' L1:' + levels[1] + ' L2:' + levels[2] + ' L3:' + levels[3] + ' L4:' + levels[4], cls: 'small' },
  ];
  $('#kpis').innerHTML = kpis.map(k =>
    '<div class="kpi"><div class="label">' + esc(k.label) + '</div><div class="value ' + (k.cls || '') + '">'
    + esc(k.value) + '</div></div>').join('');

  $('#overviewAgents').innerHTML = state.agents.length ? state.agents.map(a =>
    '<div class="row"><span class="dot ' + (a.status === 'active' ? 'ok' : 'grey') + '"></span>'
    + '<span class="grow">' + esc(a.name || a.agentKey) + '</span>'
    + levelTag(a.autonomyLevel) + statusTag(a.status) + '</div>').join('')
    : '<div class="empty">还没有数字员工</div>';

  $('#overviewTerminals').innerHTML = state.terminals.length ? state.terminals.map(t =>
    '<div class="row"><span class="dot ' + (t.status === 'online' ? 'ok' : t.status === 'offline' ? 'warn' : 'bad') + '"></span>'
    + '<span class="grow mono">' + esc(t.terminalId).slice(0, 8) + '…</span>'
    + statusTag(t.status) + '</div>').join('')
    : '<div class="empty">还没有终端</div>';

  $('#overviewAudit').innerHTML = state.audit.length ? state.audit.slice(0, 8).map(a =>
    '<div class="row"><span class="dot ' + (a.outcome === 'allow' ? 'ok' : 'bad') + '"></span>'
    + '<span class="grow mono">' + esc(a.op) + '</span>'
    + '<span class="muted">' + esc(when(a.at)) + '</span></div>').join('')
    : '<div class="empty">还没有审计记录</div>';
}

function renderAgents() {
  $('#agentsTable').innerHTML = table([
    { title: '名称', render: a => esc(a.name || '-') + ' <span class="muted mono">' + esc(a.agentKey) + '</span>' },
    { title: '状态', render: a => statusTag(a.status) },
    { title: '自主等级', render: a => levelTag(a.autonomyLevel) },
    { title: '部门', render: a => esc(a.deptId) },
    { title: '责任人', render: a => esc(a.ownerId) },
    { title: 'portal 员工', render: a => esc(a.portalEmployeeId || '-') },
    {
      title: '操作', render: a => '<div class="row-actions">'
        + (a.status === 'draft' ? '<button class="tiny" data-act="onboard" data-id="' + esc(a.agentId) + '">入职 portal</button>' : '')
        + (a.status !== 'active' ? '<button class="tiny" data-act="activate" data-id="' + esc(a.agentId) + '">启用</button>' : '')
        + (a.status === 'active' ? '<button class="tiny" data-act="pause" data-id="' + esc(a.agentId) + '">暂停</button>' : '')
        + '<button class="tiny" data-act="grant" data-id="' + esc(a.agentId) + '">授权</button>'
        + '<button class="tiny" data-act="chat" data-id="' + esc(a.agentId) + '">对话</button>'
        + '</div>'
    },
  ], state.agents, '还没有数字员工。点"新建数字员工"开始。');
}

function renderTerminals() {
  $('#terminalsTable').innerHTML = table([
    { title: 'terminalId', render: t => '<span class="mono">' + esc(t.terminalId) + '</span>' },
    { title: '状态', render: t => statusTag(t.status) },
    { title: '绑定', render: t => esc(t.bindType || '-') + (t.agentId ? ' <span class="muted mono">' + esc(t.agentId).slice(0, 8) + '…</span>' : '') },
    { title: '平台员工', render: t => esc(t.portalEmployeeId || '-') },
    { title: '最后心跳', render: t => esc(when(t.lastHeartbeat)) },
    {
      title: '操作', render: t => '<div class="row-actions">'
        + '<button class="tiny" data-act="terminal-chat" data-id="' + esc(t.terminalId) + '">对话</button>'
        + '<button class="tiny" data-act="terminal-grant" data-id="' + esc(t.terminalId) + '">看授权</button>'
        + (t.status !== 'revoked' ? '<button class="tiny" data-act="terminal-revoke" data-id="' + esc(t.terminalId) + '">吊销</button>' : '')
        + '</div>'
    },
  ], state.terminals, '还没有终端。装好终端外壳并 hello 之后会出现在这里。');
}

function renderGrants() {
  $('#grantsTable').innerHTML = table([
    { title: 'Agent', render: g => '<span class="mono">' + esc((g.agentId || '').slice(0, 8)) + '…</span>' },
    { title: '能力', render: g => '<span class="mono">' + esc(g.capKey || g.capId || '') + '</span>' },
    { title: '作用域', render: g => '<span class="mono">' + esc(JSON.stringify(g.scope || {})) + '</span>' },
    { title: '到期', render: g => esc(when(g.expiresAt)) },
    { title: '授予人', render: g => '<span class="mono">' + esc(g.grantedBy || '') + '</span>' },
    { title: '状态', render: g => statusTag(g.status) },
    {
      title: '操作', render: g => '<button class="tiny" data-act="grant-revoke" data-id="' + esc(g.grantId) + '">吊销</button>'
    },
  ], state.grants, '还没有授权。');
}

function renderApprovals() {
  $('#approvalsTable').innerHTML = table([
    { title: '能力', render: a => '<span class="mono">' + esc(a.requestedCap) + '</span>' },
    { title: 'Agent', render: a => '<span class="mono">' + esc((a.agentId || '').slice(0, 8)) + '…</span>' },
    { title: '理由', render: a => esc((a.justification || '').slice(0, 80)) },
    { title: '风险', render: a => '<span class="tag ' + (a.riskClass === 'R4' ? 'bad' : 'warn') + '">' + esc(a.riskClass) + '</span>' },
    { title: '状态', render: a => statusTag(a.status) },
    { title: '决定人', render: a => '<span class="mono">' + esc(a.decidedBy || '-') + '</span>' },
    {
      title: '操作', render: a => a.status === 'pending'
        ? '<div class="row-actions">'
        + '<button class="tiny" data-act="approve" data-id="' + esc(a.approvalId) + '">批准</button>'
        + '<button class="tiny" data-act="reject" data-id="' + esc(a.approvalId) + '">驳回</button>'
        + '</div>'
        : '<span class="muted">已结</span>'
    },
  ], state.approvals, '没有待处理的审批。');
}

function renderSwitches() {
  $('#switchesTable').innerHTML = table([
    { title: '粒度', render: s => '<span class="tag info">' + esc(s.scope) + '</span>' },
    { title: '对象', render: s => '<span class="mono">' + esc(s.scopeId) + '</span>' },
    { title: '效果', render: s => '<span class="tag ' + (s.effect === 'halt' ? 'bad' : 'warn') + '">' + esc(s.effect) + '</span>' },
    { title: '原因', render: s => esc(s.reason || '') },
    { title: '启用', render: s => s.active ? statusTag('active') : statusTag('released') },
    { title: '操作', render: s => s.active ? '<button class="tiny" data-act="switch-release" data-id="' + esc(s.switchId) + '">解除</button>' : '' },
  ], state.switches, '没有拉下任何 Kill-Switch。');
}

function renderEvents() {
  $('#eventsTable').innerHTML = table([
    { title: '来源', render: e => esc(e.source) + ' / ' + esc(e.eventType) },
    { title: '状态', render: e => statusTag(e.status) },
    { title: '内容信任', render: e => esc(e.contentTrust) },
    { title: '合并计数', render: e => esc(e.dedupCount) },
    { title: '收到时间', render: e => esc(when(e.receivedAt)) },
    { title: 'payload', render: e => '<span class="mono">' + esc(JSON.stringify(e.payload || {}).slice(0, 120)) + '</span>' },
  ], state.events, '还没有事件。');
}

function renderAudit() {
  $('#auditTable').innerHTML = table([
    { title: '时间', render: a => esc(when(a.at)) },
    { title: '操作', render: a => '<span class="mono">' + esc(a.op) + '</span>' },
    { title: '对象', render: a => '<span class="mono">' + esc(a.objectType || '') + ' ' + esc((a.objectId || '').slice(0, 12)) + '</span>' },
    { title: '结果', render: a => statusTag(a.outcome) },
    { title: '原因码', render: a => '<span class="mono">' + esc(a.reasonCode || '') + '</span>' },
    { title: '执行人', render: a => '<span class="mono">' + esc(a.actorId || '') + '</span>' },
  ], state.audit, '还没有审计记录。');
}

// ---------------------------------------------------------------- 聊天

const chat = { terminalId: null, agentKey: '', poll: null, seen: new Set() };

function openChat(terminalId, title) {
  chat.terminalId = terminalId;
  $('#chatTitle').textContent = '与智能体对话';
  $('#chatSubtitle').textContent = title || ('终端 ' + String(terminalId).slice(0, 8) + '…');
  $('#chatHint').textContent = '终端需要配置 HARNESS_MODEL_API_KEY 才能处理自然语言。';
  $('#chat').classList.remove('hidden');
  $('#chatLog').innerHTML = '';
  pollTasks();
  if (chat.poll) clearInterval(chat.poll);
  chat.poll = setInterval(pollTasks, 2000);
}

function closeChat() {
  $('#chat').classList.add('hidden');
  if (chat.poll) clearInterval(chat.poll);
  chat.poll = null;
}

function addChat(who, text, kind) {
  const log = $('#chatLog');
  const div = document.createElement('div');
  div.className = 'chat-msg ' + (kind || '');
  div.innerHTML = '<div class="who">' + esc(who) + '</div><div class="bubble">' + esc(text) + '</div>';
  log.appendChild(div);
  log.scrollTop = log.scrollHeight;
}

async function pollTasks() {
  if (!chat.terminalId) return;
  let tasks = [];
  try {
    tasks = (await api('GET', '/api/harness/tasks?terminalId=' + encodeURIComponent(chat.terminalId) + '&limit=20')) || [];
  } catch (e) { return; }
  tasks.slice().reverse().forEach(task => {
    if (chat.seen.has(task.taskId)) return;
    chat.seen.add(task.taskId);
    addChat('我', task.prompt, 'me');
    if (task.status === 'done') {
      addChat('智能体', task.answer || '(没有回答)', 'agent');
      if (task.touched && task.touched.length) addChat('改动', task.touched.join('\n'), 'agent');
    } else if (task.status === 'failed') {
      addChat('失败', task.error || '未知错误', 'err');
    } else {
      addChat('状态', task.status, '');
    }
  });
}

// ---------------------------------------------------------------- 事件绑定

function bindEvents() {
  $$('#tabs .tab').forEach(tab => tab.addEventListener('click', () => {
    $$('#tabs .tab').forEach(t => t.classList.remove('active'));
    $$('.panel').forEach(p => p.classList.remove('active'));
    tab.classList.add('active');
    $('#tab-' + tab.dataset.tab).classList.add('active');
  }));

  $('#loginBtn').addEventListener('click', async () => {
    const clientId = $('#clientId').value.trim();
    const secret = $('#clientSecret').value.trim();
    const baseUrl = $('#baseUrl').value.trim();
    if (!clientId || !secret || !baseUrl) {
      $('#loginError').textContent = '三项都要填';
      return;
    }
    setSession(clientId, secret, baseUrl);
    try {
      await api('GET', '/api/harness/agent');
    } catch (e) {
      $('#loginError').textContent = e.message;
      return;
    }
    try { sessionStorage.setItem('harness-console', JSON.stringify({ clientId, secret, baseUrl })); } catch (e) { }
    $('#login').classList.add('hidden');
    $('#app').classList.remove('hidden');
    $('#who').textContent = clientId + ' @ ' + baseUrl;
    await loadAll();
  });

  $('#logoutBtn').addEventListener('click', () => {
    try { sessionStorage.removeItem('harness-console'); } catch (e) { }
    location.reload();
  });

  $('#refreshBtn').addEventListener('click', () => loadAll().then(() => toast('已刷新', 'ok')));

  $('#newAgentBtn').addEventListener('click', () => {
    modal('新建数字员工', [
      { name: 'agentKey', label: '业务键（唯一）', value: 'agent:' },
      { name: 'name', label: '显示名', value: 'leon' },
      { name: 'deptId', label: '部门 ID', value: '91' },
      { name: 'ownerId', label: '责任人（portal 员工 ID）', value: '1' },
      { name: 'level', label: '自主等级上限', type: 'select', options: [0, 1, 2, 3].map(v => ({ value: String(v), label: 'L' + v })) },
    ], async (v) => {
      await api('POST', '/api/harness/agent', {
        agentKey: v.agentKey, name: v.name, deptId: Number(v.deptId),
        ownerId: Number(v.ownerId), requestedLevel: Number(v.level),
      });
      toast('已创建', 'ok');
      await loadAll();
    });
  });

  $('#newGrantBtn').addEventListener('click', () => {
    modal('授予能力', [
      { name: 'agentId', label: 'Agent ID', value: state.agents.length ? state.agents[0].agentId : '' },
      { name: 'capKey', label: '能力键', value: 'cap:file.read' },
      { name: 'deptIds', label: '部门（逗号分隔）', value: '91' },
      { name: 'ttl', label: 'TTL 秒（≤86400）', value: '3600' },
      { name: 'reason', label: '理由', value: '控制台授权' },
    ], async (v) => {
      const deptIds = v.deptIds.split(',').map(s => Number(s.trim())).filter(n => !isNaN(n));
      await api('POST', '/api/harness/grant', {
        agentId: v.agentId, capKey: v.capKey, scope: { deptIds },
        ttlSeconds: Number(v.ttl), reason: v.reason,
      });
      toast('已授权', 'ok');
      await loadAll();
    });
  });

  $('#newSwitchBtn').addEventListener('click', () => {
    modal('拉下 Kill-Switch', [
      {
        name: 'scope', label: '粒度', type: 'select', options: [
          { value: 'global', label: '全局' }, { value: 'dept', label: '部门' },
          { value: 'agent', label: 'Agent' }, { value: 'capability', label: '能力' },
          { value: 'terminal', label: '终端' }],
      },
      { name: 'scopeId', label: '对象（全局填 *）', value: '*' },
      {
        name: 'effect', label: '效果', type: 'select', options: [
          { value: 'to_l0', label: '降到 L0（只读）' }, { value: 'stop', label: '停自主执行' },
          { value: 'halt', label: '全停' }],
      },
      { name: 'reason', label: '原因（必填）', value: '控制台操作' },
    ], async (v) => {
      await api('POST', '/api/harness/killswitch', {
        scope: v.scope, scopeId: v.scopeId, effect: v.effect, reason: v.reason,
      });
      toast('已拉下', 'ok');
      await loadAll();
    });
  });

  $('#verifyChainBtn').addEventListener('click', async () => {
    const result = await api('GET', '/api/harness/audit/verify');
    $('#chainResult').innerHTML = result.intact
      ? '<span class="tag ok">哈希链完整</span>'
      : '<span class="tag bad">链在 ' + esc(result.firstBrokenEntry) + ' 处断了</span>';
  });

  $('#chatClose').addEventListener('click', closeChat);
  $('#chatForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const prompt = $('#chatPrompt').value.trim();
    if (!prompt || !chat.terminalId) return;
    $('#chatPrompt').value = '';
    addChat('我', prompt, 'me');
    try {
      await api('POST', '/api/harness/terminal/' + encodeURIComponent(chat.terminalId) + '/tasks', { prompt });
      pollTasks();
    } catch (err) {
      addChat('发送失败', err.message, 'err');
    }
  });

  // 表格里的操作按钮
  document.addEventListener('click', async (e) => {
    const btn = e.target.closest('button[data-act]');
    if (!btn) return;
    const act = btn.dataset.act;
    const id = btn.dataset.id;
    try {
      if (act === 'activate') { await api('POST', '/api/harness/agent/' + id + '/lifecycle', { to: 'active', reason: '控制台启用' }); toast('已启用', 'ok'); }
      else if (act === 'pause') { await api('POST', '/api/harness/agent/' + id + '/lifecycle', { to: 'paused', reason: '控制台暂停' }); toast('已暂停', 'ok'); }
      else if (act === 'onboard') { await onboardModal(id); return; }
      else if (act === 'grant') { openGrantModal(id); return; }
      else if (act === 'chat') { const a = state.agents.find(x => x.agentId === id); openChat(terminalOfAgent(id), a ? (a.name || a.agentKey) : id); return; }
      else if (act === 'terminal-chat') { openChat(id, '终端 ' + id.slice(0, 8) + '…'); return; }
      else if (act === 'terminal-grant') { showGrant(id); return; }
      else if (act === 'terminal-revoke') { confirmBox('吊销终端', '吊销后这台设备 30 秒内失去全部能力，确定？', async () => { await api('POST', '/api/harness/terminal/' + id + '/revoke', { reason: '控制台吊销' }); toast('已吊销', 'ok'); }); return; }
      else if (act === 'approve') { decideApproval(id, 'approved'); return; }
      else if (act === 'reject') { decideApproval(id, 'rejected'); return; }
      else if (act === 'grant-revoke') { await api('POST', '/api/harness/grant/' + id + '/revoke', { reason: '控制台吊销' }); toast('已吊销授权', 'ok'); }
      else if (act === 'switch-release') { await api('DELETE', '/api/harness/killswitch/' + id + '?reason=' + encodeURIComponent('控制台解除')); toast('已解除', 'ok'); }
      await loadAll();
    } catch (err) {
      toast(err.message, 'bad');
    }
  });
}

function onboardModal(agentId) {
  modal('数字员工入职 portal', [
    { name: 'portalEmployeeId', label: 'portal 员工 ID（employee.id）', value: '' },
    { name: 'portalUserId', label: 'portal 用户 ID（users.UserID）', value: '' },
  ], async (v) => {
    await api('POST', '/api/harness/agent/' + agentId + '/onboard', {
      portalEmployeeId: Number(v.portalEmployeeId), portalUserId: Number(v.portalUserId),
    });
    toast('已入职', 'ok');
    await loadAll();
  });
}

function terminalOfAgent(agentId) {
  const t = state.terminals.find(x => x.agentId === agentId);
  return t ? t.terminalId : null;
}

function openGrantModal(agentId) {
  modal('给 Agent 授权', [
    { name: 'agentId', label: 'Agent ID', value: agentId },
    { name: 'capKey', label: '能力键', value: 'cap:file.read' },
    { name: 'deptIds', label: '部门（逗号分隔）', value: '91' },
    { name: 'ttl', label: 'TTL 秒（≤86400）', value: '3600' },
    { name: 'reason', label: '理由', value: '控制台授权' },
  ], async (v) => {
    const deptIds = v.deptIds.split(',').map(s => Number(s.trim())).filter(n => !isNaN(n));
    await api('POST', '/api/harness/grant', {
      agentId: v.agentId, capKey: v.capKey, scope: { deptIds },
      ttlSeconds: Number(v.ttl), reason: v.reason,
    });
    toast('已授权', 'ok');
    await loadAll();
  });
}

function decideApproval(approvalId, decision) {
  modal(decision === 'approved' ? '批准提权' : '驳回提权', [
    { name: 'note', label: decision === 'approved' ? '说明' : '驳回理由（必填）', value: '' },
  ], async (v) => {
    if (decision === 'rejected' && !v.note.trim()) throw new Error('驳回必须写理由');
    await api('POST', '/api/harness/approval/' + approvalId + '/decide', { decision, note: v.note });
    toast(decision === 'approved' ? '已签字' : '已驳回', 'ok');
    await loadAll();
  });
}

async function showGrant(terminalId) {
  try {
    const grant = await api('GET', '/api/harness/terminal/' + terminalId + '/grant');
    modal('终端的授权', [
      { name: 'info', label: '内容', type: 'textarea', value: JSON.stringify(grant, null, 2) },
    ], async () => { });
  } catch (e) {
    toast(e.message, 'bad');
  }
}

// ---------------------------------------------------------------- 启动

(async function start() {
  bindEvents();
  try {
    const saved = JSON.parse(sessionStorage.getItem('harness-console') || 'null');
    if (saved) {
      $('#clientId').value = saved.clientId;
      $('#clientSecret').value = saved.secret;
      $('#baseUrl').value = saved.baseUrl;
      setSession(saved.clientId, saved.secret, saved.baseUrl);
      await api('GET', '/api/harness/agent');
      $('#login').classList.add('hidden');
      $('#app').classList.remove('hidden');
      $('#who').textContent = saved.clientId + ' @ ' + saved.baseUrl;
      await loadAll();
    }
  } catch (e) { /* 存的不对就回到登录页 */ }
})();
