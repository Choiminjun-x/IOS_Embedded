//
//  MapView.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
import CoreLocation
import GooglePlaces

class MapView: UIView, CLLocationManagerDelegate, GMSMapViewDelegate{

    //MARK: - Properties
    private var mapView: GMSMapView = .init()
    private var locationManager: CLLocationManager = .init()
    private var searchMarker: GMSMarker = .init()
    private var infoMarker: GMSMarker = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.displaylocation()
        self.setAppearance()
        
    }
    
    //MARK: - view
    func setAppearance() {
        
        self.mapView.do{
            self.addSubview($0)
            $0.snp.makeConstraints{
                $0.width.equalToSuperview()
                $0.height.equalToSuperview()
            }
            //원래 내위치로 가는 버튼
            $0.settings.myLocationButton = true
            //내 위치 표시 파란점
            $0.isMyLocationEnabled = true
            $0.settings.allowScrollGesturesDuringRotateOrZoom = true
        }
    }
    
    func displaylocation(){
        locationManager.delegate = self
        //앱이 실행될 때 위치 추적 권한 요청
        locationManager.requestAlwaysAuthorization()
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled(){
        //위치 업데이트
            locationManager.startUpdatingLocation()
            move(at: locationManager.location?.coordinate)
        }
    }
    
    
    func move(at coordinate: CLLocationCoordinate2D?){
        guard let coordinate = coordinate else {
            return
        }
        
        //위, 경도 가져오기
        print(coordinate.latitude, coordinate.longitude, "DDD")
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: self.frame, camera: camera)

    }
    
    //검색한 곳 마커 띄우기
    func movetoSearch(at coordinate: CLLocationCoordinate2D?, place: GMSPlace){
        guard let coordinate = coordinate else {
            return
        }
        mapView.clear()
        
        //위, 경도 가져오기
        print(coordinate.latitude, coordinate.longitude, "AAA")
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let searchcoor = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
        let searchCamera = GMSCameraUpdate.setTarget(searchcoor)
        mapView.animate(with: searchCamera)
        
        searchMarker.position = searchcoor
        searchMarker.title = place.name
        searchMarker.snippet = place.formattedAddress
        searchMarker.map = mapView
        mapView.selectedMarker = searchMarker
    }
//
//    //탭한 곳 정보 띄우는 함수
//    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D){
//        infoMarker.snippet = placeID
//        infoMarker.position = location
//        infoMarker.title = name
//        infoMarker.opacity = 0;
//        infoMarker.infoWindowAnchor.y = 1
//        infoMarker.map = mapView
//        mapView.selectedMarker = infoMarker
//    }

}

