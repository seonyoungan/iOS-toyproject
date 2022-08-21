//
//  ViewController.swift
//  diary
//
//  Created by 안선영 on 2022/08/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var diaryList = [Diary](){
        didSet{
            self.saveDiaryList()
        }
    } //Diary type배열로 초기화되게함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()

    }
    
    //다이어리 리스트에 추가된 일기를 콜렉션뷰에 추가시키기
    
    //콜렉션뷰에 속성을 설정하는 메서드 추가
    private func configureCollectionView() {
      self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
      self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      self.collectionView.delegate = self
      self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let wireDiaryViewContoller = segue.destination as? WriteDiaryViewController {
        wireDiaryViewContoller.delegate = self
      }
    }
    
    private func saveDiaryList() {
      let date = self.diaryList.map {
        [
          "title": $0.title,
          "contents": $0.contents,
          "date": $0.date,
          "isStar": $0.isStar
        ]
      }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "diaryList")
      }


    private func loadDiaryList(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
      }
    
    
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
  }


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //컬렉션뷰에 지정된 위치에 표시할 셀을 요청하는 메서드
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title // 일기제목 표시되도록
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
      }
    }

//콜렉션뷰에 레이아웃 구성
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}
extension ViewController: WriteDiaryViewDelegate{
    func didSelectReigster(diary: Diary) {
        self.diaryList.append(diary) //일기 작성화면에서 등록될 때마다 다이어리 배열에 등록된 일기들이 추가되게 됨
        self.diaryList = self.diaryList.sorted(by: {
          $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData() //일기 추가할 때마다 컬렉션뷰에 일기가 추가됨
    }
}
