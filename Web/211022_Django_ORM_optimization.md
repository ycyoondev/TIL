# 211022 TIL

> ORM을 써서 원하는 결과를 얻을 수 있는 방법은 하나가 아니다. 또한 views에서 작업을 처리하고 html로 보낼 수 있고, html에서 django tag를 이용해서 데이터를 처리할 수 있다. 각자의 방법에 장단점이 있다. 속도 면에서 작업 방식에 따라 결과를 확인하고, 이를 최적화하는 방법을 정리한다.



## 더미 데이터 만들기

더미 데이터란 테스트를 위해 의미없는 데이터를 채워두는 행위 입니다. ORM 효율 측정을 위해 실제 규모의 환경이 필요하며, 이를 위해서 더미 데이터를 만드는 방법을 먼저 확인하겠습니다. 더미데이터를 만드는 방법에는 여러가지가 있습니다. 크게 분류하여 다음과 같습니다.

1. 직접 하나씩 생성한다.
2. 생성 패키지를 이용한다. ex) django-seed
3. django_shell을 이용한다.

각각 장단점이 확실한것 같은데, 여기서는 3번을 바탕으로 진행하겠습니다.

### 

### 생성 따라하기

#### 1. Django shell 인스톨

> Django-extensions 라이브러리가 shell 기능을 하며, ipython은 가독성을 높여줍니다.

```bash
$ pip install django-extensions
$ pip install ipython
```

```python
# settings.py
INSTALLED_APPS = [
    ...,
    'django_extensions',
    ...,
]
```



다음은 기본적인 shell 실행과 탈출 방법입니다.

```bash
# 실행
$ python manage.py shell_plus

# 탈출
In []: exit()
```



#### 2. 

