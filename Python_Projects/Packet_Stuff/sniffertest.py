from scapy.all import sniff, UDP, IP, get_if_list
import sys
import win32gui, win32con, win32api # type: ignore
import time
import keyboard

SERVER_IP = "207.174.43.245"
SERVER_FULL_RANGE = range(15)

VK_OEM_3 = 0xC0 # Backtick `
VK_R = 0x52 # R key
VK_C = 0x43 # C key

stop_sniffer = False
waitingForNextPacket = False

def handle_packet(packet):
    global waitingForNextPacket
    if IP in packet and UDP in packet:
        if packet[IP].src == SERVER_IP:
            payload = bytes(packet[UDP].payload)
            print(f"Len={len(payload)} Payload  {payload.hex()}")
            if not waitingForNextPacket:
                if len(payload) == 27:
                    print("Received Handshake Packet, waiting for next...")
                    waitingForNextPacket = True
            else:
                if len(payload) in SERVER_FULL_RANGE:
                    print("SERVER FULL")
                    attempt_reconnect()
                    time.sleep(1)
                elif len(payload) == 27:
                    waitingForNextPacket = True
                    print("PACKET LOSS LIKELY... RETRYING")
                    attempt_reconnect()
                    time.sleep(2)
                else: 
                    print("JOIN SUCCESS")
                    stop_sniffer = True
                waitingForNextPacket = False

def listen_for_stop():
    global stop_sniffer
    keyboard.wait("s")

    print("Stopping sniffer...")
    stop_sniffer = True
    sys.exit()

def stop_filter(packet):
    return stop_sniffer

import threading
threading.Thread(target=listen_for_stop).start()

def keyUpDown(key):
    time.sleep(0.1)
    win32api.keybd_event(key, 0, 0, 0)
    win32api.keybd_event(key, 0, win32con.KEYEVENTF_KEYUP, 0)

def attempt_reconnect():
    keyUpDown(VK_R)
    keyUpDown(VK_C)
    keyUpDown(win32con.VK_RETURN)

hwnd = win32gui.FindWindow(None, "SCPSL")
win32gui.SetForegroundWindow(hwnd)
win32api.PostMessage(hwnd, win32con.WM_KEYDOWN, VK_OEM_3, 0)

print("Sniffing for packets...")
sniff(filter=f"udp and host {SERVER_IP}", iface="Wi-Fi 2", prn=handle_packet, stop_filter = stop_filter)