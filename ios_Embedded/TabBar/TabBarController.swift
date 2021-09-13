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
        
        vc2.socketManager("community_init", "자동차 사고")
        vc2.socketManager("community_init", "범퍼")
        vc2.socketManager("community_init", "와이퍼")
        vc2.socketManager("community_init", "미러")
        
        vc1.title = "메인"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.title = "커뮤니티"
        vc2.tabBarItem.image = UIImage(systemName: "message")
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: true)
        
    }
}
