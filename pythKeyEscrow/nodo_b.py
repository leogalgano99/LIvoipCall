from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA512
from Crypto.Random import get_random_bytes
from tate_bilinear_pairing import eta, ecc
from Crypto.Cipher import AES
from kgc import sign_id 
from funzioni import *

rb = 30
eta.init(151)
#g = ecc.gen()
#def give_r() :
 #return rb
 
 
'''def id_to_point(identity) :
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
 return key'''

def nodoB_key(r1, r2, idA, idB):
    s_hid = sign_id(idB)    #firma del nodo B
    v = v_dev(r1, r2)       #derivation function a partire da r1 e r2
    vs_hid = ecc.scalar_mult(v, s_hid)  #Pb = v * MH(idB)
    #print (vs_hid)

    h_ida = id_to_point(idA)              #H(idA) Hash dell'id del nodo A
    #print (h_idb)

    ka = pairing(vs_hid, h_ida)           #K = e(Pb, H(idA))
    #print (ka)

    kab, kab_files = pairing_to_key(ka)    
    #print(f"Le chiavi UE sono: {kab} (VoIP), {kab_files} (files)")
    return kab, kab_files

#################################
#Parte del Codice solo VoiP
################################
#    kab = pairing_to_key(ka)
#    return kab
    
