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
    // The skill market's own vocabulary.
    candidate: 'warn', evaluating: 'info', gray: 'info', deprecated: 'grey', rolled_back: 'grey',
    published: 'ok', installed: 'ok', updated: 'ok', removed: 'grey',
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
  // A hint under a field: what the value means, where it comes from, what happens with it.
  // A field nobody understands is a field somebody guesses at.
  const hint = (text) => text ? '<div class="field-hint">' + esc(text) + '</div>' : '';
  body.innerHTML = fields.map(f => {
    if (f.type === 'select') {
      return '<label>' + esc(f.label) + '<select id="f-' + f.name + '">'
        + f.options.map(o => '<option value="' + esc(o.value) + '"' + (o.selected ? ' selected' : '') + '>'
        + esc(o.label) + '</option>').join('') + '</select></label>' + hint(f.hint);
    }
    if (f.type === 'textarea') {
      return '<label>' + esc(f.label) + '<textarea id="f-' + f.name + '" rows="3">'
        + esc(f.value || '') + '</textarea></label>' + hint(f.hint);
    }
    if (f.type === 'static') {
      return '<label>' + esc(f.label) + '<div class="field-static">' + (f.value || '') + '</div></label>'
        + hint(f.hint);
    }
    return '<label>' + esc(f.label) + '<input id="f-' + f.name + '" type="'
      + (f.type || 'text') + '" value="' + esc(f.value === undefined ? '' : f.value) + '"></label>'
      + hint(f.hint);
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

const state = {
  agents: [], terminals: [], approvals: [], grants: [], switches: [], events: [], audit: [], tasks: [],
  skills: [], skillInstalls: [], skillRegistries: [],
  capabilities: [],
};

async function loadAll() {
  const [agents, terminals, approvals, grants, switches, audit, modelConfigs, principals] = await Promise.all([
    api('GET', '/api/harness/agent'),
    api('GET', '/api/harness/terminal'),
    api('GET', '/api/harness/approval?limit=50'),
    api('GET', '/api/harness/grant'),
    api('GET', '/api/harness/killswitch'),
    api('GET', '/api/harness/audit?limit=50'),
    api('GET', '/api/harness/model-config'),
    api('GET', '/api/harness/principal').catch(() => []),
  ]);
  // The capability catalogue: the grant dialog picks from it instead of asking for a key.
  const capabilities = await api('GET', '/api/harness/capability').catch(() => []);
  state.agents = agents || [];
  state.terminals = terminals || [];
  state.approvals = approvals || [];
  state.grants = grants || [];
  state.switches = switches || [];
  state.audit = audit || [];
  state.modelConfigs = modelConfigs || [];
  state.principals = principals || [];
  state.capabilities = capabilities || [];
  try {
    state.events = (await api('GET', '/api/harness/event/poll?limit=100')) || [];
  } catch (e) { state.events = []; }
  await loadSkills();
  // Without this the tables stay empty: loadAll fills the state, and something has to put
  // it on the screen.
  renderAll();
}

async function loadSkills() {
  // The market is a separate door: a principal without the skill scope still sees the rest of
  // the console. A failure here must not take the whole console down.
  try {
    state.skills = (await api('GET', '/api/harness/skill')) || [];
  } catch (e) { state.skills = []; }
  try {
    state.skillInstalls = (await api('GET', '/api/harness/skill/install')) || [];
  } catch (e) { state.skillInstalls = []; }
  try {
    state.skillRegistries = (await api('GET', '/api/harness/skill/registry')) || [];
  } catch (e) { state.skillRegistries = []; }
}

function renderAll() {
  renderOverview();
  renderAgents();
  renderTerminals();
  renderGrants();
  renderSkills();
  renderSkillInstalls();
  renderSkillRegistries();
  renderApprovals();
  renderModels();
  renderSwitches();
  renderEvents();
  renderAudit();
  renderTerminalPickers();
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
        + '<button class="tiny" data-act="agent-model" data-id="' + esc(a.agentId) + '">配置模型</button>'
        + '<button class="tiny" data-act="agent-install" data-id="' + esc(a.agentId) + '">安装命令</button>'
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
      title: '模型', render: t => {
        const config = modelConfigOf(t.terminalId);
        if (!config) return '<span class="muted">未配置</span>';
        return '<span class="tag info">' + esc(config.provider) + '</span> <span class="mono">'
          + esc(config.modelName) + '</span>';
      }
    },
    {
      title: '操作', render: t => '<div class="row-actions">'
        + '<button class="tiny" data-act="agent-install" data-id="' + esc(t.agentId || '') + '">安装命令</button>'
        + '<button class="tiny" data-act="principal-new" data-id="' + esc(t.agentId || '') + '">新建设备账号</button>'
        + '<button class="tiny" data-act="terminal-chat" data-id="' + esc(t.terminalId) + '">对话</button>'
        + '<button class="tiny" data-act="terminal-model" data-id="' + esc(t.terminalId) + '">配置模型</button>'
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

// ---------------------------------------------------------------- 技能市场

const SKILL_SOURCE_NAMES = { internal: '内部产出', external: '外部拉取' };
const SKILL_VISIBILITY_NAMES = { private: '仅自己', dept: '本部门', org: '全公司' };
const SKILL_STATUS_NAMES = {
  candidate: '候选', evaluating: '评审中', approved: '评审通过', gray: '灰度',
  released: '已发布', deprecated: '已下架', rolled_back: '已回滚',
};

/**
 * The market.
 *
 * The row tells the whole story of a skill: where it came from, whether anybody looked at it,
 * whether it is on the shelf, and who may see it. The buttons are what the caller's own
 * rights allow - a reviewer gets 评审, the author gets 提交, a department gets 拉取部署.
 */
function renderSkills() {
  const query = ($('#skillSearch') && $('#skillSearch').value || '').trim().toLowerCase();
  const rows = state.skills.filter(s => !query
    || (s.name || '').toLowerCase().includes(query)
    || (s.skillKey || '').toLowerCase().includes(query)
    || (s.publisher || '').toLowerCase().includes(query));

  $('#skillsTable').innerHTML = table([
    { title: '技能', render: s => esc(s.name || '-') + ' <span class="muted mono">' + esc(s.skillKey) + '</span>' },
    { title: '来源', render: s => '<span class="tag ' + (s.source === 'external' ? 'info' : 'grey') + '">'
        + esc(SKILL_SOURCE_NAMES[s.source] || s.source) + '</span>' },
    { title: '状态', render: s => statusTag(s.status) + ' ' + esc(SKILL_STATUS_NAMES[s.status] || '') },
    { title: '上架', render: s => s.listingStatus === 'published' ? '<span class="tag ok">在架</span>' : '<span class="tag grey">不在架</span>' },
    { title: '可见', render: s => '<span class="tag grey">' + esc(SKILL_VISIBILITY_NAMES[s.visibility] || s.visibility) + '</span>' },
    { title: '版本', render: s => 'v' + esc(s.version) },
    { title: '被拉取', render: s => esc(s.installCount) + ' 次' },
    {
      title: '操作', render: s => {
        let html = '<div class="row-actions">';
        html += '<button class="tiny" data-act="skill-view" data-id="' + esc(s.skillKey) + '">查看</button>';
        if (s.status === 'candidate') {
          html += '<button class="tiny" data-act="skill-submit" data-id="' + esc(s.skillKey) + '">提交评审</button>';
        }
        if (s.status === 'evaluating') {
          html += '<button class="tiny" data-act="skill-approve" data-id="' + esc(s.skillKey) + '">评审通过</button>';
          html += '<button class="tiny" data-act="skill-reject" data-id="' + esc(s.skillKey) + '">驳回</button>';
        }
        if (s.status === 'approved') {
          html += '<button class="tiny" data-act="skill-publish" data-id="' + esc(s.skillKey) + '">上架</button>';
        }
        if (s.listingStatus === 'published') {
          html += '<button class="tiny" data-act="skill-install" data-id="' + esc(s.skillKey) + '">拉取部署</button>';
          html += '<button class="tiny" data-act="skill-unlist" data-id="' + esc(s.skillKey) + '">下架</button>';
        }
        html += '</div>';
        return html;
      }
    },
  ], rows, '技能市场还是空的。新建一个，或者从外部市场拉一个进来。');
}

function renderSkillInstalls() {
  const targetNames = { agent: '数字员工', terminal: '终端', dept: '部门' };
  $('#skillInstallsTable').innerHTML = table([
    { title: '技能', render: i => '<span class="mono">' + esc(i.skillKey) + '</span> v' + esc(i.version) },
    { title: '装在', render: i => '<span class="tag info">' + esc(targetNames[i.targetType] || i.targetType) + '</span> '
        + '<span class="mono">' + esc(String(i.targetId || '').slice(0, 12)) + '</span>' },
    { title: '状态', render: i => statusTag(i.status) },
    { title: '操作人', render: i => '<span class="mono">' + esc(i.installedBy || '-') + '</span>' },
    { title: '时间', render: i => esc(when(i.updatedAt)) },
    {
      title: '操作', render: i => '<button class="tiny" data-act="skill-uninstall" data-id="' + esc(i.installId) + '">卸载</button>'
    },
  ], state.skillInstalls, '还没有拉取过任何技能。');
}

function renderSkillRegistries() {
  $('#skillRegistriesTable').innerHTML = table([
    { title: '注册源', render: r => esc(r.name) + ' <span class="muted mono">' + esc(r.registryKey) + '</span>' },
    { title: '搜索地址', render: r => '<span class="mono">' + esc(r.searchUrl || '-') + '</span>' },
    { title: '状态', render: r => r.enabled ? '<span class="tag ok">启用</span>' : '<span class="tag grey">停用</span>' },
    { title: '操作', render: r => '<button class="tiny" data-act="skill-search-registry" data-id="' + esc(r.registryKey) + '">搜索</button>' },
  ], state.skillRegistries, '还没有登记外部注册源。');
}

function renderApprovals() {  $('#approvalsTable').innerHTML = table([
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

function renderModels() {
  const scopeNames = { brain: '大脑（平台默认）', agent: '数字员工', terminal: '终端' };
  $('#modelsTable').innerHTML = table([
    { title: '作用域', render: m => '<span class="tag info">' + esc(scopeNames[m.scope] || m.scope) + '</span>' },
    { title: '对象', render: m => '<span class="mono">' + esc(m.scopeId) + '</span>' },
    { title: '服务', render: m => esc(m.provider) },
    { title: '模型', render: m => '<span class="mono">' + esc(m.modelName) + '</span>' },
    { title: '网关', render: m => '<span class="mono">' + esc(m.baseUrl || '-') + '</span>' },
    { title: '密钥', render: m => m.keyConfigured ? '<span class="tag ok">已配置</span>' : '<span class="tag warn">未配置</span>' },
    { title: '配置人', render: m => '<span class="mono">' + esc(m.createdBy) + '</span>' },
    {
      title: '操作', render: m => '<div class="row-actions">'
        + '<button class="tiny" data-act="model-edit" data-scope="' + esc(m.scope) + '" data-id="' + esc(m.scopeId) + '">改</button>'
        + '<button class="tiny" data-act="model-delete" data-scope="' + esc(m.scope) + '" data-id="' + esc(m.scopeId) + '">删</button>'
        + '</div>'
    },
  ], state.modelConfigs, '还没有配置模型。点「配置模型」给大脑或某个数字员工配一个。');
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

// What has been shown for each task, and the status it was shown in. A task is not "seen" -
// it is shown again whenever its state changes, otherwise the answer would never appear:
// the console looks at a task while it is still pending and then never looks again.
const chat = { terminalId: null, agentKey: '', poll: null, shown: new Map() };

// The platform's brain: a conversation about the platform, kept apart from the terminal
// chat (that one talks to an agent on a machine).
const brain = { sessionId: null, sending: false, sessions: [] };

function openChat(terminalId, title) {
  if (!terminalId) {
    // There is nobody to talk to. The panel must not keep showing the last conversation,
    // or every employee looks the same - the title still says the last one's name.
    closeChat();
    toast('这台终端还没有绑定智能体，先在「终端」里绑定', 'bad');
    return;
  }
  // The old poll is stopped before the new one starts: a poll that is still in flight
  // belongs to the previous terminal and would answer with the wrong conversation.
  if (chat.poll) { clearInterval(chat.poll); chat.poll = null; }
  chat.terminalId = terminalId;
  $('#chatTitle').textContent = '与智能体对话';
  $('#chatSubtitle').textContent = title || ('终端 ' + String(terminalId).slice(0, 8) + '…');
  $('#chatHint').textContent = '回车发送。智能体只能用它被授予的能力做事。';
  renderTerminalPickers();
  $('#chat').classList.remove('hidden');
  $('#chatLog').innerHTML = '';
  chat.shown.clear();
  pollTasks();
  chat.poll = setInterval(pollTasks, 2000);
  $('#chatPrompt').focus();
}

/** The terminal pickers: one in the chat header, one on the chat tab. */
function renderTerminalPickers() {
  const options = state.terminals.map(t =>
    '<option value="' + esc(t.terminalId) + '"' + (t.terminalId === chat.terminalId ? ' selected' : '')
    + '>' + esc((t.agentId ? t.agentId.slice(0, 8) : t.terminalId.slice(0, 8)) + ' · ' + t.status) + '</option>'
  ).join('');
  $('#chatTerminalPicker').innerHTML = options;
  $('#chatTerminalSelect').innerHTML = options;
  if (chat.terminalId) {
    $('#chatTerminalPicker').value = chat.terminalId;
    $('#chatTerminalSelect').value = chat.terminalId;
  }
}

/** The recent tasks of the selected terminal, on the chat tab. */
function renderChatRecent() {
  const terminalId = $('#chatTerminalSelect').value || (state.terminals[0] && state.terminals[0].terminalId);
  if (!terminalId) {
    $('#chatRecent').innerHTML = '<div class="empty">还没有终端</div>';
    return;
  }
  api('GET', '/api/harness/tasks?terminalId=' + encodeURIComponent(terminalId) + '&limit=8')
    .then(tasks => {
      $('#chatRecent').innerHTML = (tasks || []).length ? tasks.map(t =>
        '<div class="row"><span class="dot ' + (t.status === 'done' ? 'ok' : t.status === 'failed' ? 'bad' : 'warn')
        + '"></span><span class="grow">' + esc(t.prompt) + '</span>'
        + '<span class="muted">' + esc(t.answer || t.error || t.status).slice(0, 60) + '</span></div>').join('')
        : '<div class="empty">还没有对话记录</div>';
    })
    .catch(() => { $('#chatRecent').innerHTML = '<div class="empty">读不到记录</div>'; });
}

function closeChat() {
  $('#chat').classList.add('hidden');
  if (chat.poll) clearInterval(chat.poll);
  chat.poll = null;
  // The log goes with the panel: a conversation that stays behind the next one is the
  // next one's first impression.
  $('#chatLog').innerHTML = '';
  $('#chatSubtitle').textContent = '';
  chat.terminalId = null;
  chat.shown.clear();
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
    // The last 20 tasks: the chat shows the recent history, not everything ever asked.
    tasks = (await api('GET', '/api/harness/tasks?terminalId=' + encodeURIComponent(chat.terminalId) + '&limit=20')) || [];
    // Only this terminal's tasks. The request already filters, but a response that was
    // on its way when the user switched terminals must not be shown under the new one.
    tasks = tasks.filter(t => !t.terminalId || t.terminalId === chat.terminalId);
    chat.lastError = null;
  } catch (e) {
    // A failing poll used to be swallowed, so the panel said "pending" for ever while the
    // terminal had already answered. Say it instead.
    if (chat.lastError !== e.message) {
      chat.lastError = e.message;
      addChat('读取失败', e.message + '（面板停在旧状态，可能是浏览器缓存了旧的脚本：Ctrl+Shift+R 强刷）', 'err');
    }
    return;
  }
  tasks.slice().reverse().forEach(task => {
    const last = chat.shown.get(task.taskId);
    if (last === task.status) {
      return; // nothing changed since the last look
    }
    const first = last === undefined;
    chat.shown.set(task.taskId, task.status);
    if (first) {
      addChat('我', task.prompt, 'me');
    }
    if (task.status === 'done') {
      addChat('智能体', task.answer || '(没有回答)', 'agent');
      if (task.touched && task.touched.length) addChat('改动', task.touched.join('\n'), 'agent');
      if (task.transcript && task.transcript.length) {
        addChat('轨迹', task.transcript.map(t =>
          (t.kind || '') + (t.tool ? ':' + t.tool : '') + (t.ok === false ? ' (被拒)' : '')).join('\n'), '');
      }
    } else if (task.status === 'failed') {
      addChat('失败', task.error || '未知错误', 'err');
    } else if (task.status === 'running') {
      if (first) addChat('状态', '终端正在处理…', '');
    } else if (first) {
      addChat('状态', task.status, '');
    }
  });
}

// ---------------------------------------------------------------- 大脑（平台自己）

/** The conversation list on the left. */
async function renderBrainSessions() {
  brain.sessions = await api('GET', '/api/harness/brain/sessions').catch(() => []);
  const list = $('#brainSessions');
  if (!brain.sessions.length) {
    list.innerHTML = '<div class="empty">还没有会话</div>';
    return;
  }
  list.innerHTML = brain.sessions.map(s =>
    '<div class="row' + (s.sessionId === brain.sessionId ? ' row-active' : '') + '"'
    + ' data-session="' + esc(s.sessionId) + '">'
    + '<span class="grow">' + esc(s.title || '(无题)') + '</span>'
    + '<span class="muted small">' + esc(when(s.touchedAt)) + '</span></div>').join('');
}

/** Opens a session: its turns are put back into the log. */
async function openBrainSession(sessionId) {
  brain.sessionId = sessionId;
  $('#brainLog').innerHTML = '';
  $('#brainTools').textContent = '';
  if (!sessionId) {
    $('#brainTitle').textContent = '与平台大脑对话';
    $('#brainSubtitle').textContent = '它回答关于这个平台的问题';
    await renderBrainSessions();
    $('#brainPrompt').focus();
    return;
  }
  const answer = await api('GET', '/api/harness/brain/sessions/' + encodeURIComponent(sessionId));
  $('#brainTitle').textContent = (answer.session && answer.session.title) || '与平台大脑对话';
  $('#brainSubtitle').textContent = '会话 ' + sessionId.slice(0, 8);
  (answer.turns || []).forEach(turn => {
    addBrain(turn.role === 'user' ? '我' : '大脑', turn.content);
  });
  await renderBrainSessions();
  $('#brainPrompt').focus();
}

/** One message in the brain's log. */
function addBrain(who, text) {
  const log = $('#brainLog');
  const div = document.createElement('div');
  div.className = 'chat-msg ' + (who === '我' ? 'me' : 'agent');
  div.innerHTML = '<div class="who">' + esc(who) + '</div><div class="bubble">' + esc(text) + '</div>';
  log.appendChild(div);
  log.scrollTop = log.scrollHeight;
}

/** Sends a question to the brain. */
async function askBrain() {
  const prompt = $('#brainPrompt').value.trim();
  if (!prompt || brain.sending) return;
  brain.sending = true;
  $('#brainSend').disabled = true;
  $('#brainPrompt').value = '';
  addBrain('我', prompt);
  const pending = document.createElement('div');
  pending.className = 'chat-msg agent';
  pending.innerHTML = '<div class="who">大脑</div><div class="bubble">正在查…</div>';
  $('#brainLog').appendChild(pending);
  if (pending.scrollIntoView) pending.scrollIntoView();
  try {
    const answer = await api('POST', '/api/harness/brain/chat', {
      sessionId: brain.sessionId, message: prompt,
    });
    brain.sessionId = answer.sessionId;
    pending.remove();
    addBrain('大脑', answer.answer);
    $('#brainTools').textContent = (answer.toolsUsed || []).length
      ? '查了：' + answer.toolsUsed.join('、') : '';
    $('#brainTitle').textContent = prompt.slice(0, 24);
    await renderBrainSessions();
  } catch (e) {
    pending.remove();
    addBrain('大脑', '没答上来：' + e.message);
  } finally {
    brain.sending = false;
    $('#brainSend').disabled = false;
    $('#brainPrompt').focus();
  }
}

// ---------------------------------------------------------------- 事件绑定

function bindEvents() {
  $$('#tabs .tab').forEach(tab => tab.addEventListener('click', async () => {
    $$('#tabs .tab').forEach(t => t.classList.remove('active'));
    $$('.panel').forEach(p => p.classList.remove('active'));
    tab.classList.add('active');
    $('#tab-' + tab.dataset.tab).classList.add('active');
    if (tab.dataset.tab === 'chat') {
      renderTerminalPickers();
      renderChatRecent();
    }
    if (tab.dataset.tab === 'brain') {
      await renderBrainSessions();
      $('#brainPrompt').focus();
    }
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

  // The skill market's own buttons.
  $('#newSkillBtn').addEventListener('click', newSkillModal);
  $('#newRegistryBtn').addEventListener('click', newRegistryModal);
  $('#pullSkillBtn').addEventListener('click', () => {
    if (!state.skillRegistries.length) {
      toast('还没有外部注册源。先登记一个，再从里面拉。', 'warn');
      return;
    }
    searchRegistry(state.skillRegistries[0].registryKey);
  });
  $('#skillSearch').addEventListener('input', renderSkills);

  // The permanent entry point: ask the agent without hunting for a button.
  $('#askBtn').addEventListener('click', () => {
    const terminal = state.terminals.find(t => t.status === 'online') || state.terminals[0];
    openChat(terminal && terminal.terminalId, terminal ? ('终端 ' + terminal.terminalId.slice(0, 8) + '…') : null);
  });

  $('#openChatBtn').addEventListener('click', () => {
    const terminalId = $('#chatTerminalSelect').value;
    openChat(terminalId, '终端 ' + String(terminalId || '').slice(0, 8) + '…');
  });

  $('#chatTerminalSelect').addEventListener('change', () => {
    renderChatRecent();
  });

  $('#chatTerminalPicker').addEventListener('change', (e) => {
    openChat(e.target.value, '终端 ' + e.target.value.slice(0, 8) + '…');
  });

  $('#brainNewBtn').addEventListener('click', async () => {
    await openBrainSession(null);
  });
  $('#brainForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    await askBrain();
  });
  $('#brainSessions').addEventListener('click', async (e) => {
    const row = e.target.closest('[data-session]');
    if (!row) return;
    await openBrainSession(row.dataset.session);
  });

  $('#newAgentBtn').addEventListener('click', () => {
    modal('新建数字员工', [
      { name: 'agentKey', label: '业务键（唯一）', value: 'agent:' },
      { name: 'name', label: '显示名', value: 'leon' },
      { name: 'deptId', label: '部门 ID', value: '91' },
      { name: 'ownerId', label: '责任人（portal 员工 ID，必须是真人）', value: '1' },
      {
        name: 'level', label: '自主等级（它能自己做到哪一步）', type: 'select', options: [
          { value: '0', label: 'L0 观察 —— 只读、只汇报，不改任何东西' },
          { value: '1', label: 'L1 建议 —— 出建议/草稿，人来执行' },
          { value: '2', label: 'L2 低风险写 —— 改自己的工单、草稿、测试环境' },
          { value: '3', label: 'L3 中风险写 —— 动生产但可回滚，事后要报备' },
        ],
      },
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

  $('#newDeviceAccountBtn').addEventListener('click', () => {
    newDeviceAccount('');
  });

  $('#installCommandBtn').addEventListener('click', () => {
    installWizard('');
  });

  $('#newModelBtn').addEventListener('click', () => {
    modelModal('brain', '*');
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
      else if (act === 'agent-model') { modelModal('agent', id); return; }
      else if (act === 'agent-install') { installWizard(id); return; }
      else if (act === 'principal-new') { newDeviceAccount(id); return; }
      else if (act === 'chat') {
        const a = state.agents.find(x => x.agentId === id);
        const name = a ? (a.name || a.agentKey) : id;
        const terminalId = terminalOfAgent(id);
        if (!terminalId) {
          // This employee has no device yet. Say which one - and take the previous
          // conversation off the screen, so the panel never shows somebody else's chat.
          closeChat();
          toast('数字员工 ' + name + ' 还没有绑定终端。先在「终端」页签把这台设备绑定给它。', 'bad');
          return;
        }
        openChat(terminalId, name);
        return;
      }
      else if (act === 'terminal-chat') { openChat(id, '终端 ' + id.slice(0, 8) + '…'); return; }
      else if (act === 'terminal-grant') { showGrant(id); return; }
      else if (act === 'terminal-model') { modelModal('terminal', id); return; }
      else if (act === 'model-edit') { modelModal(btn.dataset.scope, btn.dataset.id); return; }
      else if (act === 'model-delete') {
        await api('DELETE', '/api/harness/model-config?scope=' + encodeURIComponent(btn.dataset.scope)
          + '&scopeId=' + encodeURIComponent(btn.dataset.id));
        toast('已删除', 'ok');
        await loadAll();
        return;
      }
      else if (act === 'terminal-revoke') { confirmBox('吊销终端', '吊销后这台设备 30 秒内失去全部能力，确定？', async () => { await api('POST', '/api/harness/terminal/' + id + '/revoke', { reason: '控制台吊销' }); toast('已吊销', 'ok'); }); return; }
      else if (act === 'approve') { decideApproval(id, 'approved'); return; }
      else if (act === 'reject') { decideApproval(id, 'rejected'); return; }
      else if (act === 'grant-revoke') { await api('POST', '/api/harness/grant/' + id + '/revoke', { reason: '控制台吊销' }); toast('已吊销授权', 'ok'); }
      else if (act === 'switch-release') { await api('DELETE', '/api/harness/killswitch/' + id + '?reason=' + encodeURIComponent('控制台解除')); toast('已解除', 'ok'); }
      else if (act === 'skill-view') { showSkill(id); return; }
      else if (act === 'skill-submit') { await api('POST', '/api/harness/skill/' + id + '/submit', { reason: '控制台提交评审' }); toast('已提交评审', 'ok'); }
      else if (act === 'skill-approve') { skillReason('评审通过', '通过的理由', async (reason) => { await api('POST', '/api/harness/skill/' + id + '/approve', { reason }); toast('已评审通过', 'ok'); }); return; }
      else if (act === 'skill-reject') { skillReason('驳回', '驳回的理由（作者要看得懂为什么）', async (reason) => { await api('POST', '/api/harness/skill/' + id + '/reject', { reason }); toast('已驳回', 'ok'); }); return; }
      else if (act === 'skill-publish') { skillReason('上架', '上架的理由', async (reason) => { await api('POST', '/api/harness/skill/' + id + '/publish', { reason }); toast('已上架', 'ok'); }); return; }
      else if (act === 'skill-unlist') { skillReason('下架', '下架的理由（会写进审计）', async (reason) => { await api('POST', '/api/harness/skill/' + id + '/unlist', { reason }); toast('已下架，已装的地方也会撤掉', 'ok'); }); return; }
      else if (act === 'skill-install') { installSkillModal(id); return; }
      else if (act === 'skill-uninstall') { await api('DELETE', '/api/harness/skill/install/' + id + '?reason=' + encodeURIComponent('控制台卸载')); toast('已卸载', 'ok'); }
      else if (act === 'skill-search-registry') { searchRegistry(id); return; }
      await loadAll();
    } catch (err) {
      toast(err.message, 'bad');
    }
  });
}

/**
 * Hires a digital employee into the portal.
 *
 * <p>The portal has its own employee table; until the digital employee is in it, it does not
 * exist for the people who work there. The platform writes the row - it knows the name, the
 * department and the agent key. This dialog shows exactly what will be written before
 * anything is written, because the write is not undone by clicking elsewhere.
 */
async function onboardModal(agentId) {
  const agent = state.agents.find(a => a.agentId === agentId);
  const name = agent ? (agent.name || agent.agentKey) : agentId;
  let preview;
  try {
    preview = await api('GET', '/api/harness/agent/' + agentId + '/onboard/preview');
  } catch (e) {
    toast('看不到将要写入的内容：' + e.message, 'bad');
    return;
  }
  if (!preview.portalConfigured) {
    toast('平台没有配置 portal：' + (preview.portalMissing || ''), 'bad');
    return;
  }
  if (preview.alreadyOnboarded) {
    toast('已经入职过了（portal 员工 ID ' + preview.portalEmployeeId + '）', 'bad');
    return;
  }
  const rows = [
    ['姓名', preview.name],
    ['所属部门', '部门 ID ' + preview.deptId + '（数字员工自己的部门，不是根部门）'],
    ['工号', preview.employeeNumber + '（数字员工前缀，与正常员工的纯数字工号区分开）'],
    ['登录名', preview.loginName],
    ['业务键', preview.agentKey],
  ];
  modal('数字员工入职 portal：' + name, [
    {
      name: 'summary', label: '将写入 portal 的内容', type: 'static',
      value: '<table class="kv">' + rows.map(r =>
        '<tr><th>' + esc(r[0]) + '</th><td>' + esc(r[1]) + '</td></tr>').join('') + '</table>',
      hint: 'portal 那边会新建一条员工记录和一个登录账号（账号是 AI，不能登录），'
        + '并把它放进上面这个部门。确认后平台去写，并把返回的员工 ID 记到这个数字员工身上。',
    },
  ], async () => {
    const result = await api('POST', '/api/harness/agent/' + agentId + '/onboard');
    toast('已入职 portal：员工 ID ' + (result.employeeId || '?'), 'ok');
    await loadAll();
  });
}

function modelConfigOf(terminalId) {
  const terminal = state.terminals.find(t => t.terminalId === terminalId);
  const candidates = [
    { scope: 'terminal', scopeId: terminalId },
    terminal && terminal.agentId ? { scope: 'agent', scopeId: terminal.agentId } : null,
    { scope: 'global', scopeId: '*' },
  ].filter(Boolean);
  for (const candidate of candidates) {
    const found = state.modelConfigs.find(c => c.scope === candidate.scope && c.scopeId === candidate.scopeId);
    if (found) return found;
  }
  return null;
}

/**
 * The terminal to talk to for one employee.
 *
 * An employee can have more than one terminal - a new machine replaces an old one. The one
 * that is actually talking is the online one, and among those the one that spoke last;
 * picking the first row of the list would open the conversation of a machine that is gone.
 */
function terminalOfAgent(agentId) {
  // The platform says which terminal is speaking for this employee - it owns the data and
  // the rule. The list below is the fallback for a platform that does not say yet.
  const agent = state.agents.find(a => a.agentId === agentId);
  if (agent && agent.terminalId) return agent.terminalId;
  const mine = state.terminals.filter(x => x.agentId === agentId);
  if (!mine.length) return null;
  const alive = mine.filter(t => t.status === 'online');
  const pool = (alive.length ? alive : mine).slice();
  pool.sort((a, b) => String(b.lastHeartbeat || '').localeCompare(String(a.lastHeartbeat || '')));
  return pool[0].terminalId;
}

/**
 * Grants one capability to one employee.
 *
 * <p>The capability is picked from the catalogue, not typed: the list says what each one
 * does, whether it needs a human and which autonomy level it needs. The department says where
 * the grant applies - the employee may only act on rows of those departments - and an empty
 * list means "wherever the platform lets it".
 */
function openGrantModal(agentId) {
  const agent = state.agents.find(a => a.agentId === agentId);
  const name = agent ? (agent.name || agent.agentKey) : agentId;
  const catalog = (state.capabilities || []);
  const options = catalog.length
    ? catalog.map(c => ({
      value: c.capKey,
      label: c.capKey + ' — ' + (c.name || '') + '（' + sideEffectText(c.sideEffect)
        + ' · ' + c.riskClass + ' · 至少 L' + c.minLevel + (c.requiresHuman ? ' · 需人工确认' : '') + '）',
      selected: c.capKey === 'cap:file.read',
    }))
    : [{ value: '', label: '（能力目录读不到）' }];

  modal('给数字员工授权：' + name, [
    { name: 'agentId', label: '数字员工', value: name + '（' + agentId + '）' },
    {
      name: 'capKey', label: '能力（选一项）', type: 'select', options,
      hint: '每条能力是一次授权。列表里写了这个能力做什么、会不会留下痕迹、风险等级、'
        + '以及它至少需要多大的自主等级。',
    },
    {
      name: 'deptIds', label: '生效部门（逗号分隔的部门 ID）',
      value: agent && agent.deptId ? String(agent.deptId) : '',
      hint: '这条授权只在这些部门的数据上生效——它决定「能改什么」，不是「人在哪个部门」。'
        + '留空表示不限定部门（只受别的闸门限制）。',
    },
    {
      name: 'ttl', label: '有效时长（秒）', value: '3600',
      hint: '授权到期自动收回，上限 24 小时（86400）。临时授权填短一点。',
    },
    { name: 'reason', label: '理由', value: '控制台授权', hint: '会写进审计：谁、为什么、给了什么。' },
  ], async (v) => {
    if (!v.capKey) throw new Error('先选一项能力');
    const deptIds = v.deptIds.split(',').map(s => Number(s.trim())).filter(n => !isNaN(n) && n > 0);
    const ttl = Number(v.ttl);
    if (!ttl || ttl <= 0) throw new Error('有效时长要是正数');
    await api('POST', '/api/harness/grant', {
      agentId: v.agentId, capKey: v.capKey, scope: { deptIds },
      ttlSeconds: ttl, reason: v.reason,
    });
    toast('已授权：' + v.capKey, 'ok');
    await loadAll();
  });
}

/** What a side effect means, in words. */
function sideEffectText(sideEffect) {
  return { read: '只读', write: '会改数据', exec: '会执行命令', irreversible: '不可逆' }[sideEffect]
    || String(sideEffect || '');
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

/**
 * The installation command for another machine.
 *
 * The platform knows the platform address, the client ids and the agent's business key. It does
 * NOT know the secret - it only stores sha256(secret) - so that part is a placeholder the
 * operator fills in from the platform's own configuration.
 */
function installWizard(agentId) {
  const agent = agentId ? state.agents.find(a => a.agentId === agentId) : state.agents[0];
  const client = state.principals.find(p => p.principalType === 'service')
    || state.principals[0] || { clientId: 'harness-bootstrap' };
  const agentKey = agent ? agent.agentKey : 'agent:<业务键>';
  const platform = session.baseUrl;

  const bundle = [
    '# 1) 在构建机上打包（缺什么它会自己先编）',
    './harness/tools/install-terminal.sh bundle /tmp/harness-terminal /tmp/harness-terminal.tar.gz',
  ].join('\n');

  const install = [
    '# 2) 拷到目标机器（Ubuntu 24.04）后安装',
    'tar xzf harness-terminal.tar.gz && cd harness-terminal',
    './install.sh \\',
    '    --platform ' + platform + ' \\',
    '    --agent-key ' + agentKey + ' \\',
    '    --client-id ' + client.clientId + ' \\',
    '    --client-secret <平台的 HARNESS_BOOTSTRAP_SECRET>',
  ].join('\n');

  const after = [
    '# 3) 报到，拿绑定码（10 分钟有效）',
    '~/.harness/terminal/harness-agent device hello',
    '',
    '# 4) 请自然人在管理台输入绑定码，绑定这台设备',
    '',
    '# 5) 取回授权（平台 → 这台机器 → 智能体读同一份文件）',
    '~/.harness/terminal/harness-agent device grant',
  ].join('\n');

  const secret = '客户端密钥：平台只存 sha256(secret)，平台自己给不出来。\n'
    + '它在平台的部署配置里（本机是 ~/.harness/platform.env 的 HARNESS_BOOTSTRAP_SECRET）。';

  modal('安装命令 · ' + (agent ? (agent.name || agent.agentKey) : '终端'), [
    { name: 'bundle', label: '① 在构建机上打包', type: 'textarea', value: bundle },
    { name: 'install', label: '② 在目标机器上安装', type: 'textarea', value: install },
    { name: 'after', label: '③ 装完这三步', type: 'textarea', value: after },
    { name: 'secret', label: '关于密钥', type: 'textarea', value: secret },
  ], async () => { });
}

/**
 * Creates a machine account for a device.
 *
 * Every device gets its own account: a shared one would mean that one lost machine
 * can impersonate all of them, and that revoking one device revokes all of them
 * (red-team R-01). The secret is shown once, here, and the platform keeps only its
 * sha256 - so the console can hand it to the installer but can never show it again.
 */
function newDeviceAccount(agentId) {
  const agent = agentId ? state.agents.find(a => a.agentId === agentId) : null;
  modal('新建设备账号', [
    { name: 'agentKey', label: '这台设备服务哪个数字员工（可空）', value: agent ? agent.agentKey : '' },
  ], async (v) => {
    const created = await api('POST', '/api/harness/principal', { agentKey: v.agentKey || '' });
    const command = [
      './install.sh \\',
      '    --platform ' + session.baseUrl + ' \\',
      '    --agent-key ' + (v.agentKey || '<数字员工业务键>') + ' \\',
      '    --client-id ' + created.clientId + ' \\',
      '    --client-secret ' + created.secret,
    ].join('\n');
    modal('设备账号已创建（密钥只显示这一次）', [
      { name: 'id', label: 'client id', type: 'textarea', value: created.clientId },
      { name: 'cmd', label: '安装命令', type: 'textarea', value: command },
    ], async () => {
      await loadAll();
    });
  });
}

function modelModal(scope, scopeId) {
  const existing = (scope || 'brain') === 'brain'
    ? state.modelConfigs.find(c => c.scope === 'brain')
    : (scope === 'terminal' ? modelConfigOf(scopeId) : state.modelConfigs.find(c => c.scope === 'agent' && c.scopeId === scopeId));
  const scopeName = { brain: '大脑（平台默认）', agent: '数字员工', terminal: '终端' }[scope] || scope;
  modal('配置模型 · ' + scopeName, [
    {
      name: 'scope', label: '作用域', type: 'select',
      options: [
        { value: 'brain', label: '大脑（平台默认）' },
        { value: 'agent', label: '数字员工' },
        { value: 'terminal', label: '终端' },
      ],
    },
    {
      name: 'scopeId', label: '对象（大脑填 *，数字员工/终端填 ID）',
      value: scope === 'brain' ? '*' : (scopeId || ''),
    },
    {
      name: 'provider', label: '模型服务', type: 'select',
      options: [{ value: 'openai', label: 'OpenAI 兼容（vLLM / llama.cpp / LMDeploy）' },
                { value: 'anthropic', label: 'Anthropic' }],
    },
    { name: 'modelName', label: '模型名', value: existing ? existing.modelName : 'Qwen3.8-27B' },
    {
      name: 'baseUrl', label: '网关地址（可空；填 /v1 这种基址即可，路径会自动补）',
      value: existing ? existing.baseUrl : '',
    },
    {
      name: 'apiKey', label: existing && existing.keyConfigured
        ? 'API 密钥（已配置；要换就填新的）' : 'API 密钥',
      type: 'password', value: '',
    },
  ], async (v) => {
    if (!v.apiKey) {
      throw new Error('要配置模型就得给一个 API 密钥');
    }
    await api('POST', '/api/harness/model-config', {
      scope: v.scope, scopeId: v.scopeId || '*', provider: v.provider,
      modelName: v.modelName, baseUrl: v.baseUrl || null, apiKey: v.apiKey,
    });
    toast('模型已配置，终端会在一分钟内取到', 'ok');
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

/**
 * Shows a skill: its text, its versions and where it is installed.
 *
 * The text is shown as it is - the skill is content, and content can be hostile. It is never
 * rendered as HTML, and it never becomes a tool argument (02 R-05, ADR-011).
 */
async function showSkill(skillKey) {
  try {
    const detail = await api('GET', '/api/harness/skill/' + encodeURIComponent(skillKey));
    const lines = [];
    lines.push('技能：' + (detail.skill.name || detail.skill.skillKey));
    lines.push('键：' + detail.skill.skillKey);
    lines.push('来源：' + (SKILL_SOURCE_NAMES[detail.skill.source] || detail.skill.source)
      + (detail.skill.sourceRef ? '（' + detail.skill.sourceRef + '）' : ''));
    lines.push('发布者：' + (detail.skill.publisher || '-'));
    lines.push('状态：' + (SKILL_STATUS_NAMES[detail.skill.status] || detail.skill.status)
      + ' / ' + (detail.skill.listingStatus === 'published' ? '在架' : '不在架'));
    lines.push('可见范围：' + (SKILL_VISIBILITY_NAMES[detail.skill.visibility] || detail.skill.visibility));
    lines.push('摘要：' + (detail.skill.contentDigest || '-'));
    lines.push('签名：' + (detail.skill.signature || '-'));
    lines.push('版本：' + (detail.versions || []).map(v => 'v' + v.version).join(', '));
    lines.push('');
    lines.push('---- SKILL.md ----');
    lines.push(detail.content || '');
    modal('技能 · ' + detail.skill.skillKey, [
      { name: 'info', label: '内容', type: 'textarea', value: lines.join('\n') },
    ], async () => { });
  } catch (e) {
    toast(e.message, 'bad');
  }
}

/** Asks for a reason before a decision that ends up in the audit trail. */
function skillReason(title, label, onOk) {
  modal(title, [
    { name: 'reason', label: label, type: 'textarea' },
  ], async (v) => {
    if (!v.reason || !v.reason.trim()) {
      throw new Error('得写清楚为什么');
    }
    await onOk(v.reason.trim());
    await loadAll();
  });
}

/**
 * Installs a skill somewhere.
 *
 * The target decides who gets it: a department (every machine of that department), a digital
 * employee, or one machine. Only a skill that is on the shelf can be installed.
 */
function installSkillModal(skillKey) {
  const deptIds = Array.from(new Set(state.agents.map(a => a.deptId).filter(Boolean)));
  const hint = '部门填部门号（如 ' + (deptIds[0] || '42') + '）；数字员工填 agentId；终端填 terminalId。'
    + '装在部门上，该部门每台机器都会拿到。';

  modal('拉取部署 · ' + skillKey, [
    {
      name: 'targetType', label: '装到哪', type: 'select',
      options: [
        { value: 'dept', label: '部门（该部门所有机器都会拿到）' },
        { value: 'agent', label: '数字员工' },
        { value: 'terminal', label: '终端' },
      ],
    },
    { name: 'targetId', label: hint, value: deptIds[0] || '' },
    { name: 'reason', label: '理由', type: 'textarea', value: '控制台拉取部署' },
  ], async (v) => {
    await api('POST', '/api/harness/skill/install', {
      skillKey, targetType: v.targetType, targetId: v.targetId, reason: v.reason,
    });
    toast('已拉取部署', 'ok');
    await loadAll();
  });
}

/**
 * Searches an upstream registry and pulls a package in.
 *
 * What comes back is third-party text: it is shown, it is not executed, and it lands in the
 * market as a candidate that somebody has to review before it can be installed.
 */
async function searchRegistry(registryKey) {
  modal('在 ' + registryKey + ' 里搜索', [
    { name: 'query', label: '搜索词', value: '' },
  ], async (v) => {
    if (!v.query || !v.query.trim()) {
      throw new Error('得给个搜索词');
    }
    const found = await api('POST', '/api/harness/skill/registry/search', {
      registryKey, query: v.query.trim(), limit: 20,
    });
    if (!found || !found.length) {
      toast('没找到', 'warn');
      return;
    }
    const lines = found.map(f => f.package + (f.installs ? '  ·  ' + f.installs + ' 次安装' : ''));
    modal('搜到的技能（选一个拉进来）', [
      { name: 'picked', label: '包引用', type: 'textarea', value: lines.join('\n') },
    ], async (pick) => {
      const packageRef = (pick.picked || '').trim().split('\n')[0];
      if (!packageRef) throw new Error('选一个');
      await api('POST', '/api/harness/skill/pull', { registryKey, packageRef });
      toast('已拉进候选池，等人评审', 'ok');
      await loadAll();
    });
  });
}

/**
 * Writes a new skill.
 *
 * The content is a SKILL.md: frontmatter with a name and a description, then the steps. A
 * document the terminal could not load is refused by the platform too - a skill that cannot be
 * read is a skill that silently does nothing.
 */
function newSkillModal() {
  const template = [
    '---',
    'name: my-skill',
    'description: 这个技能是干什么的，agent 什么时候该用它',
    'tools: exec',
    '---',
    '',
    '# 我的技能',
    '',
    '1. 第一步',
    '2. 第二步',
    '',
  ].join('\n');
  modal('新建技能', [
    { name: 'skillKey', label: '技能键（唯一）', value: '' },
    { name: 'name', label: '显示名（可空，取 frontmatter 里的 name）', value: '' },
    { name: 'description', label: '一句话说明（可空）', value: '' },
    {
      name: 'visibility', label: '可见范围', type: 'select',
      options: [
        { value: 'dept', label: '本部门' },
        { value: 'org', label: '全公司（要管理员）' },
        { value: 'private', label: '仅自己' },
      ],
    },
    { name: 'content', label: 'SKILL.md', type: 'textarea', value: template },
  ], async (v) => {
    if (!v.skillKey || !v.skillKey.trim()) {
      throw new Error('技能键不能空');
    }
    await api('POST', '/api/harness/skill', {
      skillKey: v.skillKey.trim(),
      name: v.name || null,
      description: v.description || null,
      visibility: v.visibility,
      content: v.content,
    });
    toast('已建好，是候选状态，还没人评审', 'ok');
    await loadAll();
  });
}

/** Registers an upstream registry. */
function newRegistryModal() {
  modal('登记外部注册源', [
    { name: 'registryKey', label: '标识（唯一）', value: '' },
    { name: 'name', label: '显示名', value: '' },
    { name: 'searchUrl', label: '搜索地址（{query} / {limit} 是占位符）', value: '' },
    { name: 'packageUrl', label: '取包地址（{package} 是占位符）', value: '' },
  ], async (v) => {
    if (!v.registryKey || !v.searchUrl || !v.packageUrl) {
      throw new Error('标识、搜索地址、取包地址都要填');
    }
    await api('POST', '/api/harness/skill/registry', {
      registryKey: v.registryKey.trim(), name: v.name || v.registryKey,
      searchUrl: v.searchUrl.trim(), packageUrl: v.packageUrl.trim(),
    });
    toast('已登记', 'ok');
    await loadAll();
  });
}

// ---------------------------------------------------------------- 启动
(async function start() {
  bindEvents();
  // The version stamp tells a stale page from a current one. If this says "控制台" without a
  // build time, the browser is running an old copy of the script - a hard refresh fixes it.
  api('GET', '/api/harness/version').then((version) => {
    $('#consoleVersion').textContent =
      '控制台 v' + (version.version || '?') + ' · 构建于 ' + (version.builtAt || '?');
  }).catch(() => { $('#consoleVersion').textContent = '控制台（版本未知）'; });

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
