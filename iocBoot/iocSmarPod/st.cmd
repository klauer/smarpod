#!../../bin/linux-x86/SmarPodtest

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=E1:)"
epicsEnvSet "R" "$(R=SmarPod:)"
epicsEnvSet "SMARPOD_IP" "$(SMARPOD_IP=10.0.3.9)"
epicsEnvSet "SMARPOD_PORT" "$(SMARPOD_PORT=2000)"
epicsEnvSet "ASYN_PORT" "SP_PORT"

## Register all support components
dbLoadDatabase("$(TOP)/dbd/SmarPodtest.dbd",0,0)
SmarPodtest_registerRecordDeviceDriver(pdbbase) 

###############################################################################
# Set up ASYN ports
drvAsynIPPortConfigure("$(ASYN_PORT)","$(SMARPOD_IP):$(SMARPOD_PORT)",0,0,0)
asynOctetSetInputEos("$(ASYN_PORT)", -1, "\n")
asynOctetSetOutputEos("$(ASYN_PORT)", -1, "\n")
asynSetTraceIOMask("$(ASYN_PORT)",-1,0)
asynSetTraceMask("$(ASYN_PORT)",-1,0)
#asynSetTraceIOMask("$(ASYN_PORT)",-1,0x2)
#asynSetTraceMask("$(ASYN_PORT)",-1,0x9)

###############################################################################
## Load record instances
dbLoadRecords("$(TOP)/db/devSmarPod.db","P=$(P),R=$(R),PORT=$(ASYN_PORT),A=0")

iocInit()
#var streamDebug 1
dbpr E1:SmarPod:X

