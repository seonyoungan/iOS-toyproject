//
//  CodePresentViewController.swift
//  screen-transition-example
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit
protocol SendDataDeligate: AnyObject{
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    weak var delegate: SendDataDeligate? //delegate 패턴 사용시 변수 앞에 weak라는 참조를 붙여야함 (안그러면 강한순한 참조가 걸려 메모리 누수 발생할 수 있음)
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit() 
        }
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Hello.") //dismiss하기 전에 delegate 위임받고.. 이 코드 실행
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

    
}
