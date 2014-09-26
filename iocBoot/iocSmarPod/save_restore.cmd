### save_restore setup
#
# The rest this file does not require modification for standard use, but...
# If you want save_restore to manage its own NFS mount, specify the name and
# IP address of the file server to which save files should be written.
# This currently is supported only on vxWorks.
#save_restoreSet_NFSHost("host", "ip_addr")

# status-PV prefix
save_restoreSet_status_prefix("$(P_SAVE)")
# Debug-output level
save_restoreSet_Debug(0)

# Ok to save/restore save sets with missing values (no CA connection to PV)?
save_restoreSet_IncompleteSetsOk(1)
# Save dated backup files?
save_restoreSet_DatedBackupFiles(1)

# Number of sequenced backup files to write
save_restoreSet_NumSeqFiles(3)
# Time interval between sequenced backups
save_restoreSet_SeqPeriodInSeconds(3)

# specify where save files should be
set_savefile_path("$(TOP)", "autosave")

# specify directories in which to to search for included request files
# Note cdCommands defines 'startup', but envPaths does not
set_requestfile_path("$(IOC)", "")
set_requestfile_path("$(TOP)", "iocBoot/$(IOC)")
set_requestfile_path("$(EPICS_BASE)", "as/req")

# specify what save files should be restored.  Note these files must be
# in the directory specified in set_savefile_path(), or, if that function
# has not been called, from the directory current when iocInit is invoked
set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=$(P_SAVE)")
