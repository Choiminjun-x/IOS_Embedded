//
//  CommunityViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit

class CommunityViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: CommunityView = .init()
    
    //MARK: - LifeCycle 
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
