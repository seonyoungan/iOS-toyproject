//
//  ViewController.swift
//  todo-list
//
//  Created by 안선영 on 2022/08/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editbutton: UIBarButtonItem!
    var doneButton: UIBarButtonItem?
    var tasks = [Task](){
        //프로퍼티 옵저버 만들기
        didSet{
            self.saveTasks()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTab))
        //tasks에 저장된 할일들을 테이블뷰에 표시하는 코드
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTasks() //저장된 할일들 불러오기
        
    }

    @objc func doneButtonTab(){
        //doneBotton -> editBotton으로 바뀌게 하기
        self.navigationItem.leftBarButtonItem = self.editbutton
        self.tableView.setEditing(false, animated: false)
    }
    
    
    @IBAction func tabEditButton(_ sender: UIBarButtonItem) {
        //tableView가 비어있지 않을 때만 버튼 바뀌면됨(방어코드)
        guard !self.tasks.isEmpty else { return }
        //editBotton -> doneBotton으로 바뀌게하기
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func tabAddButton(_ sender: UIBarButtonItem) {
        
        // Add버튼을 누르면 등록을 위한 alert 표시
        /*alert: 할일을 등록하는 alert구현
        iOS alert: 앱 또는 기계의 상태와 중요 정보, 피드백 요청을 위해 사용됨
        제목, 메세지, 하나이상의 버튼 및 입력을 수집하기 위한 테스트 필들로 구성됨 */
        let alert = UIAlertController(title: "할 일 등록", message: "할 일을 입력해주세요.", preferredStyle: .alert)
        //preferredStyle는 action-sheet와 alert가 있음.
        
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: {
            [weak self] _ in
            //등록버튼을 누를때마다 추가해줘야하니까 핸들러 파라미터에 클로저를 정의한 것
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData() //tasks배열의 할일들이 추가되면 tableview를 갱신해서 테이블뷰에 추가될 할일들이 표시되게 함
        })
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancleButton)
        alert.addAction(registerButton)
        alert.addTextField {
            textField in
            textField.placeholder = "할 일을 입력해주세요."
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //userDefaults에 할 일 저장하기
    func saveTasks(){
        //할일을 userDefault에 딕셔너리 형태로 저장
        let data = self.tasks.map{
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "tasks")
    }
    
    //userDefaults에 저장된 할일을 로드하기
    func loadTasks(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        self.tasks = data.compactMap({
            guard let title = $0["title"] as? String else { return nil } //다운캐스팅
            guard let done = $0["done"] as? Bool  else { return nil } //다운캐스팅
            return Task(title: title, done: done)
        })
    }
    
}

//UI TableViewDataSource를 채택하면 꼭 구현 해야 하는 메서드 numberOfSections,cellForRowAt
extension ViewController: UITableViewDataSource{
    //각 섹션에 표시할 행의 갯수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //하나의 세션에 할일들을 표시할 것(배열의 갯수가 반환됨)

        return self.tasks.count
    }
    
    
    //특정 섹션의 n번째 row를 반환하는 메서드(특정 row를 그리기 위해 필요한 셀을 반환해야 함)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //할일 목록이 표시가 되게 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //dequeueReusableCell 역할: 지정된 재사용 식별자에 대한 재사용 가능한 테이블뷰 셀 객체를 반환하고 이를 테이블뷰에 추가하는 기능
    
        //할일 표시
        let task = self.tasks[indexPath.row] //배열에 저장된 할일 요소값 가져오기
        cell.textLabel?.text = task.title
        
        //완료했으면 checkmark 아니면 아무 표시하지 않기
        if task.done{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
        
    }
    
    //편집모드에서 삭제버튼 누르면, 눌러진 셀이 어떤 셀인지 알려주는 메서드. 스와이프로 삭제할 수도 있음
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        //모든 할일들이 삭제되면 편집모드 빠져나오게 하기
        if self.tasks.isEmpty{
            self.doneButtonTab()
        }
    }
    
    //할일의 순서 변경하는 메서드
    //행이 다른위치로 이동하면 sourceIndexPath의 파라미터를 통해 원래 있었던 위치를 알려주고 destinationIndexPath를 통해 어디로 이동했는지 알려줌!
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks //배열 가져옴
        let task = tasks[sourceIndexPath.row] //배열의 요소에 접근
        tasks.remove(at: sourceIndexPath.row) //sourceIndexPath를 넘겨줘서 원래 위치한 할일 삭제
        tasks.insert(task, at: destinationIndexPath.row) //배열에 요소에 접근한 할일을 넘겨주고 destinationIndexPath.row로 이동한 위치 넘겨줌
        self.tasks = tasks //재정렬된 tasks 배열을 넘겨줌
    }
}


extension ViewController: UITableViewDelegate{
    
    // 셀을 선택하면 어떤 셀이 선택됐는지 알려주는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //done이 false이면 true, true이면 false가 되도록 변경
        var task = self.tasks[indexPath.row]
        task.done = !task.done //반대가되도록
        self.tasks[indexPath.row] = task //변경된 요소를 원래 요소에 덮어 씌우기
        self.tableView.reloadRows(at: [indexPath], with: .automatic) //reloadRows 메소드를 호출해서 선택된 셀만 리로드함
        
    }
}
