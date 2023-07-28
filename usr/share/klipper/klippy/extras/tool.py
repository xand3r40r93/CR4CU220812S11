import re, os, logging, threading
from subprocess import call


def send(msg):
    from subprocess import call
    mainPath = "/usr/share/klipper/klippy/mainMips"
    try:
        net_state = call("ping -c 2 -w 2 api.crealitycloud.com > /dev/null 2>&1", shell=True)
        if net_state:
            return
        if not os.path.exists(mainPath):
            return
        ret = re.findall('key.*?,', msg)
        if ret:
            msg = ret[0].strip('"').strip(",")
        cmd = "%s -server=true -msg='%s'" % (mainPath, msg)
        call(cmd, shell=True)
    except Exception as err:
        logging.error("reportInformation err:%s" % err)

def reportInformation(msg):
    t = threading.Thread(target=send, args=(msg,))
    t.start()
