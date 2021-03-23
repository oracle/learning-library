# Oracle® Cloud Use the Scratchpad In Oracle Machine Learning Notebooks
## Before You Begin

This lab shows you how to use the Scratchpad in Oracle Machine Learning Notebooks.

This lab takes approximately 10 minutes to complete.

### Background
The Scratchpad provides you convenient one-click access to a notebook for running SQL statements, PL/SQL scripts, and Python scripts that can be renamed. The Scratchpad is available on the Oracle Machine Learning Notebook Home Page. The Scratchpad is a regular notebook that is prepopulated with three paragraphs - `%sql`, `%script`, and `%python`.

After you run your scripts, the Scratchpad is automatically saved as a notebook by the default name Scratchpad in the Notebooks page. You can access it later in the Notebooks page.
You can run all the paragraphs together or one paragraph at a time.

### What Do You Need?

* Access to your Oracle Machine Learning account
* A project created in your Oracle Machine Learning account, where the notebook will reside


## Use the Scratchpad to Run Python Scripts

To open and use the scratchpad, click <b>Scratchpad</b> on the Oracle Machine Learning home page under Quick Actions.

  ![developer_homepage.png](images/developer_homepage.png "developer_homepage.png ")

  The Scratchpad opens. The Scratchpad has three paragraphs each with the following directives:

  * `%sql`- Allows you to run SQL statements.
  * `%script` - Allows you to run PL/SQL scripts.
  * `%python` - Allows you to run Python scripts.

To run python script:

1. Go to the paragraph with the <code>%python</code> directive.

   ![scratchpad_py.png](images/scratchpad_py.png "scratchpad_py.png")

2. To use OML4Py, you must first import the `oml` module.
   `oml` is the OML4Py module that allows you to manipulate Oracle Database objects such as tables and views, call user-defined Python functions using embedded execution, and use the database machine learning algorithms. To import the `oml` module, type the following command and click the Run icon. Alternatively, you can press **Shift+Enter** keys to run the paragraph.


    ```
    import oml

    ```

3. To check if the <code>oml</code> module is connected to Oracle Database,
   type the following command and click the <b>Run</b>icon. Alternatively, you can press **Shift+Enter** keys to run the paragraph.

    ```
    oml.isconnected()

    ```

4. You are now ready to run your Python script. Type the following Python code and click the run
   icon. Alternatively, you can press **Shift+Enter** keys to run the paragraph.

   ```
    import matplotlib.pyplot as plt
    import numpy as np

    list1 = np.random.rand(10)*2.1
    list2 = np.random.rand(10)*3.0

    plt.subplot(1,2,1) # 1 line, 2 rows, index nr 1 (first position in subplot)
    plt.hist(list1)
    plt.subplot(1, 2, 2) # 1 line, 2 rows, index nr 2 (second position in subplot)
    plt.hist(list2)
    plt.show()

    ```

       ![scratchpad_python.png](images/scratchpad_python.png "scratchpad_python.png")

       In this example, the commands import two python packages to compute and render the data in two histograms for `list1` and `list2`. The Python packages are:

       * Matplotlib - Python package to render graphs.
       * Numpy - Python package for computations.

5. After you have created and run your scripts in the Scratchpad, the Scratchpad is automatically saved as a notebook by the name default name `Scratchpad` in
the Notebooks page. You can edit the name and save it with a new name by selecting the notebook and clicking **Edit**.

## Use the Scratchpad to Run SQL Statements

To run SQL statements:

1. Go to the paragraph with the `%sql` directive.

   ![scratchpad_sql.png](images/scratchpad_sql.png "scratchpad_sql.png")

2. Type the following command and click the Run icon. Alternatively, you can pres **Shift+Enter** keys to run the paragraph.


    ```
    SELECT * FROM SH.SALES;

    ```
       ![sql_statement.png](images/sql_statement.png "sql_statement.png")

    In this example, the SQL statement fetches all of the data about product sales from the table SALES. Here, `SH` is the schema name, and `SALES` is the table name. Oracle Machine Learning fetches the relevant data from the database and displays it in a tabular format.

## Use the Scratchpad to Run PL/SQL Scripts  

To run PL/SQL scripts:

1. Go to the paragraph with the `%script` directive.

   ![scratchpad_script.png](images/scratchpad_script.png "scratchpad_script.png")

2. Enter the following PL/SQL script and click the Run icon. Alternatively, you can press **Shift+Enter** keys to run the paragraph.

    ```
    CREATE TABLE small_table
    (
    NAME VARCHAR(200),
    ID1 INTEGER,
    ID2 VARCHAR(200),
    ID3 VARCHAR(200),
    ID4 VARCHAR(200),
    TEXT VARCHAR(200)
    );

    BEGIN
    FOR i IN 1..100 LOOP
    INSERT INTO small_table VALUES ('Name_'||i, i,'ID2_'||i,'ID3_'||i,'ID4_'||i,'TEXT_'||i);
    END LOOP;
    COMMIT;
    END;

    ```
    The PL/SQL script successfully creates the table SMALL_TABLE. The PL/SQL script in this example contains two parts:

    * The first part of the script contains the SQL statement `CREATE TABLE` to create a table named **small_table**. It defines the table name, table column, data types, and size. In this example, the column names are `NAME, ID1, ID2, ID3, ID4`, and `TEXT`.
    * The second part of the script begins with the keyword `BEGIN`. It inserts 100 rows in to the table small_table.


         ![plsql_procedure.png](images/plsql_procedure.png "plsql_procedure.png")

## Acknowledgements
* **Author** : Mark Hornick, Sr. Director, Data Science / Machine Learning PM, Moitreyee Hazarika, Principal User Assistance Developer, DB Development - Documentation

* **Last Updated By/Date**: Dimpi Sarmah, September 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
