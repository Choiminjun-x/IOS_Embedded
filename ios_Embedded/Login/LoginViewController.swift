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
    
    //MARK: - Properties
    private let pageView: LoginView = .init()
    
    let disposeBag: DisposeBag = .init()
    
    //MARK: - LifeCycle
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
        let tabPage = TabBarController()
        tabPage.modalPresentationStyle = .fullScreen
        self.present(tabPage, animated: true, completion: nil)
    }
    
    func pageEvent() {
        self.pageView.loginBtnClickEvent
            .subscribe(onNext: {
                self.requestNextPage()
            }).disposed(by: self.disposeBag)
    }

}
