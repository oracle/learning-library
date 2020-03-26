## GoldenGate Cloud Service Workshop FAQ

### **Q: Is there a way to easily clean up the environment if an error is made?**

- A: Yes. There are cleanup obey files under the $GGHOME/dirprm/cleanup folder on both the On Premise and GGCS installations.

Each obey file from the lab has a cleanup “mirror” that will undo any process registrations/adds as well as delete the corresponding trails and report files. There is also a CLEAN_ALL.oby that will clean up everything in that environment.

| Lab Number    | Create Obeys                   | Cleanup Obeys                       |
| ------------- |--------------------------------| ------------------------------------|
| Lab 200       | ADD_EURO_EXTRACT.oby (On Prem) | CLEAN_EURO_EXTRACT.oby (On Prem)    |
|               | ADD_AMER_REPLICAT.oby (GGCS)   | CLEAN_AMER_REPLICAT.oby (GGCS)      | 
| Lab 300       | ADD_AMER_EXTRACT.oby (GGCS)    | CLEAN_AMER_EXTRACT.oby (GGCS)       |
|               | ADD_EURO_REPLICAT.oby (On Prem)| CLEAN_EURO_REPLICAT.oby (On Prem)   |
| Lab 400       | ADD_DW_ALL.oby (GGCS)          | CLEAN_DW_ALL.oby (GGCS)             |
| Lab 500       | N/A                            | N/A                                 |

***NOTE OF CAUTION:*** Do not run the cleanup script on the target (ex. CLEAN_AMER_REPLICAT.oby on the GGCS instance) after starting the GoldenGate pump process (i.e. PEURO) on he source. The cleanup script will delete the remote trail. If this happens you will then need to clean the source and rerun the source setup file (i.e. CLEANUP_EURO_EXTRACT followed by ADD_EURO_EXTRACT.oby). You could also delete and re-add the pump manually.

### **Q: Why does the Lag in ggsci show unknown?**

- A: The time zones and system clocks of the on prem, GGCS, and DBCS instances need to be adjusted to get proper lag measurements supported. This was not deemed a requirement for the workshop