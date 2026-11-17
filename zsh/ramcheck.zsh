# ==============================================================================
# ramcheck.zsh: RAM usage table grouped by app.
# ==============================================================================

##
# Show RAM usage grouped by app/tool, biggest first.
# @param   $1  int  number of rows to show (default 12)
# @stdout  summary line + table
##
ramcheck () {
  /usr/bin/python3 -I - "${1:-12}" <<'PY'
import os, re, subprocess, sys
from collections import defaultdict
limit = int(sys.argv[1])
sh = lambda c: subprocess.run(c, shell=True, capture_output=True, text=True).stdout
B, R = "\033[1m", "\033[0m"

# per-process footprint (incl. compressed) from top
mem = {}
for l in sh("top -l 1 -o mem -n 500 -stats pid,mem").splitlines():
    m = re.match(r"\s*(\d+)\s+([\d.]+)([BKMG])", l)
    if m: mem[int(m[1])] = float(m[2]) * {"B": 1, "K": 1 << 10, "M": 1 << 20, "G": 1 << 30}[m[3]]

def secs(e):
    d, _, t = e.rpartition("-"); p = [int(x) for x in t.split(":")]
    while len(p) < 3: p.insert(0, 0)
    return int(d or 0) * 86400 + p[0] * 3600 + p[1] * 60 + p[2]

def ago(s):
    if s >= 86400: return f"{s // 86400} day{'s' if s >= 172800 else ''}"
    if s >= 3600: return f"{s // 3600} hour{'s' if s >= 7200 else ''}"
    return f"{max(s // 60, 1)} minute{'s' if s >= 120 else ''}"

docker = "Docker.app" in sh("ps -axo comm=")
groups = defaultdict(lambda: {"mem": 0, "n": 0, "up": 0, "detail": "", "sub": defaultdict(int)})
for l in sh("ps -axo pid=,etime=,command=").splitlines():
    parts = l.split(None, 2)
    if len(parts) < 3: continue
    pid, et, cmd = parts
    pid = int(pid)
    if pid not in mem: continue
    exe = cmd.split(" -")[0]
    app = re.search(r"/([^/]+)\.app/", cmd)
    detail = ""
    if "qemu-system" in cmd:
        avd = re.search(r"-avd (\S+)", cmd); key = "Android Emulator"; detail = f"{avd[1] if avd else 'AVD'}, qemu"
    elif "com.apple.Virtualization.VirtualMachine" in cmd:
        key = "Docker Desktop VM" if docker else "Virtual Machine"; detail = "Apple Virtualization"
    elif cmd.startswith("next-server"):
        key = "Next.js dev server"
    elif "java" in os.path.basename(exe) and re.search(r"gradle|kotlin", cmd, re.I):
        key = "Gradle and Kotlin daemons"
    elif re.match(r"(\S*/)?claude(\s|$)", cmd):
        key = "Claude Code sessions"
    elif app:
        key = {"Google Chrome": "Google Chrome", "Visual Studio Code": "VS Code"}.get(app[1], app[1])
    else:
        key = os.path.basename(exe.split()[0]).rstrip(":")
        key = {"node": "Node.js (other)"}.get(key, key)
    g = groups[key]
    g["mem"] += mem[pid]; g["n"] += 1; g["up"] = max(g["up"], secs(et)); g["detail"] = g["detail"] or detail

rows = sorted(groups.items(), key=lambda kv: -kv[1]["mem"])[:limit]
if not rows:
    print("No process memory data available."); sys.exit(0)

def fmt(b):
    return f"~{b / (1 << 30):.1f} GB".replace(".0 GB", " GB") if b >= 1 << 30 else f"~{b / (1 << 20):.0f} MB"

table = []
for i, (k, g) in enumerate(rows):
    extra = g["detail"] or (f"{g['n']} processes" if g["n"] > 1 else "")
    what = (B + k + R) if i < 4 else k
    what += f" ({extra})" if extra else ""
    notes = f"Running for {ago(g['up'])}."
    if i == 0 and len(rows) > 1 and g["mem"] > 1.5 * rows[1][1]["mem"]: notes += " This is the biggest user by far."
    table.append([what, (B + fmt(g["mem"]) + R) if i < 4 else fmt(g["mem"]), notes])

vis = lambda s: len(re.sub(r"\033\[\d*m", "", s))
hdr = ["What", "Memory", "Notes"]
w = [max(vis(r[c]) for r in table + [hdr]) for c in range(3)]
line = lambda l, m, r: l + m.join("─" * (x + 2) for x in w) + r
cell = lambda r, center=False: "│" + "│".join(
    " " + (s.center(w[c]) if center else s + " " * (w[c] - vis(s))) + " " for c, s in enumerate(r)) + "│"

# summary
total = int(sh("sysctl -n hw.memsize"))
free = re.search(r"free percentage: (\d+%)", sh("memory_pressure"))
swap_m = re.search(r"used = (\S+)", sh("sysctl -n vm.swapusage"))
print(f"{B}RAM{R} {total / (1 << 30):.0f} GB  ·  memory pressure free: {B}{free[1] if free else '?'}{R}  ·  swap used: {swap_m[1] if swap_m else '?'}\n")
print(line("┌", "┬", "┐")); print(cell(hdr, True)); print(line("├", "┼", "┤"))
for i, r in enumerate(table):
    print(cell(r)); print(line("├", "┼", "┤") if i < len(table) - 1 else line("└", "┴", "┘"))
PY
}
