# 포트폴리오
https://worried-click-7d5.notion.site/d3e8a5e6c0624458a70301f681cc384b

- [목차](#-------------ver10)
  * [🗒 앱설명 및 개요](#앱-설명-및-개요)
  * [🚀 트러블슈팅](#트러블슈팅)
  * [🤔 고민한부분](#고민한-부분)
  * [🗓 기능공수산정](#기능공수산정)
    + [이터레이션 1](#이터레이션-1)
    + [이터레이션 2](#이터레이션-2)
    + [이터레이션 3](#이터레이션-3)
    + [이터레이션 4](#이터레이션-4)
  * [👩‍👩‍👧‍👦팀빌딩](#팀빌딩)
    + [1주차 토론내용](#1주차-토론-내용)
    + [2주차 토론내용](#2주차-토론-내용)
    + [3주차 토론내용](#3주차-토론-내용)
    + [4주차 토론내용](#4주차-토론-내용)
    + [5주차 토론내용](#5주차-토론-내용)

## 앱 설명 및 개요

- 기획한 이유?
  - 커플들이 이별하는 것을 백신처럼 예방하자는 취지로, 상대방과 좋은 추억들이나 현재상태에 대해서 다시 생각해볼 수 있도록 도움을 주는 서비스
- 주요 기능
  - 버킷리스트 - 사용자는 연애 관련 버킷리스트를 추가하고 체크표시를 할 수 있습니다.
  - 연애테스트 - 사용자는 원하는 항목을 선택하고 연애관련 테스트를 진행할 수 있습니다.
  - 추억 간직하기 - 사용자는 상대방과 함께한 추억들에 관해 일기처럼 작성할 수 있습니다.
  - 연애 명언 - 사용자는 연애관련 명언들을 확인할 수 있습니다.
  - 느린우체통 - 추후 서버구현 후 추가예정
- Git 규칙
  - main브런치는 프로젝트 배포 시점에 메인으로 머지
  - 각각의 버전별 개발은 ver[버전]-test 브런치에서 진행 후 테스트가 통과하거나 이슈문제가 없다면 ver[버전]으로 머지하는 방식으로 개발
  - 커밋은 issue단위로 나누어 확인하기
    - 커밋메시지는 깃모지와 커밋 종류를 사용하여 작성
- 요구사항
  - 아이폰용 앱
  - 최소 타겟 iOS 13.0이상 지원
  - 기본으로는 스토리보드로 UI구현 (필요한 경우 코드로 UI추가)
- 사용 라이브러리
  - SideMenu
- 오픈API
- 기술스택
  - UICollectionView
  - UITextView
  - 네트워크 통신
  - DataBase - Realm
  - H.I.G
  - SFSymbol

<br><br>

## 트러블슈팅

1. 네비게이션바에서 UIBarButtonItem을 SFSymbol이미지로 넣었을 때 네비게이션바 틴트색상을 변경해도 색상이변경되지 않는 문제

   → image로 넣었을 때는 네비게이션바 위에 이미지로 올라갔기 때문에 UIBarButtonItem의 틴트색상을 직접 변경해서 해결

   ```swift
   UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonItem.SystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
   
   let menuButton = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
   menuButton.tintColor = .customPink
   ```

<br><br>

## 고민한 부분

1. 처음 온보딩페이지를 UIPageViewController를 사용하는 것과 UICollectionView를 사용하는 것의 장단점이 무엇일까?
   <img width="200" alt="스크린샷 2021-11-17 오전 11 37 52" src="https://user-images.githubusercontent.com/55218398/143671016-ff203275-0149-474a-ae7a-b0feca39a98b.png">
2. 연애 관련 명언들을 나타내는 API가 없어서 직접 JSON을 작성한 후 사용하려는 경우 어떤 방법이 적절할지?

   - ObjectMapper라이브러리 및 직접 JSON형식 만들기
   - 서버DB올려서 사용하기 - 서버나 파이어베이스를 사용해야하지만 추가 수정에 용이할 것 같다.
   - DataAsset에 추가해서 사용하기 - 추가 수정이 많은 경우에는 불편할 수 있지만 깔끔하게 사용가능 한 것 같다.

3. 사이드메뉴 라이브러리를 사용하는 경우 모달뷰 방식 및 네비게이션방식 중 어느 방식으로 화면전환을 해야하는 지?

   - 모달뷰는 화면위에 계속 겹치기 때문에 네비게이션방식이 더 적절한 것 같지만 네비게이션방식도 화면간의 연관성이 없는 것이 적절하지는 않은 것 같다.

<br><br>

## 기능공수산정

### 이터레이션 1

<11.15(월) ~ 11.17(수)>

- 프로젝트 기획하기
- 화면 UI 스케치
- 애플 개발자 계정등록
- UML 작성
- 개발 규칙 작성
- 서버 DB 스키마 설계

<br><br>

### 이터레이션 2

<11.18(목) ~ 11.21(일)>

- 서버 원격 올리기
- Restful-API 문서 작성하기
- 서버 DB 구현

<br><br>

### 이터레이션 3

<11.22(월) ~ 11.28(일)>

- 기획 수정 (느린 우체통 → 이별 백신)
- 화면 UI 구현 - 오토레이아웃 설정
- 버킷리스트 기능구현
- 연애테스트 기능구현
- 명언 기능구현
- 추억 간직하기 기능구현

<br><br>

### 이터레이션 4

<11.29(월) ~ 12.5(일)>

- 코드 리팩토링
- MVVM 적용
- UnitTest 작성
- 에러 처리
- 앱 출시
- 리젝 대응하기

<br><br>

## 팀빌딩

- 개인프로젝트를 진행하면서 팀원들간의 서로 개발하면서 의문점이나 정보들을 공유하는 방식으로 진행했습니다.
- 팀원 : 배경원, 이성용, 양지영, 권오현, 김성연

<br><br>

### 1주차 토론 내용

<11.15(월) ~ 11.21(일)>

1. 카카오톡모바일에서 사진전송할 때 사진목록 보여주는 방식 - PhotoKit과 관련있지 않을까? 컬렉션뷰로 보여주는 건가?
2. MVVM-C란?
   - Coordinators는 뷰 컨트롤러 계층을 관리하는 것이 중요한 개념이므로 ios에서 유용한 패턴입니다. Coordinators는 본질적으로 MVVM에 속하지 않으며 MVC또는 다른 패턴에도 사용할 수 있습니다.
   - Coordinator 의 가장 중요한 역할은 viewcontroller에서 프리젠테이션 로직을 가져가는 것
   - ViewController 는 뷰모델과 UI바인딩 UI액션을 처리하는 일부 기능이외에는 다른 책임을 가지지 않는 상태가 될수 있다.
   - 참고링크
     - https://junhyi-park.medium.com/mvvm-c-학습자료-정리-7f169f3e376a
     - https://eunjin3786.tistory.com/72
3. 화면 설치시 튜토리얼 관련 페이지 - 온보딩
4. 유용한 라이브러리 목록
   - toast, IQKeyboardManager, SideMenu, Almofire
5. 앱스토어 최적화(ASO) 전략 - 앱스토어 검색 잘 뜰 수 있게 최적화하는 방법
6. UI스케치 관련 Tip : 앱 디자인을 시작할 때 로고를 작성하고 로고에 지정한 컬러색상을 기준으로 앱의 전반적인 이미지를 작성하면 편리하다 - 권오현님

<br><br>

### 2주차 토론 내용

<11.22(월) ~ 11.28(일)>

1. 서버 관련 피드백
   - 실제 서비스를 하는 경우, 개인정보를 직접 받아야한다면 비밀번호 단방향 인코딩, 비번 찾기, 변경 등이 적용되야 하고 보안사고가 생겼을 때 최소한의 가이드에 맞춰 적용되지 않으면 형사처벌이 될 수 있습니다.
     - 비밀번호 단방향 암호화는 해당 서버 프레임워크에서 제공하거나 인증 관련 라이브러리를 사용
   - 개인 개발자 추천 - aws freetier 무료서비스나 파이어베이스 추천
2. 시뮬레이터기기에서 움직임 설정하기
3. 데이터 비교하는 방식 편리하게 사용하기 - Comparable프로토콜, Equatable
