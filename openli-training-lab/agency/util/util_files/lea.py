import sys
from funzioni_decryption_lea import *

with open("keyLEA_files.txt", "rb") as key_file:
    klea = key_file.read()

# sintassi comando "sudo python3 lea.py <encfile_path> <clearfile_path>" 
pt = dec(klea, sys.argv[1], sys.argv[2])
