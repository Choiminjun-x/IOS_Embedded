//
//  MainViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: MainView = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
        //민준
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationConf()
        self.navigationController?.navigationBar.isHidden = true
        self.pageEvent()
    }
    
    //MARK: - navigation Configure
    private func navigationConf() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    //MARK: - pageEvent
    func pageEvent() {
        self.pageView.carInfoBtnEvent
            .subscribe(onNext: {
                let page = UserInfoViewController()
                self.navigationController?.pushViewController(page, animated: true)
            }).disposed(by: disposeBag)
    }
}
