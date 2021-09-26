# 210927 TIL

## Web Framework: Django 

> Django를 이용하여 사용자 기반 게시판 CRUD를 구현한다. 
>
> 지난 210925에 구현한 CRUD에 User 관리 및 권한을 부여하였다.
>
> 기본적인 기능은 암기로 구현하고 싶어, 최대한 참고 없이 VS code의 자동완성 기능만을 가지고 구현하고자 했다. 

### 작업 진행도

- 전체 구조 생성 (project, app, db)
- User 관계없이 게시판 CRUD 구성
- User singup(회원가입) 기능 구현
- User login/logout 기능 구현
- User 정보 update 및 password 변경 구현

### 구글 검색한 부분

- 프로젝트 생성 명령어

  ```bash
  $ django-admin startproject <pjt name> .
  ```

- 모델 생성

  ```python
  class Community(models.Model):
      title = models.CharField(max_length=100)
      content = models.TextField()
      
      def __str__(self):
          return self.title
  ```

- Admin 등록

  ```python
  from django.contrib import admin
  from .models import Community
  
  admin.site.register(Community)
  ```

- User Model은 커스텀 할때만 건들이고, 내장 model과 form을 사용한다.

- Decorator

  ```python
  from django.views.decorators.http import require_safe
  from django.shortcuts import render, get_object_or_404
  ```

- 회원 확인

  ```python
  # 데코레이터로 확인
  from django.contrib.auth.decorators import login_required
  # 변수로 확인
  if request.user.is_authenticated:
      pass
  # html에서 확인
  {% if request.user.is_authenticated %}
  ```

- login form

  ```python
  #POST
  form = AuthenticationForm(request, request.POST)
  user = form.get_user()
  auth_login(request, user)
  #GET
  form = AuthenticationForm()
  ```

- signup form

  ```python
  #POST
  form = UserCreationForm(request.POST)
  user = form.save()
  auth_login(request, user)
  #GET
  form = UserCreationForm()
  ```

- update form

  ```python
  #POST
  form = UserChangeForm(request.POST, instance=request.user)
  #GET
  form = UserChangeForm(instance=request.user)
  ```

- chage_password

  ```python
  #POST
  form = PasswordChangeForm(request.user, instance=request.POST)
  update_session_auth_hash(request, form.user)
  #GET
  form = PasswordChangeForm(request.user)
  ```

- logout

  ```python
  auth_logout(request)
  ```

- delete

  ```python
  request.user.delete()
  auth_logout(request)
  ```



## 생각

User 부분은 확실히 어렵다. 아직은 수준이 낮은건지 모르지만 form이 통일성이 없이 인자를 받는것 처럼 느껴진다. 이렇게 설계한 이유가 있을텐데, 그러한 이유를 공부해야겠다.

framework를 사용하며 제작자는 왜 이렇게 설계했을지 고민이 많이 된다. 인자 순서 하나까지도 쉽게 설계되지 않고, 규칙을 만들었을 것이다. 이러한 규칙들이 습관화 되어야 내가 개발을 하고, 누군가 그것을 이해하고 하는데 유익할 것 같다. 조금더 깊이 framework를 공부하고 싶다.