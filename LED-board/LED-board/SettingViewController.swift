//
//  SettingViewController.swift
//  LED-board
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //어떤 색상이 선택되었는지는 sender 파라미터를 통해 알 수 있다.
    @IBAction func tapTextColorButton(_ sender: UIButton){
        
        //우선 어떤 버튼이 선택되었는지 알아야함
        //센더와 버튼 아울렛을 비교
        if sender == self.yellowButton{
            self.changeTextColor(color: .yellow)
        } else if sender == self.purpleButton{
            self.changeTextColor(color: .purple)
        } else if sender == self.greenButton{
            self.changeTextColor(color: .green)
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton){
        if sender == self.blackButton{
            self.changeBackgroundColor(color: .black)
        } else if sender == self.blueButton{
            self.changeBackgroundColor(color: .blue)
        } else if sender == self.orangeButton{
            self.changeBackgroundColor(color: .orange)
        }
    }
    
    //텍스트색
    private func changeTextColor(color: UIColor){
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.4
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.4
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.4
    }
    
    //배경색
    private func changeBackgroundColor(color: UIColor){
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.4
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.4
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.4
    }
    
}
