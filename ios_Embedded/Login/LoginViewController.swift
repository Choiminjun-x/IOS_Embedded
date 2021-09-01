//
//  ViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/07/18.
//

import UIKit
import RxCocoa
import RxSwift
import SocketIO

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: LoginView = .init()
    
    let disposeBag: DisposeBag = .init()
    var socket: SocketIOClient!
    
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
    
    //아무 곳이나 화면 터치 시 키보드 내리기 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){ self.view.endEditing(true)
    }
}
