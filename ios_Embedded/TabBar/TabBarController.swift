//
//  TabBarController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/12.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - LifeCycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = MainViewController()
        let vc2 = CommunityViewController()
        
        vc1.title = "메인"
        vc2.title = "커뮤니티"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: true)
        
    }
}
