#!/usr/bin/env bash
set -euo pipefail

URL="http://127.0.0.1:8000/activities"
MAX_ATTEMPTS=20
SLEEP_SECONDS=1

for i in $(seq 1 $MAX_ATTEMPTS); do
  echo "Attempt $i: checking $URL"
  if curl -sSf "$URL" >/dev/null 2>&1; then
    echo "OK: $URL responded"
    exit 0
  fi
  sleep $SLEEP_SECONDS
done

echo "ERROR: server did not respond at $URL after $MAX_ATTEMPTS attempts" >&2
echo "--- last 300 lines of app.log (if present) ---"
tail -n 300 app.log || true
exit 1