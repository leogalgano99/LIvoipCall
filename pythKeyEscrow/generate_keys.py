import random
import base64
from lea import lea_key
from nodo_a import nodoA_key
from nodo_b import nodoB_key

r1 = random.randint(1, 100)
r2 = random.randint(1, 100)

print ("I numeri generati sono\nr1:", r1, "\nr2:", r2)
idA = 20
idB = 50

nodoA_key = nodoA_key(r1, r2, idA, idB)
# Specifica il percorso del file in cui desideri salvare la stringa
keyA = "keyA.txt"
# Apri il file in modalità scrittura e scrivi la stringa
with open(keyA, "w") as file:
    file.write(nodoA_key)

nodoB_key = nodoB_key(r1, r2, idA, idB)
keyB = "keyB.txt"
# Apri il file in modalità scrittura e scrivi la stringa
with open(keyB, "w") as file:
    file.write(nodoB_key)

lea_key = lea_key(r1, r2, idA, idB)
key_lea = base64.b64encode(lea_key.encode('utf-8')).decode('utf-8') 
keyLEA= "keyLEA.txt"
# Apri il file in modalità scrittura e scrivi la stringa
with open(keyLEA, "w") as file:
    file.write(key_lea)

print ("La chiave è:", nodoB_key, "\nLa chiave codificata base64 è:", key_lea)