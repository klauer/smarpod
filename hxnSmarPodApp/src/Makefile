TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = hxnSmarPod
# hxnSmarPod.dbd will be created and installed
DBD += hxnSmarPod.dbd

# hxnSmarPod.dbd will be made up from these files:
hxnSmarPod_DBD += base.dbd
hxnSmarPod_DBD += stream.dbd
hxnSmarPod_DBD += asyn.dbd drvAsynIPPort.dbd drvAsynSerialPort.dbd
hxnSmarPod_DBD += calcSupport.dbd

# Autosave
hxnSmarPod_DBD += asSupport.dbd

hxnSmarPod_DBD += system.dbd
hxnSmarPod_DBD += devIocStats.dbd
hxnSmarPod_DBD += caPutLog.dbd

# Add all the support libraries needed by this IOC
hxnSmarPod_LIBS += asyn stream calc 
hxnSmarPod_LIBS += autosave
hxnSmarPod_LIBS += devIocStats
hxnSmarPod_LIBS += caPutLog

# hxnSmarPod_registerRecordDeviceDriver.cpp derives from hxnSmarPod.dbd
hxnSmarPod_SRCS += hxnSmarPod_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
hxnSmarPod_SRCS_DEFAULT += hxnSmarPodMain.cpp
hxnSmarPod_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#hxnSmarPod_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
hxnSmarPod_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

