//
//  ViewController.swift
//  calculator
//
//  Created by 안선영 on 2022/08/14.
//

import UIKit

enum Operation{
    case Add
    case Subtract
    case Divide
    case Multyply
    case unknown
}
class ViewController: UIViewController {

    var displayNumber = "" //계산기 버튼을 누를 때마다 numberOutputLable에 표시되는 문자를 가짐
    var firstOperand = "" //첫번째 피연산자
    var secondOperand = "" //두번째 피연산자
    var result = ""
    var currentOperation: Operation = .unknown //현재 계산기에 어떤 연산자가 입력되었는지 알 수 있게 연산자의 값을 저장함
    
    
    
    @IBOutlet weak var numberOutputLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
   }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLable.text = self.displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLable.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        //소수점포함 아홉자리가 되도록 예외처리함
        if self.displayNumber.count < 8, !self.displayNumber.contains("."){
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLable.text = self.displayNumber
        }
    }
    
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
}

