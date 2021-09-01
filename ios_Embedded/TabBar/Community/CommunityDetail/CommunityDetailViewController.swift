//
//  CommunityDetailViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/01.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: CommunityView = .init()
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
        //민준
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //github test sibal
    }
}
