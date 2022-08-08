//
//  CodePushViewController.swift
//  screen-transition-example
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit

class CodePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
