### 🍏 iOS-project30

### 1. todo-list app만들기
#### 1. UITableView
1. 데이터를 목록 형태로 보여주는 기본적인 UI컴포넌트
2. UIScrollView를 상속받음
3. 설정앱, 기본연락처앱이 테이블뷰로 구현됨
4. 특징
    - 여러 개의 셀을 가지고 하나의 열과 여러 줄의 행을 지녀 수직으로만 스크롤 가능
    - 섹션을 이용해 행을 그룹화하여 콘텐츠 쉽게 탐색 가능
    - 섹션의 헤더와 푸터에 뷰를 구성해 추가적인 정보 표시 가능

#### 2. TableView를 사용하려면..
1. UI TableView Delegate Protocol, UI TableView DataSouce을 채택 후 구현해야함
2. DataSouce: 데이터를 받아 뷰를 그려주는 역할
    - 테이블뷰를 생성하고 수정하는 데 필요한 정보를 테이블 뷰 객체에 제공
3. Delegate: 테이블 뷰의 동작과 외관 담당. 뷰가 변경되는 사항을 담당함
    - view 는 Delegate에 의존하여 view를 업데이트한다. 
    - 참고로 필수로 구현해야하는 메서드는 없다. 

### 3. 수업 내용 메모
1. 강한 순환 참조
    - 클로저 선언부에서 캡처 목록을 정의하는 이유: 클래스처럼 클로저는 참조 타입이다.
    - 클로저의 본문에서 셀프로 클래스의 인스턴스를 캡쳐할 때 강한 순환 참조 발생할 수 있음
    - 강한 순환 참조란? aic의 단점이다. 두개의 객체가 상호 참조하는 경우 강한 순환 참조가 만들어져서 연관된 객체들은 레퍼런스 카운트가 0에 도달하지 않아 메모리 누수 발생할 수 있음
    - 해결하는 방법: 이를 방지하기 위해 클로저 선언부에서 캡처 목록을 정의하는 이유 `weak self`
```swift
let registerButton = UIAlertAction(title: "등록", style: .default, handler: {
    [weak self] _ in//...
    //weak self : 캡쳐 목록 정의하는 것
})
```

2. UserDefault
    - 런타임 환경에 동작하면서 앱이 실행 되는 동안 기본 저장소에 접근해 데이터 기록, 가져오는 인터페이스임
    - key-value 쌍으로 저장되고, 싱글턴 패턴으로 설계되어 전체에 단 하나의 인스턴스만 존재하게 됨
    - 여러가지 타입을 저장할 수 있음. primitive type, ns type, ...

#

### 🍎 결과물
<div>
<img width="300" alt="스크린샷 2022-08-04 오전 4 53 19" src="https://user-images.githubusercontent.com/74126735/182697620-56222d64-5067-4fc7-86c5-099516afbce1.png">
<img width="300" alt="스크린샷 2022-08-04 오전 4 53 51" src="https://user-images.githubusercontent.com/74126735/182697628-dd1fb69f-178f-48c0-910f-7dc645ca0359.png">
<img width="300" alt="스크린샷 2022-08-04 오전 4 54 31" src="https://user-images.githubusercontent.com/74126735/182697638-cff7d792-2c1f-4f25-80aa-495dcd49aa19.png">
</div>
