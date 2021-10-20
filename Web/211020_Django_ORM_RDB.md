# 211020 TIL

> 1:N, M:N 모델을 다루기 위한 Django ORM 공부.
>
> 모델구성과 ORM을 장고 공식문서에서 추천하는 표현법으로 공부합니다.



## 외래키

RDBMS에서 다른 테이블의 행을 식별하기 위한 키.

다른 테이블(참조하고 싶은)의 기본키를 가리킨다.



## 1:N

### Model

> 코드의 논리만 맞으면 대소문자 등 표현 형식에 상관없이 코드는 정상 수행된다. 하지만 스스로 습관을 만들기 위해 공식문서와 통용적으로 사용되는 방법을 기준으로 작성하겠다. 

```python
# app/models.py

class Table(models.Model):
    col1 = models.CharField(max_length=50) # 아무 컬럼
    othertable = models.ForeignKey(Othertable, on_delete=models.CASCADE) # 외래키(FK)
```

- 테이블(모델)명은 대문자로 시작한다. 
- 참조하는 테이블을 소문자 단수형으로 명명하고, `models.ForeignKey`를 이용한다.
  - 참조할 모델이 User 이면 `settings.AUTH_USER_MODEL`을 이용한다. (모델 선언 순서 때문)
- models.ForeignKey는 모델과 on_delete를 필수인자로 받는다.
  - CASCADE: 부모(1)에서 삭제하면 자식(N)도 같이 삭제한다.
  - PROTECT: 자식(N)이 있으면 부모(1)삭제가 불가능하다.
  - SET_NULL: `null=True`를 같이 넣어줘야 하며, 부모(1)가 사라지면 자식(N)의 FK가 Null값이 된다.
  - SET_DEFAULT: `default=`를 같이 넣어줘야 하며, 부모(1)가 사라지면 자식(N)의 FK가 디폴트값이 된다.
  - SET(함수): 부모(1)가 사라지면 함수를 통해 FK를 지정한다 
  - DO_NOTHING: 부모(1)가 삭제되도 자식(N) 테이블에는 변화가 없다. (참조 무결성 위험)



### ORM

#### 참조 (N -> 1)

```python
# Comment(N) -> Article(1) 
comment.article
```

- ORM은 객체 지향하여 쿼리를 다룬다는 부분을 기억하자.
- DB를 보면 id값이 저장되나 보통은 객체를 사용하여 접근하고 저장한다.

#### 역참조 (1 -> N)

```python
# Article(1) -> Comment(N)
article.comment_set.all() # 모든 참조하는 행을 불러온다. list처럼 사용할 수 있다.
```



### Django 프로젝트 적용

> 예시를 위해 게시판을 생각하자. 게시글(1)과 덧글(N)간의 RDB를 구현한다.

#### admin

```python
# app/admin.py
# 새롭게 만든 테이블도 admin에 등록해야 합니다.

from .models import Table

admin.site.reqister(Table)
```

#### 외래키가 있는 ModelForm

> 외래키를 사용하는 모델은 외래키를 직접 form에서 받는것이 아니라, 서버에서 처리하는 경우가 많이 있습니다. 따라서 form 출력을 제외하는것을 알아봅니다.

```python
# app/forms.py
# Comment 모델을 사용했다고 합니다. 여기서 article(본 게시글)을 제외하고 서버에서 넣어줍니다.

class CommentForm(forms.ModelForm):
    
    class Meta:
        model = Comment
        exclude = ('article',)
```

#### form으로 데이터 불러와서 필수 인자(NOT NULL) 넣기

```python
# 예를들어, 게시글(article)에 덧글(comment)을 단다고 하면

@require_POST
def comments_create(request, article_pk):
    article = get_object_or_404(Article, pk=article_pk) # 참조할 객체 (1 테이블)
    comment_form = CommentForm(request.POST) # 필수 데이터가 없는 상태로 입력 들어온다.
    if comment_form.is_valid():
        comment = comment_form.save(commit=False) # 객체는 만드나 DB 커밋은 안한다
        comment.article = article # 필수 객체를 넣는다
        comment.save() # 커밋한다
    return redirect('articles:detail', article.pk)
```

- DB 수정이므로 POST 요청만 허용한다. 유저 인증을 요구할 수 있고, html에서 로그인되지 않으면 덧글 작성창이 보이지 않게 만들 수 있다. 여기선 필수 인자들만 넣는다.

#### 모든 덧글 보기 (역참조)

```python
# 출력하고자하는 views 함수 내부에 추가

article = get_object_or_404(Article, pk=article_pk) # article_pk는 url에서 받아오자
comments = article.comment_set.all() # context에 넣어 html로 보내자
```

- html에서는 for문을 통해 사용가능하다.



### 옵션

아무것도 없는 빈 쿼리셋이 들어왔을경우

```django
{% for comment in comments %}
  {{ comment }}
{% empty %}
  <p>아무것도 없어요</p>
{% endfor %}
```



