import hashlib
import base64
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA512
from Crypto.Random import get_random_bytes
from tate_bilinear_pairing import eta, ecc
from Crypto.Cipher import AES

eta.init(151)
g = ecc.gen()
def id_to_point(identity) :
 ID = identity
 stringa_originale_id = str(ID)
 stringa_id = stringa_originale_id.encode(encoding = 'utf-8')
 h_id = hashlib.sha1(stringa_id).hexdigest()
 h_id_int = int (h_id, 16)
 p = ecc.scalar_mult(h_id_int, g)
 return p
 
def v_dev(r1, r2) :
 password = str(r1*r2)
 p = password.encode(encoding = 'utf-8')
 salt = 1
 key = PBKDF2(p, salt, 32, count=10000, hmac_hash_module=SHA512)
 v = int.from_bytes(key, byteorder='big')
 return v

def pairing(p1, p2) :
 t = eta.pairing(p1[1], p1[2], p2[1], p2[2])
 return t

def pairing_to_key(t) :
 c1 = ''
 for i in t:
  for j in i:
   for k in j:
    for z in k:
     c = str(z)
     c1 = c1 + c
 c2 = c1.encode(encoding = "utf-8")
 password = c2
 salt = 1
 length = 32 # chiave da 256 bit
 key = PBKDF2(password, salt, length, count=10000, hmac_hash_module=SHA512)
 key_base64 = base64.b64encode(key).decode('utf-8') 
 key_base64 = key_base64[:30]   #la chiave deve essere lunga 30 caratteri per essere usata in SDES  
 key_files = key
 return key_base64, key_files

#################################
#Parte Codice solo VoiP
################################
#def pairing_to_key(t) :
# c1 = ''
# for i in t:
#  for j in i:
#   for k in j:
#    for z in k:
#     c = str(z)
#     c1 = c1 + c
# c2 = c1.encode(encoding = "utf-8")
# password = c2
# salt = 1
# length = 32 # chiave da 256 bit
# key = PBKDF2(password, salt, length, count=10000, hmac_hash_module=SHA512)
# key_base64 = base64.b64encode(key).decode('utf-8') 
# key_base64 = key_base64[:30]   #la chiave deve essere lunga 30 caratteri per essere usata in SDES  
# return key_base64
 
