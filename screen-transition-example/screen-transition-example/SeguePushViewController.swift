//
//  SeguePushViewController.swift
//  screen-transition-example
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit

class SeguePushViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    //세그웨이로 구현된 화면전환 방법에서 전환되는 화면의 값을 전달하기 위해 좋은 방법: 전처리 prepare method
    //viewController에 가서 override func prepare() 메소드를 구현하자
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SeguePushViewController 뷰가 로드 되었다.")
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SeguePushViewController 뷰가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SeguePushViewController 뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SeguePushViewController 뷰가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SeguePushViewController 뷰가 사라졌다.")
    }

    
    @IBAction func tabBackButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
