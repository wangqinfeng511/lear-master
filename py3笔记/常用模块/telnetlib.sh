import telnetlib
import os
def list_port(host,port,timeout=2):
    try:
        tn = telnetlib.Telnet(host, port=port, timeout=timeout)
        port_status = tn.set_debuglevel(2)
        print('host {} prot {} Open'.format(host, port))
        # with open('/home/{}_list_port'.format(host),'a+') as f:
        #     f.write(port_status)
    except IOError or Exception or KeyboardInterrupt:
        pass
        #print('host {} prot {} NOT Open'.format(host,port))
for i in range(10240):
    list_port('192.168.1.201', port=i)

