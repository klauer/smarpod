SmarAct SmarPod EPICS Driver
============================

EPICS StreamDevice driver for SmarAct SmarPod Piezo Hexapod controller.

Requirements
------------

Though it may work on other versions, the driver was tested on these:

1. EPICS base 3.14.12.3 http://www.aps.anl.gov/epics/
2. asyn 4-18 http://www.aps.anl.gov/epics/modules/soft/asyn/
3. StreamDevice 2.5+ http://epics.web.psi.ch/software/streamdevice/

Optional
--------

1. EDM http://ics-web.sns.ornl.gov/edm/log/getLatest.php

Installation
------------

1. Install EPICS
    1. If using a Debian-based system (e.g., Ubuntu), use the packages here http://epics.nsls2.bnl.gov/debian/
    2. If no packages are available for your distribution, build from source
2. Edit configure/RELEASE
    1. Point the directories listed in there to the appropriate places
    2. If using the Debian packages, everything can be pointed to /usr/lib/epics
3. Edit iocBoot/iocSmarPod/st.cmd
    1. Change the shebang on the top of the script if your architecture is different than linux-x86:
        #!../../bin/linux-x86/hxnSmarPod
        (check if the environment variable EPICS_HOST_ARCH is set, or perhaps `uname -a`, or ask someone if
         you don't know)
    2. The following lines set the prefix to all of the additional (i.e., non-motor record) PVs (with $(P)$(R)):
        ```
        epicsEnvSet "P" "$(P=E1:)"
        epicsEnvSet "R" "$(R=SmarPod:)"
        ```
       Set the second quoted strings appropriately.
    3. Set the IP address of the controller here:
        ```
        epicsEnvSet "SMARPOD_IP" "$(SMARPOD_IP=10.0.3.9)"
        epicsEnvSet "SMARPOD_PORT" "$(SMARPOD_PORT=2000)"
        ```
        The port should not be changed.

    4. For each device, load the necessary records:
        ```
        dbLoadRecords("$(TOP)/db/devSmarPod.db","P=$(P),R=$(R),PORT=$(ASYN_PORT),A=0")
        ```

4. Go to the top directory and `make`
5. If all goes well:
    ```
    $ cd iocBoot/iocSmarPod
    $ chmod +x st.cmd
    $ ./st.cmd
    ```

6. Run EDM:
    ```
    $ export EDMDATAFILES=$TOP/op/edl:$EDMDATAFILES
    $ edm -x -m "P=E1:,R=SmarPod:" smarpod
    ```
