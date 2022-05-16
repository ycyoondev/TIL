# Spring MSA - Kibana

ELK로 묶여서 사용되는 데이터 처리 방법에서 시각화를 담당하는 Kibana에 대해 알아본다. 기능 중심적인 오픈소스로 내부 원리보다는 어떻게 사용하는지 무슨 기능을 제공하는지 초점으로 공부한다.

## Kibana란

GUI를 이용해 데이터를 탐색하고 실시간 분석 결과를 그려준다. 화면을 그리는 엔진으로 HTML, CSS, JS 엔진으로 볼 수 있다. Elastic Stack 기반으로 탄생한 오픈 소스 엡이기 때문에 ElasticSearch 설치가 필수적이다.

## 사용 용도

- 로그 분석
- 인프라 메트릭과 컨테이너 모니터링
- 엡 성능 모니터링 (APM)
- 위치 기반 정보 분석 및 시각화
- 보안 분석 및 비즈니스 분석
- 웹 인터페이스를 통하여 Elastic Stack 인스턴스 모니터링

## 주요 기능

### Discover

ElasticSearch에 저장된 데이터를 한눈에 확인 할 수 있으며, 키워드를 조회 데이터를 저장하고 불러올 수 있다. JSON 형태의 데이터 전체를 볼 수 있으며, 특정 조건을 지정하여 볼 수 있다.

### Visualize

ElasticSearch에서 수집된 데이터를 시각화한다. 여러 종류의 차트를 기본적으로 제공하며 X, Y 등 데이터값을 설정할 수 있다.

### DashBoard

Visualize를 이용해 시각화한 자료들을 모아서 하나의 DashBoard에 배치할 수 있다. 한눈에 확인하기 용의하다. 이러한 DashBoard는 url로 배포가 가능하다.

### Setting

Kibana 설정에서 새로운 index를 추가하고 Visualize, DashBoard에서 생성한 데이터를 수정 및 삭제할 수 있다.

