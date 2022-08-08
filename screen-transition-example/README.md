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

### 2. viewController Life Cycle
1. 들어가기에 앞서..
    - 이 메서드들은 각자 자신들이 불러져야하는 타이밍일 때, iOS의 시스템에 의해 자동으로 호출됨
    - UIViewController의 하위 클래스 생성시, UIViewController에 정의된 이 메서드들을 override(상속)하여, lifeCycle의 상황에 맞게 적절한 로직들을 추가할 수 있음
    - 시스템이 어떤 메서드를 언제 호출해야하는지를 이해하는 것이 중요 -> 그 시점에 맞춰 UI의 변화, 데이터 변화 처리를 잘 할 수 있다.
    
2. 뷰가 보여지는 상황
    - Appearing: 뷰가 화면에 나타나는 중
    - Appeard: 뷰가 화면에 나타나게 완료된 상태
    - Disappearing:뷰가 화면에서 사라지는 중
    - Disappeared: 뷰가 화면에서 사라진 상태

3. 살펴 볼 메서드들
    - `viewDidLoad()`
        - 뷰 컨트롤러의 모든 뷰들이 메모리에 로드됐을 때 호출
        - 메모리에 처음 로드될 때 한 번만 호출
        - 보통 딱 한번 호출될 행위들을 이 메소드 안에서 정의함
        - ex) 뷰와 관련된 추가적인 초기화 작업, 네트워크 호출
    - `viewWillAppear()`
        - 뷰가 뷰 계층에 추가되고, 화면에 보이기 직전에 매 번 호출
        - 다른 뷰로 이동했다가 돌아오면 재호출
    - `viewDidAppear()`
        - 뷰 컨트롤러의 뷰가 뷰 계층에 추가된 후 호출됨
        - 뷰를 나타낼 때 필요한 추가 작업
        - 애니메이션을 시작하는 작업
    - `viewWillDisappear()`
        - 뷰 컨트롤러의 뷰가 뷰 계층에서 사라지기 전에 호출됨
        - 뷰가 생성된 뒤 작업한 내용을 되돌리는 작업
        - 최종적으로 데이터를 저장하는 작업
    - `viewDidDisappear()`
        - 뷰 컨트롤러의 뷰가 뷰 계층에서 사라진 뒤에 호출
        - 뷰가 사라지는 것과 관련된 추가 작업
    
#

### 3. 화면간 데이터 전달
1. 전환되는 화면의 ViewController 클래스 타입으로 다운캐스팅하여 접근
2. delegate 패턴 사용
    - delegate: 위임자
    - 즉 위임자를 갖고 있는 객체가 다른 객체에게 자신의 일을 위임하는 형태의 디자인패턴
    - 이 패턴을 사용하여 이전화면의 데이터를 전달할 것임

