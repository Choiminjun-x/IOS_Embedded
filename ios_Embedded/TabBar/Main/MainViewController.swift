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
    
    var socket = SocketIOManager.shared
    
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
    
    //MARK: - pageEvent
    func pageEvent() {
        self.pageView.carInfoBtnEvent
            .subscribe(onNext: {
                let page = UserInfoViewController()
                self.navigationController?.pushViewController(page, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func makeAccidentAlert(){
        let alert = UIAlertController(title: "사고가 발생했습니다", message: "경찰에 신고하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //신고한다했을 때 버튼.
            self.socket.socket.emit("report", "true")
        }
        let cancleAction = UIAlertAction(title: "cancle", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
}
