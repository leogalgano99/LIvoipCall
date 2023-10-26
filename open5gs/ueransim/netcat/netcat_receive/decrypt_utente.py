from funzioni_decifrare_utente import *

with open("keyB_files.txt", "rb") as key_file:
    kab = key_file.read()

# sintassi comando "sudo python3 encrypt.py <encfile_path> <decfile_path>" 
pt = dec(kab, sys.argv[1], sys.argv[2])
#print (pt)
