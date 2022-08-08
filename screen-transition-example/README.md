### 🍏 iOS-project30

### 1. screen-transition-example
1. 이론 메모
    - Content View Controller
        - 화면을 구성하는 View를 직접 구현하고 관련된 이벤트를 처리하는 View Controller
        - 하나 이상의 Child View Controller를 가지고 있다.
        - 하나 이상의 Child View Controller를 관리하고 레이아웃과 화면 전환을 담당함
        - 화면 구성과 이벤트 관리를 Child View Controller에서 한다.

    - Container View Controller
        - 대표적으로 Navigation Controller, TabBar Controller가 있다.
        - Navigation Controller: 계층구조로 구성된 콘텐츠를 순차적으로 보여주는 컨테이너 뷰 컨트롤러(ex-아이폰 설정앱)
        - 네비게이션 스택이라는 정렬된 배열을 사용해 자식 뷰 컨트롤러 관리함 -> 배열의 첫번ㅂ째뷰 컨트롤러는 루트뷰컨트롤러이고 스택의 가장 밑에 있음
        - 배열의 마지막 컨트롤러: 스택의 최상단(현재 화면에 보여지는 것 )

2. 화면 전환 4가지 방법
    - ViewController의 View를 바꾸기
        - 메모리 누수 위험이 있어 권장하지 않는 방법
    - NavigationController를 이용하여 화면전환하기(push)
        - 전환될 화면의 class를 SeguePushViewController와 연결한 후 해당 버튼을 show로 연결
    - 현재 ViewController에서 다른 ViewController를 호출하는 화면전환(present)
        - 전환될 화면의 class를 SeguePreseuntViewController와 연결한 후 해당 버튼을 present modally로 연결
        - 새로운 컨트롤러가 기존 화면 위로 덮여지게 됨
        - 모달창 형태: SeguePreseuntViewController의 속성의 presentation을 automatic으로 지정
        - 전체창 형태: SeguePreseuntViewController의 속성의 presentation을 Full Screen으로 지정
    - 화면전환용 객체 Segue를 이용하여 화면전환하기(push, present)
        


#
