-- 서브쿼리

-- 단일행 서브쿼리: 결과가 하나의 행이여야 한다. 2개 이상이면 오류난다.
SELECT *
FROM employees A

WHERE A.salary = (
                  SELECT salary
                  FROM employees
                  WHERE last_name = 'De Haan'
                  );

-- 이것과 같다
SELECT *
FROM employees A

WHERE A.salary = 17000;

-- 다중행 서브쿼리
SELECT *
FROM employees A

WHERE A.salary IN (
                   SELECT MIN(salary) 최저급여
                   FROM employees
                   GROUP BY department_id
                   )
ORDER BY A.salary DESC;

-- 다중열 서브쿼리
SELECT *
FROM employees A
WHERE (A.job_id, A.salary) IN (
                               SELECT job_id, MIN(salary) 그룹별급여
                               FROM employees
                               GROUP BY job_id
                               )
ORDER BY A.job_id DESC;

-- FROM 절 서브쿼리 (인라인 뷰)
SELECT *
FROM employees AS A,
                ( SELECT department_id
                  FROM departments
                  WHERE department_name ='IT') AS B
WHERE A.department_id = B.department_id;


