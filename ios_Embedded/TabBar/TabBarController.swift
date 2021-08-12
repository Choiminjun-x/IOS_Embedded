//
//  TabBarController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/12.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let pageView: TabBarView = .init()
    
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = MainViewController()
        vc1.title = "메인"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        
        setViewControllers([nav1], animated: true)
        
    }
}
