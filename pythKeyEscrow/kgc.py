import hashlib
from tate_bilinear_pairing import eta, ecc
from mo import get_v

eta.init(151)
g = ecc.gen()
s = 5698
def sign_id(ID) :
 stringa_originale_id = str(ID)
 stringa_id = stringa_originale_id.encode(encoding = 'utf-8')
 h_id = hashlib.sha1(stringa_id).hexdigest()
 h_id_int = int (h_id, 16)
 sh = s * h_id_int
 p = ecc.scalar_mult(sh, g)
 return p
 
def get_vsh(ID, r1, r2) :
 v = get_v(r1, r2)
 sh = sign_id(ID)
 vsh = ecc.scalar_mult(v, sh)
 return vsh
