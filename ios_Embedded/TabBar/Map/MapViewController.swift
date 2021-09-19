//
//  MapViewController.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/14.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation
import GooglePlaces

class MapViewController: UIViewController{
    
    //MARK: - Properties
    private let pageView: MapView = .init()
    private let refreshButton: UIBarButtonItem = .init()

    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GMSAutoCompleteConf()
    }
    
    func GMSAutoCompleteConf(){
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }

}
extension MapViewController: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController:
                            GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.pageView.movetoSearch(at: place.coordinate, place: place)
        
        //dismiss
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
