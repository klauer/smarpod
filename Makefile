# Makefile for Asyn SmarPod support
#
# Created by nanopos on Fri Jun 10 15:23:12 2011
# Based on the Asyn streamSCPI template

TOP = .
include $(TOP)/configure/CONFIG

DIRS := configure
#DIRS += StreamDevice
DIRS += $(wildcard *[Ss]up)
DIRS += $(wildcard *[Aa]pp)
DIRS += $(wildcard ioc[Bb]oot)

include $(TOP)/configure/RULES_TOP
