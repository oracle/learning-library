# Forcing Upgraded Password File to be Case Sensitive

## Introduction

This lab shows how the passwords in the password files in Oracle Database 21c are case-sensitive. In earlier Oracle Database releases, password files by default retain their original case-insensitive verifiers. The parameter to enable or disable password file case sensitivity `IGNORECASE` is removed. All passwords in new password files are case-sensitive.

Estimated Lab Time: 2 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Display the password file format of CDB21

1. Display the password file format of CDB21

	```

	$ <copy>cd $ORACLE_BASE/dbs</copy>
	$ <copy>ls -l orapwCDB21</copy>
	-rw-r----- 1 oracle oinstall 2048 Mar  5 09:48 orapwCDB21
	$ <copy>orapwd describe file=orapwCDB21</copy>
	Password file Description : format=12
	$

	```

## **STEP 2:** Change `SYS` password and verify that the password is now case-sensitive

1. Change the `SYS` user password in the password file.

	```

	$ <copy>orapwd file=$ORACLE_BASE/dbs/orapwCDB21 sys=Y force=Y format=12 ignorecase=Y</copy>

	Usage 1: orapwd file=<fname> force={y|n} asm={y|n}

				dbuniquename=<dbname> format={12|12.2}

				delete={y|n} input_file=<input-fname>

				'sys={y | password | external(<sys-external-name>)

					| global(<sys-directory-DN>)}'

				'sysbackup={y | password | external(<sysbackup-external-name>)

							| global(<sysbackup-directory-DN>)}'

				'sysdg={y | password | external(<sysdg-external-name>)

						| global(<sysdg-directory-DN>)}'

				'syskm={y | password | external(<syskm-external-name>)

						| global(<syskm-directory-DN>)}'

	Usage 2: orapwd describe file=<fname>

		where

		file   - name of password file (required),

		password

				- password for SYS will be prompted

				if not specified at command line.

				Ignored, if input_file is specified,

		force  - whether to overwrite existing file, also clears

				CRS resource if it already has password file

				registered (optional),

		asm    - indicates that the ASM instance password file is to

				be stored in Automatic Storage Management (ASM)

				disk group (optional),

		dbuniquename

				- unique database name used to identify database

				password files residing in ASM diskgroup

				or Exascale Vault.

				Ignored when asm option is specified (optional),

		format - use format=12 for new 12c features like SYSBACKUP, SYSDG

				and SYSKM support, longer identifiers, SHA2 Verifiers etc.

				use format=12.2 for 12.2 features like enforcing user

				profile (password limits and password complexity) and

				account status for administrative users.

				If not specified, format=12.2 is default (optional),

		delete - drops a password file. Must specify 'asm',

				'dbuniquename' or 'file'. If 'file' is specified,

				the file must be located on an ASM diskgroup

				or Exascale Vault,

		input_file

				- name of input password file, from where old user

				entries will be migrated (optional),

		sys    - specifies if SYS user is password, externally or

				globally authenticated.

				For external SYS, also specifies external name.

				For global SYS, also specifies directory DN.

				SYS={y | password} specifies if SYS user password needs

				to be changed when used with input_file,

		sysbackup

				- creates SYSBACKUP entry (optional).

				Specifies if SYSBACKUP user is password, externally or

				globally authenticated.

				For external SYSBACKUP, also specifies external name.

				For global SYSBACKUP, also specifies directory DN.

				Ignored, if input_file is specified,

		sysdg  - creates SYSDG entry (optional).

				Specifies if SYSDG user is password, externally or

				globally authenticated.

				For external SYSDG, also specifies external name.

				For global SYSDG, also specifies directory DN.

				Ignored, if input_file is specified,

		syskm  - creates SYSKM entry (optional).

				Specifies if SYSKM user is password, externally or

				globally authenticated.

				For external SYSKM, also specifies external name.

				For global SYSKM, also specifies directory DN.

				Ignored, if input_file is specified,

		describe

				- describes the properties of specified password file

				(required).

		There must be no spaces around the equal-to (=) character.

	$

	```

  *The usage notes mention all parameters that can be used in the command. `IGNORECASE` is not mentioned because it is now a deprecated parameter.*

2. Re-enter the command without the deprecated parameter.


	```

	$ <copy>orapwd file=$ORACLE_BASE/dbs/orapwCDB21 sys=Y force=Y format=12</copy>

	Enter password for SYS: <i>WElcome123##</i>

	$

	```

3. Log on as `SYS` to `CDB21`. Then try logging in with the same password but without using the correct case.


	```

	$ <copy>sqlplus sys@CDB21 AS SYSDBA</copy>

	Enter password: <i>WElcome123##</i>

	Connected to:
	```
	```

	SQL> <copy>CONNECT sys@CDB21 AS SYSDBA</copy>

	Enter password: <i>welcome123##</i>

	ERROR:

	ORA-01017: invalid username/password; logon denied

	Warning: You are no longer connected to ORACLE.

	SQL>

	```

4. Display the list of the users.


	```

	SQL> <copy>CONNECT sys@CDB21 AS SYSDBA</copy>

	Enter password: <i>WElcome123##</i>

	Connected.
	```
	```

	SQL> <copy>SET PAGES 100</copy>

	SQL> <copy>COL username FORMAT A30</copy>

	SQL> <copy>SELECT username, password_versions FROM dba_users ORDER BY 2,1;</copy>

	USERNAME                       PASSWORD_VERSIONS

	------------------------------ -----------------

	SYS                            11G 12C

	SYSTEM                         11G 12C

	ANONYMOUS

	APPQOSSYS

	AUDSYS

	CTXSYS

	...

	SQL> <copy>EXIT</copy>

	$

	```

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
