# 프로젝트 ios-wanted-GyroData
## 팀원: 신동원(휘양), 김지인(Julia), 소현수(쏘롱)

## 역할 분담 및 앱에서 기여한 부분
### 휘양 
1. 두번째 화면 구현
2. CMMotionManager 를 이용하여 gyro, acc 데이터 업데이트 구현
3. 그래프 draw를 위한 GraphView, GraphBuffer 기능 구현
4. json 파싱 및 FileManager 를 이용한 save & load 기본 구조 구현

### Julia
`줄리아님이 적을 곳`

### 쏘롱
1. 첫번째 화면 구현
2. CoreData를 이용해 데이터 목록을 테이블 뷰로 구현


## 뷰 구성 정보 및 기능

### 첫번째 화면 - MainViewController

- 화면 구성
  - TableView
    - CoreData에서 데이터를 읽어와 측정 타입, 날짜, 측정 시각을 표시
    - Cell 선택시 세번째 페이지를 View 타입으로 이동
  - UIButton
    - 측정하기 위해 MeasureViewController 의 화면전환
  - SwipeAction
    - Play를 선택하였을때 세번째 페이지를 Play 타입으로 이동
    - Delete를 선택하였을때 데이터를 삭제

### 두번째 화면 - MeasureViewController

- 화면 구성
  - UISegmentControl
    - Acc 와 Gyro 중 어떤 것을 측정 할지 결정하는 용도
  - GraphView
    - 측정 데이터를 이용하여 그래프를 그리는 뷰
  - UIButton
    - 측정, 저장, 정지 기능을 사용하기 위한 버튼
  - Activity Indicator
    - 저장은 비동기적으로 실행되며, 저장시작 시 indicator가 보여지고 저장이 완료되면 hidden 된다
    - 저장이 너무빨라 제대로 표기가 안되지만 저장을 했다는 상호작용의 기능으로 표기가 되어야 한다고 생각했기 때문에, 최소 1초간은 보여주게 하였다

- 측정
  - SegmentControl selectedIndex값 을 이용하여 gyro or acc 여부를 판별한다
  - 측정을 시작할 때 이전 측정 데이터가 있다면 초기화 후 진행한다
  - 측정 시 정지 버튼을 제외하고 disable 시킨다
  - 측정은 1초에 10개의 데이터를 가져오며 timeout 60초가 지나거나 정지 버튼을 누를 시 종료된다
 
- GraphView
  - 기본 y축 range는 max 5, min -5 이고, 초과 시 resetScale 메소드를 이용하여 스케일을 재설정 한다
  - 왼쪽에서 오른쪽으로 순차적으로 그려지며, 화면 최대길이를 초과할 시 그래프를 왼쪽으로 한칸 씩 이동 시킨다
  - 그려질 값은 GraphBuffer에서 관리한다

- 저장
  - 측정 값이 존재 할때만 가능하다
  - 저장 시 json 파일로 파싱 후 FileManager를 이용하여 앱 폴더에 저장한다
 

### 세번째 화면 - ReplayViewController

`줄리아님이 적을 곳`

### 프로젝트 후기 및 고찰
### 휘양
  - 첫 팀 프로젝트 과제
    - 설계 단계부터 팀원과의 의사소통이 중요하다는 걸 느끼게 된 계기
    - 역할 분담을 화면 별로 구성하였다. view를 중심으로 각자 역할이 생겨서 좋았던 것 같은데, 기능별로 구성하였다면 어떨지 궁금하다.
  - 기억나는 이슈
    1. 코드적 에러는 아니지만, info.plist 문제가 생각난다. 앱에서 json으로 저장 후 불러와야 하는 기능이 있었기 때문에 저장이 잘 되었나 확인이 필요했다
    하여 info.plist를 수정하여 아이폰 파일앱으로 확인하였다. 근데 어떤 이유인지는 몰라도 가끔씩 파일앱에서 접근이 불가능했다. xcode오류 같은데 테스트가 안되 답답해서 기억에 남는다
    
    2. 제약사항에 저장 시 indicator를 보여주어야 한다는 내용이 있다. 저장 버튼을 누를 시 indicator를 보여주고 저장이 종료되면 hidden 처리되게 구현 했었다. 근데 예상과 다르게
    저장이 너무 빠른 탓인지 indicator가 보여지기도 전에 hidden 되었다. 그래서 사용자가 저장을 눌러도 제대로 저장이 된건지에 대해 알수가 없다고 판단하여, sleep() 을 이용해 1초간은
    indicator를 보여주고 싶었지만 실패. indicator 애니메이션도 같이 sleep 되는듯 했다. 해결 방법으로 sleep대신 asyncAfter를 이용해 1초를 기다리게 했다. 둘이 명확한 차이점은
    생각해 보지 않았지만, 추후 공부해볼 내용으로 기억에 남는다.
    
  - 아쉬운점
    - view들은 공통적으로 제약사항을 호출하는 메소드가 있으므로 protocol로 정의 하면 좋지 않을까 한다
    - SOLID 원칙을 얼마나 위배 하였는지 확인을 해보지 못했다
    - 아키텍처에 대해 깊게 고민하지 못했다
    - 생각지 못한 미구현 항목
      - 측정 데이터 목록에서 데이터를 삭제 할 시 CoreData에서는 Delete 되지만, 앱 폴더에 저장되어 있는 json파일은 삭제 되지 않아서 더미데이터가 쌓이게 된다
      
### Julia
`줄리아님이 적을 곳`

### 쏘롱
  - 프로젝트 과제 후기
    - 처음으로 팀프로젝트를 하면서 프로젝트를 각자 어떻게 역할분담을 할지부터 서드파티를써야할지 토의를 통해 프로젝트를 만들어가는 과정에서 많은 경험이 되었다.
    - 코드를 짜다가 해결이 안되는 부분이 있을때 혼자 구글링하고 문서를 찾아보면서 혼자 해결하지 못하거나 이해가 가지 않던부분에서 팀원들의과 자료를 더 찾아본다거나 팀원의 조언을 받아 코드를 수정하고 어떻게 작동되는지 이해하게 되거나 하는 부분에서 더 나은 결과를 도출할려고 같이 노력하는 과정이 보람차고 즐거웠다 
    
  - 프로젝트 하면서 아쉬운점
    - 각자 View 중심으로 역할을 맡아서 프로젝트가 진행되다보니 실제 기능구현확인을 하기 위해서는 팀원의 코드들이 필요한데 늦은시간에 연락을 해야할지 고민을 하게 된다는점이 생길수밖에 없었다는게 아쉬웠다.
