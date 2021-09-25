# 210925 TIL

## Web Framework: Django 

> Django를 이용하여 사용자 기반 게시판 CRUD를 구현한다. 
>
> 기본적인 기능은 암기로 구현하고 싶어, 최대한 참고 없이 VS code의 자동완성 기능만을 가지고 구현하고자 했다. 

### 작업 진행도

- 전체 구조 생성 (project, app, db)
- User 관계없이 게시판 CRUD 구성
- User singup(회원가입) 기능 구현

### 남은 작업

- User login, logout 구현
- Decorator 이용한 보안 강화
- 상황별 알맞은 에러 코드 송출

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

  

## 생각

아직 완전하게 기본을 안보고 구현할 수 없다. 하지만 반복적으로 할수록 기억에 남는 부분이 많을것이고, 나중에 다른 frame을 쓰거나 오랜 시간 후에 사용할 때 도움이 될것이라 생각한다. 

모르는 기능을 찾아보면서 검색 과정에서 부가적으로 알게되는 지식들이 유익하다. 꾸준히 새로운 기능 구현을 위해 이런식으로 공부하는것이 아직은 즐겁다.