#!/usr/bin/env bash
# =====================================================================================
# Signed request helper for the harness platform (03 §9).
#
# The platform's API is authenticated with HMAC, not with a cookie, so every call has to be
# signed. This script signs and sends one, which is what an operator (or an integration test)
# needs while there is no console UI yet.
#
#   harness-api.sh <method> <path> [body] [client] [secret] [base-url]
#
# Examples
#   harness-api.sh GET  /api/harness/terminal
#   harness-api.sh POST /api/harness/terminal/hello '{"deviceId":"dev-1","os":"linux",...}'
#   harness-api.sh POST /api/harness/approval/<id>/decide '{"decision":"approved"}' \
#                    harness-admin "$HARNESS_HUMAN_SECRET"
#
# The signature is exactly what the platform expects:
#   key      = hex(sha256(secret))                      (the platform stores exactly this)
#   canonical= METHOD \n PATH \n TIMESTAMP \n NONCE \n hex(sha256(body))
#   signature= hex(HMAC-SHA256(key, canonical))
#
# Environment
#   HARNESS_BASE_URL       default http://127.0.0.1:8080
#   HARNESS_CLIENT_ID      default harness-bootstrap
#   HARNESS_CLIENT_SECRET  default $HARNESS_BOOTSTRAP_SECRET
#
# For the human-only endpoints (binding a terminal, deciding an escalation, the kill switch)
# pass the human client id and secret explicitly - the platform refuses a machine account there,
# and that refusal is the point.
# =====================================================================================
set -euo pipefail

METHOD="${1:?usage: harness-api.sh <method> <path> [body] [client] [secret] [base-url]}"
PATH_PART="${2:?usage: harness-api.sh <method> <path> [body] [client] [secret] [base-url]}"
BODY="${3:-}"
CLIENT="${4:-${HARNESS_CLIENT_ID:-harness-bootstrap}}"
SECRET="${5:-${HARNESS_CLIENT_SECRET:-${HARNESS_BOOTSTRAP_SECRET:-}}}"
BASE_URL="${6:-${HARNESS_BASE_URL:-http://127.0.0.1:8080}}"

if [[ -z "$SECRET" ]]; then
  echo "harness-api: no secret. Pass it as the 5th argument or set HARNESS_CLIENT_SECRET." >&2
  exit 2
fi

TIMESTAMP="$(date +%s)"
NONCE="$(cat /proc/sys/kernel/random/uuid)"

sha256_hex() { printf '%s' "$1" | sha256sum | cut -d' ' -f1; }

if [[ -n "$BODY" ]]; then
  BODY_HASH="$(printf '%s' "$BODY" | sha256sum | cut -d' ' -f1)"
else
  BODY_HASH="$(printf '' | sha256sum | cut -d' ' -f1)"
fi

CANONICAL="${METHOD}"$'\n'"${PATH_PART}"$'\n'"${TIMESTAMP}"$'\n'"${NONCE}"$'\n'"${BODY_HASH}"

# The HMAC key is the ASCII of hex(sha256(secret)) - the same value the platform stores in
# harness_principal.secret_hash. Note "key:" and not "hexkey:": openssl's hexkey would decode
# the hex into 32 raw bytes, while the platform signs with the 64 ASCII characters.
KEY_HEX="$(printf '%s' "$SECRET" | sha256sum | cut -d' ' -f1)"
SIGNATURE="$(printf '%s' "$CANONICAL" | openssl dgst -sha256 -mac HMAC -macopt "key:${KEY_HEX}" \
  | awk '{print $NF}')"

if [[ -n "$BODY" ]]; then
  curl -sS -X "$METHOD" "${BASE_URL}${PATH_PART}" \
    -H 'Content-Type: application/json' \
    -H "X-Harness-Client: ${CLIENT}" \
    -H "X-Harness-Timestamp: ${TIMESTAMP}" \
    -H "X-Harness-Nonce: ${NONCE}" \
    -H "X-Harness-Signature: ${SIGNATURE}" \
    -d "$BODY"
else
  curl -sS -X "$METHOD" "${BASE_URL}${PATH_PART}" \
    -H "X-Harness-Client: ${CLIENT}" \
    -H "X-Harness-Timestamp: ${TIMESTAMP}" \
    -H "X-Harness-Nonce: ${NONCE}" \
    -H "X-Harness-Signature: ${SIGNATURE}"
fi
echo
