# hyperfine

## Useful Commands

```bash
hyperfine \
  "uv run --python 3.14 ./bm_pystones.py" \
  "uv run --python 3.13 ./bm_pystones.py" \
  -n tail-calling \
  -n baseline \
  --warmup 10

```