import pygetwindow as gw
import time
print("Finding piano hWnd value...")
print("Open the piano within 3 seconds")

hWndBefore = []
hWndAfter = []
windowsBefore = gw.getAllWindows()
for window in windowsBefore:
    hWndBefore.append(window._hWnd)
time.sleep(3)
windowsAfter = gw.getAllWindows()
for window in windowsAfter:
    hWndAfter.append(window._hWnd)
pianohWnd = (set(hWndAfter) - set(hWndBefore))
if(pianohWnd):
    print(pianohWnd.pop())
else:
    print("No window found. Try again!")
# print(pianohWnd.pop())