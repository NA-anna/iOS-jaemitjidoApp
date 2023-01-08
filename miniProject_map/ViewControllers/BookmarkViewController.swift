//
//  BookmarkViewController.swift
//  miniProject_map
//
//  Created by 나유진 on 2022/11/01.
//

import UIKit

class BookmarkViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bookmarks = gBookmarks {
            return bookmarks.count
        }else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        // label에 값 지정
        guard let bookmarks = gBookmarks,
              let event = bookmarks[indexPath.row] as? [String:String],
              let place = event["place"],
              let startDate = event["startDate"],
              let endDate = event["endDate"]
        else { return cell } //딕셔너리는 옵셔널이니까 언래핑
        
        let lblTitle = cell.viewWithTag(1) as? UILabel
        lblTitle?.text = event["title"]
        let lblCategory = cell.viewWithTag(2) as? UILabel
        lblCategory?.text = event["category"]
        let lblPlace = cell.viewWithTag(3) as? UILabel
        lblPlace?.text = "장소: \(place)"
        let lblDate = cell.viewWithTag(4) as? UILabel
        lblDate?.text = "\(startDate) ~ \(endDate)"
        let lblContent = cell.viewWithTag(5) as? UILabel
        lblContent?.text = event["content"]
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
