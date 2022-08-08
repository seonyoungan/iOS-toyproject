//
//  SettingViewController.swift
//  LED-board
//
//  Created by 안선영 on 2022/08/09.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject{
    func changedSetting(text: String?, textColor: UIColor, backgroudColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var delegate: LEDBoardSettingDelegate?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    var ledText: String? //저장값 유지하기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //저장값 유지하기
    private func configureView(){
        if let ledText = self.ledText{
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColor(color: self.backgroundColor)
    }
    
    //어떤 색상이 선택되었는지는 sender 파라미터를 통해 알 수 있다.
    @IBAction func tapTextColorButton(_ sender: UIButton){
        
        //우선 어떤 버튼이 선택되었는지 알아야함
        //센더와 버튼 아울렛을 비교
        if sender == self.yellowButton{
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        } else if sender == self.purpleButton{
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        } else if sender == self.greenButton{
            self.changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton){
        if sender == self.blackButton{
            self.changeBackgroundColor(color: .black)
            self.backgroundColor = .black
        } else if sender == self.blueButton{
            self.changeBackgroundColor(color: .blue)
            self.backgroundColor = .blue
        } else if sender == self.orangeButton{
            self.changeBackgroundColor(color: .orange)
            self.backgroundColor = .orange
        }
    }
    
    //저장버튼
    @IBAction func tapSaveButton(_ sender: UIButton){
        self.delegate?.changedSetting(
            text: self.textField.text,
            textColor: self.textColor,
            backgroudColor: self.backgroundColor
        )
        //이동하게되면 담긴 정보를 가지고 가도록..
        self.navigationController?.popViewController(animated: true)
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
