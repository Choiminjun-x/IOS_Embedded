//
//  MainViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit

class MainViewController: UIViewController {
    
    private let pageView: MainView = .init()
    
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
