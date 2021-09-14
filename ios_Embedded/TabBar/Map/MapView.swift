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

class MapView: UIView, CLLocationManagerDelegate{

    //MARK: - Properties
    private var mapView: GMSMapView = .init()
    private var coor: CLLocationCoordinate2D = .init()
    private var latitude: CLLocationDegrees = .init()
    private var longitude: CLLocationDegrees = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.mapConf()
        self.setAppearance()
        
    }
    
    //MARK: - mapConf
    func mapConf(){
        //현재 위치 가져오기
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        //앱이 실행될 때 위치 추적 권한 요청
        locationManager.requestAlwaysAuthorization()
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 업데이트
        locationManager.startUpdatingLocation()

        //위, 경도 가져오기
        coor = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 37.566508, longitude: 126.977945)
        latitude = (coor.latitude ) as Double
        longitude = (coor.longitude ) as Double

        
    }
    
    //MARK: - view
    func setAppearance() {
        
        self.mapView.do{
            self.addSubview($0)
            $0.snp.makeConstraints{
                $0.width.equalToSuperview()
                $0.height.equalToSuperview()
            }
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
            mapView = GMSMapView.map(withFrame: self.frame, camera: camera)

            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 37.566508, longitude: 126.977945)
            marker.title = "My position"
            marker.snippet = "South Korea"
            marker.map = mapView
        }
    }
    
    
}

