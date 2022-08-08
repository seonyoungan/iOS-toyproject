//
//  ViewController.swift
//  screen-transition-example
//
//  Created by 안선영 on 2022/08/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tabCodePushButton(_ sender: UIButton) {
        //액션함수 안에서 CodePushViewController가 열리도록 작성함
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController")  else { return }
        //옵셔널로 반환하므로 가드문 처리함
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tabCodePresentButton(_ sender: UIButton) {
        
        //액션함수 안에서 새 화면이 present되도록 함
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") else { return }
        self.present(viewController, animated: true, completion: nil)
    }
}

