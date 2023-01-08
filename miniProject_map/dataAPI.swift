//
//  dataAPI.swift
//  miniProject_map
//
//  Created by 나유진 on 2022/11/03.
//

import Foundation
import Alamofire

struct ResultDataDaeguMarket: Hashable, Codable {
    let currentCount: Int?
    let data: [Market]?
    let matchCount: Int?
    let page: Int?
    let perPage: Int?
    let totalCount: Int?
}
struct Market: Hashable, Codable{
    /*
    private var 전통시장명: String
    private var 위도: String
    private var 경도: String
    private var 영업일: String
    private var 주소: String
        private var 영업시간: String
        private var 점포수: Int
    
    
    enum CodingKeys: String, CodingKey{
        case 전통시장명 = "title"
        case 위도 = "x"
        case 경도 = "y"
        case 영업일 = "category"
        case 주소 = "place"
        case 영업시간
        case 점포수
    }
     */
    private var title: String
    private var x: String
    private var y: String
    private var category: String
    private var place: String
    
    enum CodingKeys: String, CodingKey{
        case title = "전통시장명"
        case x = "위도"
        case y = "경도"
        case category = "영업일"
        case place = "주소"
    }
     
}

//==================api Header 정보======================//
let apiServiceKey = "mAe+GWpPxmtRRex6gA7cL5l3Eno9CgDEaLfRPGK3L7JoGnLMku54NhrJr3wlr4wT6FH1UqUn1qXECQiO6xMS4g=="
//(Decoding 키)
//======================================================//

//===========================================================================================
// 글로벌 변수 선언, 글로벌 데이터 가져오기
//===========================================================================================
//var daeguMarkets: [Market]? = getDataDaeguMarket()

//===========================================================================================
// API 호출 GET
//===========================================================================================

/*
func getMarketData( handler: @escaping([Market])->() ) {
    
    // 0 결과 변수 선언
    var markets: [Market] = []
    
    // 1 url request
    let strUrl = "http://api.data.go.kr/openapi/tn_pubr_public_trdit_mrkt_api"

    // 2 Alamofire
    let params: Parameters = ["serviceKey":apiServiceKey] //["query": query, "page": page]
    //let headers: HTTPHeaders = []
    let alamo = AF.request(strUrl, method: .get, parameters: params) //, headers: headers)
    alamo.responseDecodable(of: ResultDataDaeguMarket.self) { response in
                
        debugPrint(response)
        
        switch response.result {
        case .success( _)://obj): //통신성공
            guard let root = response.value
                ,let data = root.data
            else { return }
            print("대구데이터 가져오기 성공")
            print(data)
            markets = data
            //daeguMarkets = markets
            handler(markets)
        case .failure(let e):   //통신실패
            print("대구데이터 가져오기 실패")
            print(e.localizedDescription)
        }
    }
}
*/

func getDataDaeguMarket( handler: @escaping([Market])->() ) {
    
    // 0 결과 변수 선언
    //var markets: [Market] = []
    
    // 1 url request
    let strUrl = "https://api.odcloud.kr/api/15095881/v1/uddi:935a1573-4fd3-4273-bfa4-dfd8405c7cbf"

    // 2 Alamofire
    let params: Parameters = ["serviceKey":apiServiceKey] //["query": query, "page": page]
    //let headers: HTTPHeaders = []
    let alamo = AF.request(strUrl, method: .get, parameters: params) //, headers: headers)
    alamo.responseDecodable(of: ResultDataDaeguMarket.self) { response in

        debugPrint(response)
        
        switch response.result {
        case .success( _)://obj): //통신성공
            guard let root = response.value
                ,let data = root.data
            else { return }
            print("대구데이터 가져오기 성공")
            handler(data)
        case .failure(let e):   //통신실패
            print(e.localizedDescription)
        }
        
    }
}



