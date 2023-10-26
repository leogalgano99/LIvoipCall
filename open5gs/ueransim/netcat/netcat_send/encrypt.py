from funzioni_cifrare_utente import * 

with open("keyA_files.txt", "rb") as key_file:
    kab = key_file.read()

# sintassi comando "sudo python3 encrypt.py <sourcefile_path> <encfile_path>" 
pt = enc(kab, sys.argv[1], sys.argv[2])
#print (pt)
