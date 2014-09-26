#!../../bin/linux-x86/SmarPodtest

epicsEnvSet("P_SAVE", "ZP:SMARPOD:")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.0.255")

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=ZP:)"
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

# < $(HXN)/boot/save_restore.cmd
< save_restore.cmd

###############################################################################
## Load record instances
dbLoadRecords("$(TOP)/db/devSmarPod.db","P=$(P),R=$(R),PORT=$(ASYN_PORT),A=0")

makeAutosaveFiles()

iocInit()

# var streamDebug 0
# dbpr ZP:SmarPod:X

create_monitor_set("info_positions.req", 5, "")
create_monitor_set("info_settings.req", 30, "")
