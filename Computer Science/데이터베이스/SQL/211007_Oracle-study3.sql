-- 일반 함수
-- Null 처리
SELECT salary * NVL(commission_pct, 1) New  --NVL(A, B)는 A열의 Null을 B로 치환한다는 의미이다.
FROM   employees
ORDER BY commission_pct;

-- 논리 조건 처리
-- DECODE(열 이름, 조건 값, 치환값, 기본값)
SELECT first_name,
       last_name,
       department_id,
       salary 원래급여,
       DECODE(department_id, 60, salary*1.1, salary) 조정된급여, -- 부서id 60이면 급여인상
       DECODE(department_id, 60, '10%인상', '미인상') 인상여부
FROM   employees;

-- CASE 조건 END
SELECT employee_id, first_name, last_name, salary,
       CASE
            WHEN salary >= 9000 THEN '상위급여'
            WHEN salary BETWEEN 6000 AND 8999 THEN '중위급여'
            ELSE '하위급여'
       END AS 급여등급  -- AS 안쓰면 위에 전체가 컬럼이름이다
FROM   employees
WHERE  job_id = 'IT_PROG';

-- 데이터 순위
-- RANK () OVER([PARTITION BY 열이름] ORDER BY 열이름) // 여기서 []는 옵션임
SELECT employee_id,
       salary,
       RANK()       OVER(ORDER BY salary DESC) RANK_급여, -- 일반적인 순위
       DENSE_RANK() OVER(ORDER BY salary DESC) DENSE_RANK_급여, -- 공통순위 무시한 순위
       ROW_NUMBER() OVER(ORDER BY salary DESC) ROW_NUMBER_급여 -- 공통순위 없음
FROM   employees;

-- 그룹핑
SELECT job_id 직무, SUM(salary) 직무별총급여, AVG(salary) 직무별평균급여
FROM   employees
WHERE  employee_id >= 10
GROUP BY job_id, manager_id  -- 두번 그룹핑 가능
ORDER BY 직무별총급여 DESC, 직무별평균급여;

--






