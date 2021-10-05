-- 숫자 타입 함수
-- 반올림
SELECT salary,
       salary/30 일급,
       ROUND(salary/30, 0) 적용결과0,
       ROUND(salary/30, 1) 적용결과1,
       ROUND(salary/30, -1) 적용결과2
FROM   employees;

-- 숫자 버림
SELECT salary,
       salary/30 일급,
       TRUNC(salary/30, 0) 적용결과0,
       TRUNC(salary/30, 1) 적용결과1,
       TRUNC(salary/30, -1) 적용결과2
FROM   employees;

-- 날짜 타입 함수
-- 날짜 사이 계산 (달)
SELECT SYSDATE, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) 적용결과
FROM   employees
WHERE  department_id = 100;

-- 월에 달 더하기
SELECT hire_date,
       ADD_MONTHS(hire_date, 3) 더하기_적용결과,
       ADD_MONTHS(hire_date, -3) 빼기_적용결과
FROM   employees
WHERE  employee_id BETWEEN 100 AND 106;

-- 돌아오는 요일 날짜가 언제인지
SELECT hire_date,
       NEXT_DAY(hire_date, '금요일') 문자지정,
       NEXT_DAY(hire_date, 6) 숫자지정
FROM   employees
WHERE  employee_id BETWEEN 100 AND 106;

-- 그 달의 마지막 날 계산
SELECT hire_date,
       LAST_DAY(hire_date) 적용결과
FROM   employees
WHERE  employee_id BETWEEN 100 AND 106;



