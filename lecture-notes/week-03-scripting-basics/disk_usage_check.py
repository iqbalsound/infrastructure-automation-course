# Python: disk usage check across a list of servers
import shutil
servers = ["server1", "server2", "server3"]
for s in servers:
    total, used, free = shutil.disk_usage("/")
    print(f"{s}: free={free // (2**30)} GB")
