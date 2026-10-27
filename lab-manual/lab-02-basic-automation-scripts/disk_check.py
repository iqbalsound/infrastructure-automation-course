import shutil

THRESHOLD = 80
total, used, free = shutil.disk_usage("/")
percent = used / total * 100
print(f"{'WARNING' if percent >= THRESHOLD else 'OK'}: disk usage at {percent:.1f}%")
