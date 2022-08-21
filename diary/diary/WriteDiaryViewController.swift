//
//  WriteDiaryViewController.swift
//  diary
//
//  Created by 안선영 on 2022/08/19.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject{
    func didSelectReigster(diary: Diary)
}
class WriteDiaryViewController: UIViewController {
    
    @IBOutlet weak var titleTextFeild: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
 
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePiker()
        self.configureInputField()
        
        self.confirmButton.isEnabled = false //등록버튼 비활성화
    }
    
    //등록버튼?
    private func configureInputField(){
        self.contentsTextView.delegate = self
        self.titleTextFeild.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    //델리게이트를 통해 작성된 다이어리 전달될 준비 완료 -> 뷰컨트롤러에서 받을 준비 해야함
    @IBAction func tabComfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextFeild.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.delegate?.didSelectReigster(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }

    
    //내용작성부분(TextView)에 테두리 만들기
    private func configureContentsTextView(){
        let borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor // 레이어 관련 컬러는 UIColor가 아닌 cgColor로 설정
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }

    //날짜 선택 함수
    private func configureDatePiker(){
        self.datePicker.datePickerMode = .date //날짜만
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    //날짜와 텍스트를 변환
    @objc private func datePickerValueChange(_ datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)//날짜가 변경될 때마다 editingChanged 액션을 발생 -> dateTextFieldDidChange가 호출되게 됨
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    //제목텍스트에 입력될 때마다 호출되는 메서드 정의
    @objc private func titleTextFieldDidChange(_ textFeild: UITextField){
        self.validateInputField()
    }
    
    //빈 화면 클릭시 키보드나 테이트 피커가 닫히게 하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //등록버튼의 활성화 여부 판단 메서드
    private func validateInputField(){
        //비어있지 않으면
        self.confirmButton.isEnabled = !(self.titleTextFeild.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
}


//델리게이트 채택
extension WriteDiaryViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        self.validateInputField()
    }
}
