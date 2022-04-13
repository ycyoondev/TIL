-- DML (Data Manipulartion Language)
-- insert (행 삽입)
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES
(271, 'Sample_Dept', 200, 1700);

SELECT *
FROM departments;

commit; -- 커밋을 통해 DB에 반영할 수 있다.


-- update
UPDATE departments
SET manager_id = 201,
    location_id = 1800
WHERE department_name = 'Sample_Dept';


UPDATE departments
SET    (manager_id, location_id) = (Select manager_id, location_id
                                    FROM   departments
                                    WHERE  department_id = 40) -- 조건을 구해서 변경 (서브쿼리)
WHERE  department_name = 'Sample_Dept';

-- delete
DELETE FROM departments
WHERE department_name = 'Sample_Dept';

SELECT *
FROM departments;

commit;



