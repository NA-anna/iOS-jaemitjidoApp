//
//  Data.swift
//  miniProject_map
//
//  Created by 나유진 on 2022/11/06.
//

import Foundation

struct Event {
    var title: String?
    var category: String?
    var place: String?
    var x: String?
    var y: String?
}
//===========================================================================================
// 글로벌 변수 선언, 글로벌 데이터 가져오기
//===========================================================================================
let gCategories = ["플리마켓", "5일장"] //, "행사", "축제", "버스킹", "콘서트", "박람회"]
var arrEvents: NSMutableArray? = load(fileName: "event", fileType: "plist")
var gBookmarks: NSMutableArray? = load(fileName: "bookmark", fileType: "plist")

//===========================================================================================
// 경로 만들기 함수
//===========================================================================================
func getFilePath(fileName: String) -> String{
    
    let docDir: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let docPath = docDir[0] as NSString // String -> NSString
    let targetPath = docPath.appendingPathComponent(fileName)

    return targetPath
}
//===========================================================================================
// 파일 복사 함수 : FileManager
//===========================================================================================
func copyFile(_ targetPath: String, _ orginPath: String) {
    
    // 복사 및 예외처리
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: targetPath) {
        do{
            try fileManager.copyItem(atPath: orginPath, toPath: targetPath)
        } catch {
            print("--파일 복사 실패--")
        }
    }
}
//===========================================================================================
// event.plist에 저장된 데이터 가져오기 -> arrEvents 전역변수에 저장
//===========================================================================================
func load(fileName: String, fileType: String) -> NSMutableArray? {
    
    let targetPath = getFilePath(fileName: fileName+"."+fileType)
    guard let orginPath = Bundle.main.path(forResource: fileName, ofType: fileType) else { return [] }
    copyFile(targetPath, orginPath) // 파일 복사 함수 실행 (순서대로 TO, FROM)

    // 데이터 가져오기
    return NSMutableArray(contentsOfFile: targetPath)
    
}

