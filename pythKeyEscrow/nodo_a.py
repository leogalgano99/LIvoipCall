from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA512
from Crypto.Random import get_random_bytes
from tate_bilinear_pairing import eta, ecc
from Crypto.Cipher import AES
from kgc import sign_id
from funzioni import * 

def nodoA_key(r1, r2, idA, idB):
    eta.init(151)
    g = ecc.gen()

    s_hid = sign_id(idA)    #firma del nodo A
    v = v_dev(r1, r2)       #derivation function a partire da r1 e r2
    vs_hid = ecc.scalar_mult(v, s_hid)      #Pa = v * MH(idA)
    #print (vs_hid)

    h_idb = id_to_point(idB)                #H(idB) Hash dell'id del nodo B
    #print (h_idb)

    ka = pairing(vs_hid, h_idb)            #K = e(Pa, H(idB))
    #print (ka)

    kab = pairing_to_key(ka)
    return kab