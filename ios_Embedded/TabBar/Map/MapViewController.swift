//
//  MapViewController.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/14.
//

import UIKit
import RxCocoa
import RxSwift
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Properties
    private let pageView: MapView = .init()
    
    //MARK: - LifeCycle
    override func loadView() {
        //self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
