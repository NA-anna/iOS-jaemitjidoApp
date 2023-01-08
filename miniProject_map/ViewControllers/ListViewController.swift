//
//  ListViewController.swift
//  miniProject01
//
//  Created by 나유진 on 2022/10/26.
//

import UIKit

class ListViewController: UITableViewController {
    
   
    var filteredData: NSMutableArray = []   // 필터링 된 데이터 저장하는 배열
    var filterFlag: Bool = false
    var bookmarkData: NSMutableArray = []
    
    // 아울렛
    @IBOutlet var searchBar: UISearchBar!
    
    
    //===========================================================================================
    // viewDidLoad()
    //===========================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() 
    }
    
    
    
    
    //===========================================================================================
    // @IBAction
    //===========================================================================================
    
    // 북마크 추가
    /*
    @IBAction func actBookmark(_ sender: Any) {
        
        let btnBookmark = self.tableView.viewWithTag(6) as? UIButton
        guard let strIdx = btnBookmark?.title(for: .normal),
              let intIdx = Int(strIdx)
        else { return }
        
        print(intIdx)
        
        // alert
        let alert = UIAlertController(title: "북마크에 추가하시겠습니다?", message: "", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "확인", style: .default, handler: { _ in
            
//            if let temp = self.btnBookmark.accessibilityValue {
//                print(temp)
//            }
            
            
            
            
            guard let events = arrEvents else { return }
            print(events)
            guard let newElement = events[intIdx] as? [String:String] else { return }
            print(newElement)
            
            self.bookmarkData.add(newElement)
            self.bookmarkData.write(toFile: getFilePath(fileName: "test.plist"), atomically: true)
            
            //화면전환
            self.tabBarController?.selectedIndex = 3

        })
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    */

    //===========================================================================================
    // Function - filter
    //===========================================================================================
    func filter(with query : String?){
        guard let events = arrEvents as? Array<[String:Any]>,
              let query = query //searchBar.text
        else { return }
            
        print("==filter==")
        
        if query == "" {
            self.filteredData = []
            self.filterFlag = false
        }else{
            let copyData = events //[["title": "밤도깨비야시장", "place": "반포"], ["title": "밤도깨비야시장", "place": "여의도"]]
            let filter = copyData.filter({ dic in
        let val = String(describing: dic["title"])
                return val.contains(query)
            })
            
            self.filterFlag = true
            self.filteredData = NSMutableArray(array: filter)
//            guard let filteredData = filter as? NSMutableArray else { return }
//            self.filteredData = filteredData
            
            
            print(self.filteredData )
            //테스트
           
               
        }

     
        tableView.reloadData()
        
        /*
        if query == "" {
         filterdData = []
            print("빈칸입니다")
            tableView.reloadData()
        }else {
            events = events.filter{ $0["category"] as! String == query }
         filterdData = events
            print("검색어가 있습니다")
           print("filterdData: ", filterdData!)
            tableView.reloadData()
        }
         */
    }
    
    
    
    //===========================================================================================
    // Table view data source
    //===========================================================================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if self.filterFlag {
            return filteredData.count
        }else if let events = arrEvents {
            return events.count
        }else {
            return 0
        }
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        // 악세사리
//        cell.accessoryView = UIImageView(image: UIImage(systemName: "heart"))
        
        // 데이터 분기
        var events: NSMutableArray = []
        if self.filterFlag {
            events = filteredData
        }else if let arrEvents = arrEvents {
            events = arrEvents
        }
        guard let event = events[indexPath.row] as? [String:String] else { return cell }

        
        // TABLE VIEW 에 값 지정
        let lblTitle = cell.viewWithTag(1) as? UILabel
        lblTitle?.text = event["title"]
        let lblCategory = cell.viewWithTag(2) as? UILabel
        lblCategory?.text = event["category"]
        let lblPlace = cell.viewWithTag(3) as? UILabel
        if let place = event["place"] { lblPlace?.text = "장소: \(place)" }
        let lblDate = cell.viewWithTag(4) as? UILabel
        lblDate?.text = "\(event["startDate"] ?? "") ~ \(event["endDate"] ?? "")"
        let lblContent = cell.viewWithTag(5) as? UILabel
        lblContent?.text = event["content"]
        
        let btnBookmark = cell.viewWithTag(6) as? UIButton
        btnBookmark?.setTitle(String(indexPath.row), for: .normal)
        
        
        
        return cell
    }




}

//===========================================================================================
// Extension 확장
//===========================================================================================

// SEARCH BAR 프로토콜
extension ListViewController: UISearchBarDelegate {
    
    // MARK: - UISearchBar Delegate

    // [검색]버튼 클릭 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        filter(with: searchBar.text)
        
        searchBar.resignFirstResponder()
    }
}




