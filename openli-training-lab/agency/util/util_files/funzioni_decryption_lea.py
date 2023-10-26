import hashlib
import sys
import libnum
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
 key = PBKDF2(password, salt, 32, count=10000, hmac_hash_module=SHA512)   
 return key
 
def enc(key, file_in, file_out):
 f = open(file_in, "rb")
 data = f.read()
 f.close()
 cipher = AES.new(key, AES.MODE_EAX)
 ciphertext, tag = cipher.encrypt_and_digest(data)
 f1 = open(file_out, "wb")
 f1.write(cipher.nonce)
 f1.write(tag)
 f1.write(ciphertext)
 f1.close()
 return (ciphertext)
 
def dec(key, file_ct, file_pt) :
 f2 = open(file_ct, "rb")
 nonce = f2.read(16)
 tag = f2.read(16)
 cipher_data = f2.read()
 f2.close()
 cipher = AES.new(key, AES.MODE_EAX, nonce)
 plaintext = cipher.decrypt_and_verify(cipher_data, tag)
 #print (plaintext)
 f3 = open(file_pt, "wb")
 f3.write(plaintext)
 f3.close()
 return (plaintext) 
