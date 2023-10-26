import pjsua2 as pj
import time
import subprocess
import sys


current_call = None
prm = None

# Riproduzione del file audio
def play_file():
    time.sleep(0.5)
    print("\nPlay back announcement")
    playback = subprocess.Popen(" ".join(("aplay", SOUND_F_PATH)), shell=True)
    playback.wait()
    print("Finished\n")
    time.sleep(0.5)

# Subclass to extend the Account and get notifications etc.
class Account(pj.Account):

  def onRegState(self, prm):
    print("***OnRegState: " + prm.reason)

  def onIncomingCall(self, iprm):
    global current_call
    call= Call(self, iprm.callId)
    global prm
    prm = pj.CallOpParam()
    if current_call:
      prm.statusCode=486
      call.answer(prm)
      return
    
    current_call=call
    prm.statusCode=180
    #call_cb = Call(current_call)
    #current_call.set_callback(call_cb)
    current_call.answer(prm)
    print("Chiamata in arrivo da", current_call.getInfo().remoteUri)

class Call(pj.Call):
  def __init__(self, account, call=None):
    pj.Call.__init__(self, account, call)
  
  def onCallState(self, prm):
    global current_call
    # Terminate call if disconnected
    if self.getInfo().state == pj.PJSIP_INV_STATE_DISCONNECTED:
      current_call = None
      return
    if self.getInfo().state == pj.PJSIP_INV_STATE_CONFIRMED:
      print("CHIAMATA IN CORSO ...")
    if self.getInfo().state == pj.PJSIP_INV_STATE_EARLY:
      print("STA SQUILLANDO ....")
    if self.getInfo().state == pj.PJSIP_INV_STATE_CONNECTING:
      print("AVVIO CHIAMATA ...")

  def onCallMediaState(self, prm):
    ci = self.getInfo()
    print("=== Attivo i driver audio ===")
    for mi in ci.media:
      if mi.type == pj.PJMEDIA_TYPE_AUDIO and mi.status == pj.PJSUA_CALL_MEDIA_ACTIVE:
        m = self.getMedia(mi.index)
        am = pj.AudioMedia.typecastFromMedia(m)
        # connect ports
        pj.Endpoint.instance().audDevManager().getPlaybackDevMedia().startTransmit(am)
        am.startTransmit(pj.Endpoint.instance().audDevManager().getCaptureDevMedia())

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
  acfg = pj.AccountConfig()
  acfg.idUri = "sip:102@172.22.0.16;transport=tls"
  acfg.regConfig.registrarUri = "sip:172.22.0.16;transport=tls"
  cred = pj.AuthCredInfo("digest", "*", "bob", 0, "bob")
  acfg.sipConfig.authCreds.append(cred)
  
  #Lettura della chiave dal file
  path_key = "/UERANSIM/build/keyB.txt"
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

  while True:
    print("\n---- Call menu ----")
    print("Stato chiamata: ", current_call.getInfo().stateText if current_call else "Nessuna chiamata attiva")
    print("rispondi: a, chiudi: h, esci: q\n")
    # user_input = sys.stdin.readline().rstrip('\r\n')
    user_input="a"
    if user_input == "h":
      if not current_call:
        print("Non c'è nessuna chiamata attiva\n")
        continue
      current_call.hangup(prm)
    elif user_input == "a":
        if not current_call:
          print("Non c'è nessuna chiamata attiva\n")
          continue
        prm.statusCode = 200
        current_call.answer(prm)
        play_file()
        current_call.hangup(prm)
        break
    elif user_input == "q":
      break
  
  # Destroy the library
  ep.libDestroy()
  sys.exit(0)  

#
# main()
#
if __name__ == "__main__":
  # Verifica che ci siano almeno due argomenti (il nome dello script è il primo argomento)
  if len(sys.argv) < 2:
    print("Usage: python recive_tls.py audio.wav")
    sys.exit(1)  # Esci dallo script con stato di uscita 1 (errore)

  # Definisci il percorso del file wav di input
  SOUND_F_PATH = "/UERANSIM/build/sample/"
  SOUND_F_PATH += sys.argv[1]
  main()


