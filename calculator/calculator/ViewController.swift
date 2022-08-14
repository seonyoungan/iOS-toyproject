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
        self.operation(.Divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multyply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation){
        if self.currentOperation != .unknown{
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation{
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Multyply:
                    self.result = "\(firstOperand * secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                default:
                    break
                }
                //피연산자들의 합이 정수로 떨어지면 결과값도 Int로 보이게함
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0{
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result //첫번째 피연산자변수에 현재 결과값 넣어줌
                self.numberOutputLable.text = self.result // 연산된 결과값 표시
            }
            self.currentOperation = operation //누적연산
        } else{
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = "" //빈 문자열로 표시
            
        }
    }
}

