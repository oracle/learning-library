# Using Bitwise Aggregate Functions

## Introduction
This lab shows how to use the new `BIT_AND_AGG`, `BIT_OR_AGG` and `BIT_XOR_AGG` bitwise aggregate functions at the bit level of records within a group. `BIT_AND_AGG`, `BIT_OR_AGG` and `BIT_XOR_AGG` return the result of bitwise AND, OR and XOR operations respectively. These aggregates can be performed on a single numeric column or an expression. The return type of a bitwise aggregate operation is always a number.

Estimated Lab Time: 10 minutes

### Objectives
In this lab, you will:
* Test the bitwise AND function
* Test the bitwise OR function
* Test the bitwise XOR function

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Test the bitwise AND function

1. Connect to `PDB21` as `SYSTEM` to query values with numbers and bitwise aggregate functions.


    ```

    $ <copy>sqlplus system@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:

    SQL>

    ```

2.  A bitwise AND is a binary operation that takes two equal-length binary representations and performs the logical AND operation on each pair of the corresponding bits. If both bits in the compared position are 1, the bit in the resulting binary representation is 1, otherwise, the result is 0. Apply the `BIT_AND_AGG` function on two numbers. The bit pattern for the values used in the examples below are 01 for 1, 10 for 2, and 11 for 3.

    ```
    SQL> <copy>
    WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual)
    SELECT BIT_AND_AGG(c1) FROM x;</copy>

    BIT_AND_AGG(C1)
    ---------------
                  2
    SQL>

    ```

## **STEP 2:** Test the bitwise OR function

A bitwise OR is a binary operation that takes two bit patterns of equal length and performs the logical inclusive OR operation on each pair of corresponding bits. The result in each position is 0 if both bits are 0, otherwise the result is 1.

1. Apply the `BIT_OR_AGG` function on two numbers.

    ```

    SQL> <copy>WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual)
                  SELECT BIT_OR_AGG(c1) FROM x;</copy>

    BIT_OR_AGG(C1)
    --------------
                3

    SQL>

    ```

## **STEP 3:** Test the bitwise XOR function

A bitwise XOR is a binary operation that takes two bit patterns of equal length and performs the logical exclusive OR operation on each pair of corresponding bits. The result in each position is 1 if only the first bit is 1 or only the second bit is 1, but will be 0 if both are 0 or both are 1. Therefore, the comparison of two bits results in 1 if the two bits are different, and 0 if they are equal.

1. Apply the `BIT_XOR_AGG` function on two numbers.

    ```

    SQL> <copy>WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual)
                  SELECT BIT_XOR_AGG(c1) FROM x;</copy>

    BIT_XOR_AGG(C1)
    ---------------
                  1

    SQL> <copy>EXIT</copy>
    $

    ```


You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
