//
//  MapViewController.swift
//  miniProject01
//
//  Created by 나유진 on 2022/10/26.
//

import UIKit


class MapViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView!
    var markers = [MTMapPOIItem()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 맵뷰 그리기
        mapView = MTMapView(frame: self.view.frame) //bounds
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)

        // 2 좌표 찍기
        let geo = MTMapPointGeo(latitude: 37.4630783, longitude: 126.9059344)
        let mapPoint = MTMapPoint(geoCoord: geo)
        mapView.setMapCenter(mapPoint, zoomLevel: 1, animated: true)
/*
        // 3 마커 찍기
        let marker = MTMapPOIItem()
        marker.itemName = "남부여성발전센터"
        marker.mapPoint = mapPoint
        marker.markerType = .redPin
        marker.showAnimationType = .noAnimation
        markers = [marker]
        //mapView.addPOIItems(markers)
*/

        drawMap()

        
        //API 호출
        //getDataMarketofDaegu()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        drawMap()
        
    }

    // 데이터의 좌표 맵에 그리기
    func drawMap(){
        
        guard let events = arrEvents else { return }
        
        for event in events{
            guard let event = event as? [String:String] else { return } //딕셔너리는 옵셔널이니까 언래핑
            if let x = event["x"],
               let y = event["y"],
               let xCoordinate = Double(x),
               let yCoordinate = Double(y),
               let placeName = event["title"]{
                
                // 2 좌표 찍기
                //임시로 ㅠㅠ --
                var geo = MTMapPointGeo()
                if xCoordinate > yCoordinate {
                    geo = MTMapPointGeo(latitude: yCoordinate, longitude: xCoordinate)
                }
                else {
                    geo = MTMapPointGeo(latitude: xCoordinate, longitude: yCoordinate)
                }
                //--
                
                //let geo = MTMapPointGeo(latitude: xCoordinate, longitude: yCoordinate)
                let mapPoint = MTMapPoint(geoCoord: geo)
                
                // 3 마커 찍기 (추가)
                let marker = MTMapPOIItem()
                marker.itemName = placeName
                marker.mapPoint = mapPoint
                marker.markerType = .customImage
                marker.customImage = UIImage(named: "pin_blue")
                marker.showAnimationType = .noAnimation
                markers.append(marker)

            }
        }
        mapView.addPOIItems(markers)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
