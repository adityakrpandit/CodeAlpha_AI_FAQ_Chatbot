# Q1: Display a Message When an Employee Does Not Exist

## Objective
Write a PL/SQL program that accepts an Employee ID and displays an appropriate message when the employee does not exist.

## Step 1: Create the EMP Table

```sql
CREATE TABLE EMP (
    EID NUMBER(5) PRIMARY KEY,
    ENAME VARCHAR2(30),
    DEPTNO NUMBER,
    DEPTNAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    AGE NUMBER,
    BASICCAL NUMBER(10,2)
);
```

## Step 2: Insert Sample Records

```sql
INSERT INTO EMP
VALUES (101, 'Rahul', 10, 'Sales', 'Male', 25, 20000);

INSERT INTO EMP
VALUES (102, 'Priya', 20, 'HR', 'Female', 28, 25000);

INSERT INTO EMP
VALUES (103, 'Amit', 30, 'IT', 'Male', 30, 30000);

COMMIT;
```

## Step 3: Display Employee Records

```sql
SET LINESIZE 150;
SET PAGESIZE 50;

COLUMN ENAME FORMAT A15;
COLUMN DEPTNAME FORMAT A15;
COLUMN GENDER FORMAT A10;

SELECT * FROM EMP;
```

## Step 4: PL/SQL Program

```sql
SET SERVEROUTPUT ON;

DECLARE
    V_ID EMP.EID%TYPE;
    V_NAME EMP.ENAME%TYPE;

BEGIN
    V_ID := &EMPLOYEE_ID;

    SELECT ENAME
    INTO V_NAME
    FROM EMP
    WHERE EID = V_ID;

    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || V_NAME);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist.');

END;
/
```

## Step 5: Test Case 1: Existing Employee

Enter the following Employee ID when prompted:

```text
101
```

Expected Output:

```text
Employee Name: Rahul
PL/SQL procedure successfully completed.
```

## Step 6: Test Case 2: Non-Existing Employee

Execute the program again and enter:

```text
999
```

Expected Output:

```text
Employee does not exist.
PL/SQL procedure successfully completed.
```

## Result

The PL/SQL program successfully displays the employee name when the employee exists and displays an appropriate message when the employee does not exist.

## Concepts Used

- `DECLARE`: Declares variables.
- `%TYPE`: Uses the datatype of an existing table column.
- `SELECT INTO`: Retrieves an employee name into a variable.
- `NO_DATA_FOUND`: Handles the case when no employee record matches the given ID.
- `DBMS_OUTPUT.PUT_LINE`: Displays output.
- `/`: Executes the PL/SQL block in SQL*Plus.
