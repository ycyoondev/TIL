# 211016 TIL

## JSON Field를 이용하기 위한 노력

공식문서를 살피고, 인터넷에 참고된 여러 문서와 코드들을 본다.

### 공식문서

> https://docs.djangoproject.com/en/3.2/ref/forms/fields/

```
JSONField¶
class JSONField(encoder=None, decoder=None, **kwargs)¶
New in Django 3.1.
A field which accepts JSON encoded data for a JSONField.

Default widget: Textarea
Empty value: None
Normalizes to: A Python representation of the JSON value (usually as a dict, list, or None), depending on JSONField.decoder.
Validates that the given value is a valid JSON.
Error message keys: required, invalid
Takes two optional arguments:

encoder¶
A json.JSONEncoder subclass to serialize data types not supported by the standard JSON serializer (e.g. datetime.datetime or UUID). For example, you can use the DjangoJSONEncoder class.

Defaults to json.JSONEncoder.

decoder¶
A json.JSONDecoder subclass to deserialize the input. Your deserialization may need to account for the fact that you can’t be certain of the input type. For example, you run the risk of returning a datetime that was actually a string that just happened to be in the same format chosen for datetimes.

The decoder can be used to validate the input. If json.JSONDecodeError is raised during the deserialization, a ValidationError will be raised.

Defaults to json.JSONDecoder.

Note

If you use a ModelForm, the encoder and decoder from JSONField will be used.

User friendly forms

JSONField is not particularly user friendly in most cases. However, it is a useful way to format data from a client-side widget for submission to the server.
```

요약하면 인코더와 디코더가 필요하며 유저 친화적이지 않다는 내용.

예시 코드나 방법이 나와있지 않음



### 다른 인터넷 문서1

> https://www.tutorialspoint.com/adding-json-field-in-django-models

대부분 문서가 django-json을 import해서 쓰는 방식임. 이는 모델변경이 필요해서 우선 참고하지 않음



### 다른 인터넷 문서2

> https://runebook.dev/ko/docs/django/topics/db/queries#querying-jsonfield

이걸 참고해서 Django shell로 하는걸로 결정한다. 결과는 성공적이었다.



## 결론

### DB에 json 저장

#### Django Shell

```bash
# 실행
$ python manage.py shell_plus
# 탈출
In []: exit()
```

```python
# 이렇게 만들면 됩니다.
In [11]: nur1 = User.objects.get(pk=1)

In [12]: Nurse.objects.create(user=nur1, choices={1:True})
Out[12]: <Nurse: Nurse object (1)>

# 같은 방식으로 아래와같이 만들수 있습니다.
In [5]: Nurse.objects.create(user=nur2, choices={
   ...: '10월': {
   ...: 1:True,
   ...: 2:False,
   ...: 3:True,
   ...: 4:False,
   ...: 5:False,}
   ...: })
Out[5]: <Nurse: Nurse object (2)>
```



### 함수 설명





## 참고자료

### Django shell 

> Django-extensions 라이브러리를 추가로 사용한다.

```bash
$ pip install ipython
$ pip install django-extensions
```

```python
# settings.py
INSTALLED_APPS = [
    ...,
    'django_extensions',
    ...,
]
```

```bash
# 실행
$ python manage.py shell_plus

# 탈출
In []: exit()
```



##### Create (내용 추가)

```python
# 1번 방법
In [1]: article = Article() # 객체 생성
In [3]: article.title = 'first' # 제목
In [4]: article.content = 'hello django' # 내용
In [6]: article.save() # 저장

In [7]: Article.objects.all() # 생성 확인
In [8]: article.content # 내용 확인
In [10]: article.pk # 번호 확인
    
# 2번 방법
In [11]: article = Article(title='second', content='my djang')
In [13]: article.save()
    
# 3번 방법
In [16]: Article.objects.create(title='third', content='your django')

```



##### Read (읽기)

```python
# 1번 방법
In [1]: Article.objects.all()
    
# 2번 방법 (하나가 아니면 에러 발생)
In [3]: Article.objects.get(pk=1) # 괄호에 조건 넣기, 보통 pk

# 3번 방법 (객체를 포함하는 새 QuarySet 반환) - 없으면 빈 quaryset
In [5]: Article.objects.filter(content='django')
```



##### Update (수정)

```python
# 수정 대상 지정
In [6]: article = Article.objects.get(pk=1)

# 수정
In [8]: article.title = 'update first'

# 저장
In [9]: article.save()
```



##### Delete (삭제)

```python
# 삭제 대상 지정
In [11]: article = Article.objects.get(pk=1)

# 삭제 (자동 저장됨)
In [13]: article.delete() # 삭제되며 값을 반환 (pop)
```

> 삭제되면 pk 가 사라지며, pk가 재사용되지 않는다.



