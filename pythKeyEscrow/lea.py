from kgc import get_vsh
from funzioni import *

def lea_key(r1, r2, idA, idB):
    vsh = get_vsh(idA, r1, r2)
    p = id_to_point(idB)
    t = pairing(vsh, p)
    kab, kab_files = pairing_to_key(t)
    return kab, kab_files
