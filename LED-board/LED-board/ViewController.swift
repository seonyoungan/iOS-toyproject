//
//  ViewController.swift
//  LED-board
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }


}

