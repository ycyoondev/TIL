# 쉘

## 쉘이란?

OS에서 사용하는 용어로 명령어와 프로그램을 실행할때 사용하는 인터페이스이다.

쉘은 커널과 사용자를 연결하는것으로 사용자의 명령을 받아 해석한다.

![img](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/76f1207d-992f-4d8d-a611-c1c0f514c6f8/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220503%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220503T134313Z&X-Amz-Expires=86400&X-Amz-Signature=bc7f8f0f96bbef37525c76a3f4f7e89ed08d2e2149003cb68e55f3d65338e869&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

## 쉘의 기능

- 사용자와 커널사이에 명령을 해석하여 전달하는 기능
- 쉘 내부에서 프로그램을 작성할수 있는 기능. 이러한 작성된 프로그램을 저장한 것이 쉘 스크립트이다.
- 초기화 파일 기능을 이용해 사용자 환경 설정 기능

### 커널이란

![img](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0e1db7cf-3e44-4f74-a083-f9a5cc08dcb1/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220503%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220503T134332Z&X-Amz-Expires=86400&X-Amz-Signature=7e9e7c807d32db9ff546992c0791811de855f1ffa22f560b76a2cc88336769b3&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

커널은 컴퓨터 운영체제의 핵심이 되는 프로그램이다. OS 자체로 생각해도 좋다. 크게 보안, 자원관리, 추상화 역할을 한다.

더 자세히 생각해보자. 프로그램이 동작하려면 메모리에 올라가야 한다. OS 자체도 프로그램으로 작동을 위해서는 메모리에 올라가야 한다. 하지만, OS 전체가 모두 메모리에 올라간다면 메모리 공간 낭비가 심할 것이다. 따라서 OS 중에서 핵심적으로 올라가야 하는 부분만 전원이 켜졌을때 메모리에 올라가게 된다. 다른 부분은 필요할때 올라갔다가 다시 내려가게 된다. 이렇게 메모리에 상주하는 OS 부분을 커널이라고 한다. 넓은 의미로 OS 자체를 커널이라고 하기도 한다.

## 쉘 종류와 특징

쉘의 특성상 운영 체제 마다 다르고, 프로그램 별로 쉘을 제공할 수 있는 등 다양한 쉘이 개발되고 있다. 대표적으로 몇가지를 알아보자.

### Bourne Shell - sh

유닉스에 오리지널 쉘이다. 모든 유닉스 시스템에서 사용 가능하다는 특징이 있으나 오리지널이다 보니 기능이 적다는 한계가 있다. 최근에는 더 고기능 쉘이 제공되어 잘 사용하지 않는다.

### bash

리눅스 표준 쉘이다. 우분투와 페도라에서 기본으로 사용하며 맥에서도 볼 수 있다. 무료로 제공되어 빠르게 확산되었다.

### C Shell - csh

Bourne Shell의 사용성을 높이기 위해 개발 되었다. C언어를 기반으로 만들어진 쉘이다.
