-- 함수연습
-- 실습용 HR 이용

-- 대소문자 전환
SELECT last_name,
       LOWER(last_name) LOWER적용,
       UPPER(last_name) UPPER적용,
       email,
       INITCAP(email) INITCAP적용
FROM employees;

-- 문자 추출
SELECT job_id, SUBSTR(job_id, 1, 2) 적용결과
FROM   employees;

-- 특정 문자 바꾸기
SELECT job_id, REPLACE(job_id, 'ACCOUNT', '계좌') 적용결과
FROM   employees;

-- 자리 채우기
SELECT first_name, LPAD(first_name, 12, '*') 적용결과
FROM   employees;

-- 특정 문자 삭제
SELECT job_id,
       LTRIM(job_id, 'F') LTRIM적용결과,
       RTRIM(job_id, 'T') RTRIM적용결과
FROM   employees;





