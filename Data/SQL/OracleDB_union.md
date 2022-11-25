## 집합연산자

#### UNION

두개 결과의 합집합을 보여준다. 중복된 행은 하나만 표현한다.

```
select department_id, first_name, salary
from   employees
where  salary = 2600
union
select department_id, first_name, salary
from   employees
where  department_id = 30;
```



#### UNION ALL

두개 결과의 합집합을 보여준다. 중복된 행을 모두 표현한다.

```
select department_id, first_name, salary
from   employees
where  salary = 2600
union all
select department_id, first_name, salary
from   employees
where  department_id = 30;
```



#### INSERSECT

두개의 결과에서 공통된 부분의 행만 표시한다.



#### MINUS

MINUS 앞에 결과에서 MINUS 뒤에 결과를 뺀 행만 표현한다.



