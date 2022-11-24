## JOIN

### 표현식

#### 표준 join

ANSI 표준에서 ON절 이외에도 Natural, using 등 다른 표준들이 있다.

하지만 on절이 범용성이 넓어 이것만 사용하겠다.

```
select e.employee_id, e.first_name, e.department_id, 
       d.department_id, d.department_name
from   employees e    join   departments d
on     e.department_id = d.department_id;
```



#### Oracle join

오라클에서만 사용할 수 있는 join 방법이다.

```
select e.employee_id, e.first_name, e.department_id, 
       d.department_id, d.department_name
from   employees e, departments d
where  e.department_id = d.department_id;
```



### Inner / Outer join

#### Inner join

위 표현식에서 예시가 inner join이다. sql은 inner join을 기본으로 한다. 명시적으로 하려면 inner를 추가하면된다.

```
select e.employee_id, e.first_name, e.department_id, 
       d.department_id, d.department_name
from   employees e   inner join   departments d
on     e.department_id = d.department_id;
```



#### Outer join

join 조건을 충족하지 못하는 행도 null을 사용해서 함께 표시하는 방법이다.

```
select e.employee_id, e.first_name, e.department_id, 
       d.department_id, d.department_name
from   employees e  left outer join   departments d
on     e.department_id = d.department_id;


select e.employee_id, e.first_name, e.department_id, 
       d.department_id, d.department_name
from   employees e  right outer join   departments d
on     e.department_id = d.department_id;
```

left, right는 기준이 되는 table을 지정한다. 기준이되는 table은 꼭 행에 나타내고, join 상대 결과가 없다면 null로 처리해서 나타낸다.



## Subquery

### Single-row

한 행만 반환한다. 조건문에서 주로 사용한다.

```
select employee_id, first_name, department_id, salary
from   employees
where  salary > (select avg(salary)
                 from   employees);
```



### Multiple-row 

#### rownum (limit 유사)

오라클에서는 limit 대신 rownum을 사용한다. 이때 내부에 subquery로 원하는 테이블을 만들고, rownum을 사용해야한다.

```
select department_id, avg_sal
from   (select department_id, round(avg(salary)) avg_sal
        from   employees
        group by department_id
        order by round(avg(salary)) desc)
where  rownum <= 3;
```

