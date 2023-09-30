import pjsua2 as pj
import time
import sys

CALL_STATUS = {
  "quit": 0,
  "start": 1,
  "ongoing":2,
}

current_status = None
call = None

# Subclass to extend the Account and get notifications etc.
class Account(pj.Account):
  def onRegState(self, prm):
    print("***OnRegState: " + prm.reason)   

class Call(pj.Call):
  def __init__(self, account, call=pj.PJSUA_INVALID_ID):
    pj.Call.__init__(self, account, call)
  def onCallState(self, prm):
    global current_status
    # Terminate call if disconnected
    if self.getInfo().state == pj.PJSIP_INV_STATE_DISCONNECTED:
      current_status = CALL_STATUS["quit"]
      return 
    if self.getInfo().state == pj.PJSIP_INV_STATE_CONFIRMED:
      print("IL DESTINATARIO HA RISPOSTO ALLA CHIAMATA")
    if self.getInfo().state == pj.PJSIP_INV_STATE_EARLY:
      print("STA SQUILLANDO ...")
    if self.getInfo().state == pj.PJSIP_INV_STATE_CONNECTING:
      print("AVVIO CHIAMATA ...")
    
  def onCallMediaState(self, prm):
    print("==== QUESTO UTENTE DEVE RIMANERE IN SILENZIO ====")            

# pjsua2 test function
def main():
  # Create and initialize the library
  ep_cfg = pj.EpConfig()
  ep = pj.Endpoint()
  ep.libCreate()
  ep.libInit(ep_cfg)

  # Create SIP transport. Error handling sample is shown
  sipTpConfig = pj.TransportConfig()
  sipTpConfig.port = 5061
  ep.transportCreate(pj.PJSIP_TRANSPORT_TLS, sipTpConfig)
  # Start the library
  ep.libStart()

  acfg = pj.AccountConfig();
  acfg.idUri = "sip:101@172.22.0.16;transport=tls"
  acfg.regConfig.registrarUri = "sip:172.22.0.16;transport=tls"
  #impostare la chiave che deve usare srtp
  cred = pj.AuthCredInfo("digest", "*", "alice", 0, "alice")
  acfg.sipConfig.authCreds.append( cred )

  #Lettura della chiave dal file
  path_key = "/UERANSIM/build/keyA.txt"
  with open(path_key, "r") as file:
    key = file.read()

  #Configurazione SRTP  
  acfg.mediaConfig.srtpUse = pj.PJMEDIA_SRTP_MANDATORY
  srtpCrypto = pj.SrtpCrypto()
  srtpCrypto.key = key
  srtpCrypto.name = "AES_CM_128_HMAC_SHA1_80"

  print("Crypto name: ", srtpCrypto.name)
  acfg.mediaConfig.srtpOpt.cryptos.append(srtpCrypto)
  
  # Create the account
  acc = Account()
  acc.create(acfg)
  time.sleep(3)

  global current_status
  current_status = CALL_STATUS["start"]
  
  call_setting = pj.CallOpParam(True)
  dest_uri = "sip:102@172.22.0.16;transport=tls"  # Replace with the destination URI
  global call
  call = Call(acc)
  while current_status != CALL_STATUS["quit"]:
    if current_status == CALL_STATUS["start"]:
      call.makeCall(dest_uri, call_setting)
      current_status = CALL_STATUS["ongoing"]
    else:
      continue
 
  # Destroy the library
  ep.libDestroy()
#
# main()
#
if __name__ == "__main__":
  main()