//
//  ViewController.swift
//  screen-transition-example
//
//  Created by 안선영 on 2022/08/05.
//

import UIKit


class ViewController: UIViewController, SendDataDeligate {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController 뷰가 로드 되었다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController 뷰가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController 뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController 뷰가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라졌다.")
    }

    @IBAction func tabCodePushButton(_ sender: UIButton) {
        //액션함수 안에서 CodePushViewController가 열리도록 작성함
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController  else { return }
        //옵셔널로 반환하므로 가드문 처리함
        //전환되는 화면의 ViewController클래스(CodePushViewController) 타입으로 다운캐스팅함
        viewController.name = "Hello."
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tabCodePresentButton(_ sender: UIButton) {
        
        //액션함수 안에서 새 화면이 present되도록 함

        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else { return }
        //전환되는 화면의 ViewController클래스(CodePresentViewController) 타입으로 다운캐스팅함
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "Hello."
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController{
        // 이 프로퍼티를 이용하여 전환하려는 인스턴스의 값을 가져올 수 있음. (다운캐스팅까지 해주자)
        viewController.name = "Hello?"
        }
    }
    
    func sendData(name:String){
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

