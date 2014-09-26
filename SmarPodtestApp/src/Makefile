TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = SmarPodtest
# SmarPodtest.dbd will be created and installed
DBD += SmarPodtest.dbd

# SmarPodtest.dbd will be made up from these files:
SmarPodtest_DBD += base.dbd
SmarPodtest_DBD += stream.dbd
SmarPodtest_DBD += asyn.dbd drvAsynIPPort.dbd drvAsynSerialPort.dbd
SmarPodtest_DBD += calcSupport.dbd

# Autosave
SmarPodtest_DBD += asSupport.dbd

# Include dbd files from all support applications:
#SmarPodtest_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
SmarPodtest_LIBS += asyn stream calc 
SmarPodtest_LIBS += autosave

# SmarPodtest_registerRecordDeviceDriver.cpp derives from SmarPodtest.dbd
SmarPodtest_SRCS += SmarPodtest_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
SmarPodtest_SRCS_DEFAULT += SmarPodtestMain.cpp
SmarPodtest_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#SmarPodtest_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
SmarPodtest_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

