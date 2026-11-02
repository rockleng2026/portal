#!/usr/bin/env python3
"""A signed call to the portal's harness namespace.

The portal's API is HMAC authenticated (03 §9), so a call has to be signed exactly the way
the platform signs it:

    key      = hex(sha256(secret))          (the ASCII of the hex, not the raw bytes)
    canonical= METHOD \n PATH \n TIMESTAMP \n NONCE \n hex(sha256(body))
    signature= hex(HMAC-SHA256(key, canonical))

The path that is signed is the one inside the web application - without the "/portal" context
path - because that is what the portal verifies.

    portal-call.py <path> [body-json]
"""
import hashlib
import hmac
import json
import os
import sys
import time
import urllib.request
import uuid

PROPS = os.path.expanduser("~/.harness/platform.env")
PROPERTIES = "/mnt/data/project/tomcat/webapps/portal/WEB-INF/props/harness-api.properties"


def env_value(name):
    for line in open(PROPS, encoding="utf-8"):
        line = line.strip()
        if line.startswith(name + "="):
            value = line.split("=", 1)[1].strip().strip("'\"")
            return value.strip("'")
    return ""


def props_value(name):
    for line in open(PROPERTIES, encoding="utf-8"):
        line = line.strip()
        if line.startswith(name + "="):
            return line.split("=", 1)[1].strip()
    return ""


def sign(secret, method, path, timestamp, nonce, body):
    key = hashlib.sha256(secret.encode("utf-8")).hexdigest().encode("ascii")
    canonical = "\n".join([
        method.upper(), path, timestamp, nonce,
        hashlib.sha256(body).hexdigest(),
    ])
    return hmac.new(key, canonical.encode("utf-8"), hashlib.sha256).hexdigest()


def decode(raw):
    """The portal answers in its own encoding, which is GBK.

    The JSON result writes the bytes the platform's default charset produces, and the portal's
    default charset is GBK - the same one its sources are in.
    """
    for encoding in ("utf-8", "gbk", "latin-1"):
        try:
            return raw.decode(encoding)
        except UnicodeDecodeError:
            continue
    return raw.decode("latin-1")


def main():
    path = sys.argv[1]
    body = (sys.argv[2] if len(sys.argv) > 2 else "{}").encode("utf-8")
    base = env_value("HARNESS_PORTAL_BASE_URL") or "http://127.0.0.1:18301/portal"
    # The portal's own configuration is the truth about the shared secret; the platform's copy
    # may be quoted differently in the environment file.
    secret = props_value("harness.api.secret") or env_value("HARNESS_PORTAL_SECRET")
    client = props_value("harness.api.clientId") or env_value("HARNESS_PORTAL_CLIENT_ID")

    timestamp = str(int(time.time()))
    nonce = str(uuid.uuid4())
    signature = sign(secret, "POST", path, timestamp, nonce, body)

    request = urllib.request.Request(
        base + path, data=body, method="POST",
        headers={
            "Content-Type": "application/json;charset=UTF-8",
            "X-Harness-Client": client,
            "X-Harness-Timestamp": timestamp,
            "X-Harness-Nonce": nonce,
            "X-Harness-Signature": signature,
        })
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            text = decode(response.read())
            print("HTTP", response.status)
            try:
                print(json.dumps(json.loads(text), ensure_ascii=False, indent=2))
            except Exception:
                print(text)
    except urllib.error.HTTPError as error:
        print("HTTP", error.code)
        print(decode(error.read()))


if __name__ == "__main__":
    main()
