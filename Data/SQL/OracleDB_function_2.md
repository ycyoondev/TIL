## 단일행 함수

> 단일행 함수는 하나의 행(row)에서 하나의 결과를 리턴한다.

### Null 함수

#### NVL

NVL(data, a1)에서 data가 null이면 a1을 반환한다.

```
select NVL(null, 10)
from   dual;
-> 10
```



#### NVL2

NVL2(data, a1, a2)에서 data가 null이 아니면 a1을 반환하고, null이면 a2를 반환한다.

```
select NVL2(null, 10, 20)
from   dual;
-> 20
```



#### NULLIF

NULLIF(a1, a2)에서 a1==a2면 null을 반환하고, 아니면 a1을 반환한다.

```
select NULLIF(10, 10)
from   dual;
-> null
```



#### COALESCE

COALESCE(a1, a2, a3 ... aN)에서 처음 나오는 null이 아닌 값을 반환한다.

```
select COALESCE(null, null, 10, 20)
from   dual;
-> 10
```



### 조건부표현식

#### DECODE

if / elif / else 와 유사하다.

DECODE(data, a1, b1,

​							a2, b2.

​							a3, b3,

​									b4) 

에서 data가 aN인 조건에서 bN을 반환하고, 아무것도 아닌(else) 경우 b4를 반환한다.

마지막 else가 없다면 없는 조건에서 null을 반환한다. 

```
select first_name, department_id, salary,
       decode(department_id, 60, salary*1.1, 
                            100, salary*1.2,
                             50, salary*1.3, 
                                 salary) decode1
from   employees;
```



#### CASE

DECODE 식에서 조건표현식을 사용한다는 차이가 있다.

CASE WHEN `조건식` THEN `반환식` 

```sql
select first_name, department_id, salary,
       case when department_id = 60  then salary*1.1
            when department_id = 100 then salary*1.2
            when department_id = 50  then salary*1.3
            else salary
       end case1     
from   employees;
--------------
select first_name, department_id, salary,
       case when salary < 5000                      then 'low'
            when salary >= 5000  and salary < 10000 then 'med'
            when salary >= 10000 and salary < 20000 then 'high'
            when salary >= 20000                    then 'very high'
       end case1,   
       case when salary < 5000                      then 'low'
            when salary >= 5000  and salary < 10000 then 'med'
            when salary >= 10000 and salary < 20000 then 'high'
            else 'very high'
       end case2     
from   employees;
```

