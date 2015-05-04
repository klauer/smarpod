#!../../bin/linux-x86_64/hxnSmarPod
	
# NOTE: if not using procServ, set IOCNAME
# 	epicsEnvSet("IOCNAME"             , "zp_smarpod")

epicsEnvSet("ENGINEER", "klauer x3615")
epicsEnvSet("LOCATION", "740 3IDC RG:I3")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST"     , "10.3.0.255")

epicsEnvSet("SYS"                    , "XF:03IDC-ES")
epicsEnvSet("CT_SYS"                 , "XF:03IDC-CT")
epicsEnvSet("DEV"                    , "SPod:1")

# Note: $IOCNAME set by softioc init.d script
epicsEnvSet("IOC_PREFIX"             , "$(CT_SYS){IOC:$(IOCNAME)}")

< envPaths
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/SmarPodSup")

###############################################################################
## TODO: smarpod IP change
epicsEnvSet("SMARPOD_IP", "$(SMARPOD_IP=10.3.2.185)")
epicsEnvSet("SMARPOD_PORT", "$(SMARPOD_PORT=2000)")
epicsEnvSet("ASYN_PORT", "SP_PORT")

## Register all support components
dbLoadDatabase("$(TOP)/dbd/hxnSmarPod.dbd",0,0)
hxnSmarPod_registerRecordDeviceDriver(pdbbase) 

###############################################################################
# Set up ASYN ports
drvAsynIPPortConfigure("$(ASYN_PORT)","$(SMARPOD_IP):$(SMARPOD_PORT)",0,0,0)
asynOctetSetInputEos("$(ASYN_PORT)", -1, "\n")
asynOctetSetOutputEos("$(ASYN_PORT)", -1, "\n")
asynSetTraceIOMask("$(ASYN_PORT)",-1,0)
asynSetTraceMask("$(ASYN_PORT)",-1,0)
#asynSetTraceIOMask("$(ASYN_PORT)",-1,0x2)
#asynSetTraceMask("$(ASYN_PORT)",-1,0x9)

cd $(TOP)/iocBoot/$(IOC)

###############################################################################
## Load record instances
dbLoadRecords("$(TOP)/db/devSmarPod.db", "Sys=$(SYS),Dev=$(DEV),PORT=$(ASYN_PORT),A=0")
# dbLoadRecords("$(TOP)/db/hxn_smarpod.db", "P=$(SYS),R=$(DEV),PORT=$(ASYN_PORT),A=0")

set_savefile_path("${TOP}/as/save","")
set_requestfile_path("$(EPICS_BASE)/as/req")
set_requestfile_path("${TOP}/as/req")

system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

cd $(TOP)/as/req
makeAutosaveFiles()

# set_pass0_restoreFile("info_positions.sav")
# set_pass0_restoreFile("info_settings.sav")

dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db","P=$(IOC_PREFIX)")
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_PREFIX)")
save_restoreSet_status_prefix("$(IOC_PREFIX)")
# asSetFilename("/cf-update/acf/default.acf")

# var streamDebug 1
iocInit()

var streamDebug 0
# dbpr ZP:SmarPod:X

# create_monitor_set("info_positions.req", 5, "")
# create_monitor_set("info_settings.req", 30, "")

cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
