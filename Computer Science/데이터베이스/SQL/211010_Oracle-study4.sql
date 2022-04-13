-- 조인 (Join)
-- 동등 조인 (equi join, inner join)
SELECT A.employee_id, A.department_id, B.department_name, C.location_id, C.city
FROM employees A, departments B, locations C
WHERE A.department_id = B.department_id
AND B.location_id = C.location_id;

SELECT COUNT(*) -- 1건이 누락됨을 알수있다. 이는 NULL값은 무시하기 때문이다. 이를 방지하기 위해 외부조인을 사용하자.
FROM employees A, departments B, locations C
WHERE A.department_id = B.department_id
AND B.location_id = C.location_id;

-- 외부 조인: 참조하는 테이블에 (+)를 붙여서 없으면 Null을 만들게 한다.
SELECT A.employee_id, A.first_name, A.last_name, B.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id = B.department_id(+) -- 레프트 아웃터 조인
ORDER BY A.employee_id;

-- 자체 조인: 자기 테이블의 값을 참조할때
SELECT A.employee_id, A.first_name, A.last_name, A.manager_id, B.first_name||' '||B.last_name manager_name
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
ORDER BY A.employee_id;


-- 집합 연산자
-- 조인이 양옆으로 늘리는 방식이라면, 여기는 위아래로 늘리는 방식과 유사하다

-- Union (합집합) : Union all을 사용하면 합집합에 중복된 항목을 제거하지 않고 전부 출력
SELECT department_id
FROM employees
UNION
SELECT department_id
FROM departments;

-- Intersect (교집합)
SELECT department_id
FROM employees
INTERSECT
SELECT department_id
FROM departments
ORDER BY department_id;

-- Minus (차집합)
SELECT department_id -- 남는것
FROM departments
MINUS
SELECT department_id -- 빼는쪽
FROM employees;

