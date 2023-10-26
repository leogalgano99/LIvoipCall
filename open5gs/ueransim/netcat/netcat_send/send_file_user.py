#!/usr/bin/env python3

import sys
import socket


def send_file(filename, host_IP, host_port):
	with open(filename, "rb") as f:
		data = f.read()
	with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
		s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
		s.connect((host_IP, host_port))
		s.sendall(data)
		s.shutdown(socket.SHUT_RDWR) 
				
if __name__ == "__main__":
	if len(sys.argv) != 5:
		print(f"Usage: {sys.argv[0]} <command> <filename> <source_IP> <source_port>")
		sys.exit(1)
	if sys.argv[1] == "send":
		send_file(sys.argv[2], sys.argv[3], int(sys.argv[4]))
	else:
		print(f"Unknown command: {sys.argv[1]}")
		sys.exit(1)
		
