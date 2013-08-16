template = """
# (Static Text)
object activeXTextClass
beginObjectProperties
major 4
minor 1
release 0
x 180
y %(y)d
w 38
h 21
font "helvetica-medium-r-18.0"
fgColor index 14
bgColor index 0
useDisplayBg
value {
  "%(desc)s"
}
autoSize
endObjectProperties

# (Text Monitor)
object activeXTextDspClass:noedit
beginObjectProperties
major 4
minor 5
release 0
x 230
y %(y)d
w 100
h 21
controlPv "$(P)$(R)%(pv)s"
font "helvetica-medium-r-18.0"
fgColor index 80
bgColor index 0
useDisplayBg
autoHeight
limitsFromDb
nullColor index 0
useHexPrefix
newPos
objType "monitors"
endObjectProperties
"""

entries = """
VER:SMARPOD SmarPod version
VER:MCS MCS Version
VER:SYS System version
STATUS:CLIENT_IP Client IP
STATUS:IP SmarPod IP
STATUS:LOW_LEVEL Low-level
STATUS:NET Network
STATUS:SER_STATUS Serial
STATUS:STATUS Status
STATUS:UPTIME Uptime
STATUS:CONN Connections
STATUS:LOAD CPU Load
STATUS:NET_BYTES_IN Network bytes in
STATUS:NET_BYTES_OUT Network bytes out
STATUS:SER_BYTES_IN Serial bytes in
STATUS:SER_BYTES_OUT Serial bytes out
STATUS:TEMP Temperature
""".strip().split('\n')
entries = [entry.split(' ', 1) for entry in entries]

y = 50
for pv, desc in entries:
     y += 30
     print(template % locals())
