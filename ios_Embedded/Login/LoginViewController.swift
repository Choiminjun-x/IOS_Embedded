//
//  ViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/07/18.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    private let pageView: LoginView = .init()
    
    let disposeBag: DisposeBag = .init()
    
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationConf()
        self.pageEvent()
    }

    private func navigationConf() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func requestNextPage(){
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func pageEvent() {
        self.pageView.searchListNextEvent
            .subscribe(onNext: {
                self.requestNextPage()
            }).disposed(by: self.disposeBag)
    }

}

