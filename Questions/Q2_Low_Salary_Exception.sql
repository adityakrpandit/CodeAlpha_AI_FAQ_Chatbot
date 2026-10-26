/*
Q2: Create a user-defined exception LOW_SALARY
and raise it when an employee's salary is below
a specified amount.

Aim:
To understand user-defined exception handling in PL/SQL.

-----------------------------------------
STEP 1: CREATE EMP TABLE
-----------------------------------------
Run only if the EMP table does not already exist.
*/

CREATE TABLE EMP (
    EID NUMBER(5) PRIMARY KEY,
    ENAME VARCHAR2(30),
    DEPTNO NUMBER,
    DEPTNAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    AGE NUMBER,
    BASICSAL NUMBER(10,2)
);

-- STEP 2: INSERT SAMPLE RECORDS

INSERT INTO EMP
VALUES (101, 'Rahul', 10, 'Sales', 'Male', 25, 20000);

INSERT INTO EMP
VALUES (102, 'Priya', 20, 'HR', 'Female', 28, 25000);

INSERT INTO EMP
VALUES (103, 'Amit', 30, 'IT', 'Male', 30, 30000);

COMMIT;

-- STEP 3: DISPLAY EMPLOYEE DATA

SET SERVEROUTPUT ON;

SELECT EID, ENAME, BASICSAL
FROM EMP;

-- STEP 4: PL/SQL PROGRAM

DECLARE
    V_SAL EMP.BASICSAL%TYPE;
    LOW_SALARY EXCEPTION;

BEGIN
    V_SAL := &SALARY;

    IF V_SAL < 15000 THEN
        RAISE LOW_SALARY;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salary is acceptable.');
    END IF;

EXCEPTION
    WHEN LOW_SALARY THEN
        DBMS_OUTPUT.PUT_LINE('Salary is below 15000.');
END;
/

-- STEP 5: TEST CASES
-- Input: 10000
-- Output: Salary is below 15000.
--
-- Input: 20000
-- Output: Salary is acceptable.

-- STEP 6: RESULT
-- The LOW_SALARY user-defined exception was
-- successfully raised and handled.

-- =========================================
-- VIVA QUESTIONS AND ANSWERS (HINGLISH)
-- =========================================

-- Q1. What is an exception in PL/SQL?
-- Ans: Exception ek error ya condition hoti hai
-- jo program ke normal execution ko affect karti hai.

-- Q2. What is a user-defined exception?
-- Ans: Ye ek exception hai jise programmer khud
-- kisi specific condition ko handle karne ke liye banata hai.

-- Q3. How do you declare a user-defined exception?
-- Ans: LOW_SALARY EXCEPTION; likhkar.

-- Q4. What is the purpose of RAISE?
-- Ans: RAISE ka use exception ko manually trigger
-- karne ke liye hota hai.

-- Q5. What is the purpose of the EXCEPTION block?
-- Ans: Iska use program mein aane wali exceptions
-- ko handle karne ke liye hota hai.

-- Q6. What does WHEN LOW_SALARY THEN mean?
-- Ans: Jab LOW_SALARY exception raise hota hai,
-- tab iske andar likha code execute hota hai.

-- Q7. Why is %TYPE used?
-- Ans: %TYPE variable ka datatype table ke column
-- ke datatype ke according set karta hai.

-- Q8. What is the salary limit in this program?
-- Ans: Is program mein salary limit 15000 hai.

-- Q9. What happens when salary is 10000?
-- Ans: LOW_SALARY exception raise hota hai aur
-- "Salary is below 15000." message display hota hai.

-- Q10. What happens when salary is 20000?
-- Ans: Exception raise nahi hota aur
-- "Salary is acceptable." message display hota hai.

-- Q11. Difference between predefined and
-- user-defined exceptions?
-- Ans: Predefined exceptions Oracle mein pehle se
-- hote hain, jabki user-defined exceptions programmer
-- khud declare karta hai.

-- Q12. What is SET SERVEROUTPUT ON?
-- Ans: Isse SQL*Plus mein DBMS_OUTPUT.PUT_LINE
-- ka output display hota hai.

-- Q13. Why is slash (/) used after END;?
-- Ans: SQL*Plus mein slash PL/SQL block ko execute karta hai.

-- Q14. Is LOW_SALARY a predefined exception?
-- Ans: Nahi, ye user-defined exception hai.

-- Q15. Can the salary limit be changed?
-- Ans: Haan, 15000 ki jagah required salary limit
-- likh sakte hain.
