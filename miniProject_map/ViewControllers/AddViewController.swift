//
//  AddViewController.swift
//  miniProject01
//
//  Created by 나유진 on 2022/10/26.
//

import UIKit

class AddViewController: UIViewController {
    
    var category: String?{
        didSet(oldValue){
            
        }willSet(newValue){
            txtCategory.text = newValue
            enableAddBtn()
        }
    }
    var place: Document?{
        didSet(oldValue){
            
        }willSet(newValue){
            txtPlace.text = newValue?.place_name
           // id = newValue?.id
            x = newValue?.x
            y = newValue?.y
            enableAddBtn()
        }
    }
    var x: String?
    var y: String?
    //var id: String?
    
   
    @IBOutlet var btnDone: UIBarButtonItem!
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var txtCategory: UITextField!
    @IBOutlet var datePickerStartDate: UIDatePicker!
    @IBOutlet var datePickerEndDate: UIDatePicker!
    @IBOutlet var txtPlace: UITextField!
    @IBOutlet var txtContent: UITextView!
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitle.delegate = self //UITextFieldDelegate 프로토
        
    }

    @IBAction func tileDidEnd(_ sender: Any) {
        enableAddBtn()
    }
    
    @IBAction func actDone(_ sender: Any) {
        print("등록하기버튼클릭")
        
        
        // 현재 로컬에서 추가된 내용을 "event.plist"에 반영
        guard let title = txtTitle.text,
              let category = txtCategory.text,
              let place = txtPlace.text,
              let x = x,
              let y = y
        else { return }
        var startDate = datePickerStartDate.date.toString()
        var idx = startDate.index(startDate.startIndex, offsetBy: 9)
        startDate = String(startDate[...idx])
        var endDate = datePickerEndDate.date.toString()
        idx = endDate.index(endDate.startIndex, offsetBy: 9)
        endDate = String(endDate[...idx])
        
        let newEvent = ["title": title, "category": category, "startDate": startDate, "endDate": endDate, "place": place, "content": txtContent.text ?? "", "x": x, "y": y] as [String : Any]
        
        arrEvents?.add(newEvent)
        arrEvents?.write(toFile: getFilePath(fileName: "event.plist"), atomically: true)
  
    
        // alert
        let alert = UIAlertController(title: "저장되었습니다", message: "", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "확인", style: .default, handler: { _ in
            //화면전환
            self.tabBarController?.selectedIndex = 0
 
        })
        alert.addAction(actionOK)
        present(alert, animated: true)
        

    }

    // 입력 확인(타이틀, 카테고리, 장소) 후 버튼 활성화 함수
    func enableAddBtn(){
        if txtTitle.text != "" && txtCategory.text != "" && txtPlace.text != ""
        {
            btnDone.isEnabled = true
            print("--버튼 활성화--")
            return
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
     
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueID = segue.identifier
        if segueID == "category"{
            let childVC = segue.destination as? AddViewController_category
            childVC?.parentVC = self
        }else if segueID == "map"{
            let childVC = segue.destination as? AddViewController_place
            childVC?.parentVC = self
        }
    }
    

    

}






// [완료] 클릭 시 -> 키보드 닫기
extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //최초반응자 사임..
        txtTitle.resignFirstResponder()
        return true
    }
}
/*
extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("ddsfs")
        //최초반응자 사임..
        txtTitle.resignFirstResponder()

        return true
    }
}
*/
