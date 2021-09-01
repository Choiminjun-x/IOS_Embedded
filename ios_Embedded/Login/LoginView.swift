//
//  LoginView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SocketIO

class LoginView: UIView {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = .init()
    private let textLabel: UILabel = .init()
    private let idTextField: UITextField = .init()
    private let passwdTextField: UITextField = .init()
    private let loginBtn: UIButton = .init()
    
    internal var loginBtnClickEvent: PublishRelay<Void> = .init()
    let disposeBag: DisposeBag = .init()
    
    private var loginCheck: Int = 0
    
    var userModel = UserModel()
    
    //var socket: SocketIOManager! SocketIOClient??
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
//        socket = SocketIOManager()
//        socket.establishConnection()
//        socket.sendMessage(message: "why?")
    }
    
    
    //MARK: - view
    func setAppearance() {
        self.do {
            $0.backgroundColor = .init(red: 000/255, green: 153/255, blue: 255/255, alpha: 1)
        }
        
        self.logoImageView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.height.equalTo(50)
                $0.width.equalTo(self.logoImageView.snp.height).multipliedBy(6.78)
                $0.top.equalToSuperview().offset(130)
            }
            $0.image = UIImage(named: "logo")
        }
        
        self.textLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
                $0.top.equalTo(self.logoImageView.snp.bottom).offset(75)
            }
            $0.text = "Login to your Account"
            $0.textAlignment = .left
        }
        
        self.idTextField.do {
            self.addSubview($0)
            $0.placeholder = "id"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.logoImageView.snp.bottom).offset(130)
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        self.passwdTextField.do {
            self.addSubview($0)
            $0.placeholder = "password"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
                $0.top.equalTo(idTextField.snp.bottom).offset(15)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        self.loginBtn.do {
            self.addSubview($0)
            $0.setTitle("Sign in", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
            $0.snp.makeConstraints{
                $0.top.equalTo(passwdTextField.snp.bottom).offset(15)
                $0.height.equalTo(40)
                $0.width.equalToSuperview().offset(-100)
                $0.centerX.equalToSuperview()
            }
            $0.rx.tap.bind {
                self.didTapLoginButton(self.loginBtn)
                if self.loginCheck == 1 {
                    self.loginBtnClickEvent.accept(())
                }
            }.disposed(by: disposeBag) //메모리 해제
        }
        
        
    }
    
    //MAKR: - login Method 
    func loginCheck(id: String, pwd: String) -> Void {
        //서버로 여기서 아이디랑 비밀번호 전달
//        print("logincheck")
//        SocketIOManager.shared.socket.emit("logincheck", ["id" : id, "password" : pwd])
        //SocketIOManager.shared.sendMessage(message: "dsds")
                
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    // 다음 누르면 입력창 넘어가기, 완료 누르면 키보드 내려가기
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwdTextField.becomeFirstResponder()
        }
    }
    
    //로그인 버튼 클릭 시
    @objc func didTapLoginButton(_ sender: UIButton) {
        
        
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let email = idTextField.text, !email.isEmpty else { return }
        guard let password = passwdTextField.text, !password.isEmpty else { return }
        
        if userModel.isValidEmail(id: email){
            if let removable = self.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        }
        else {
            let emailLabel = UILabel(frame: CGRect(x: 68, y: 500, width: 279, height: 45))
            emailLabel.text = "이메일 형식을 확인해 주세요"
            emailLabel.textColor = UIColor.red
            emailLabel.tag = 100
            
            
            self.addSubview(emailLabel)
        } // 이메일 형식 오류
        
        if userModel.isValidPassword(pwd: password){
            if let removable = self.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        }
        else{
            let passwordLabel = UILabel(frame: CGRect(x: 68, y: 555, width: 279, height: 45))
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.textColor = UIColor.red
            passwordLabel.tag = 101
            
            self.addSubview(passwordLabel)
        } // 비밀번호 형식 오류
        
        if userModel.isValidEmail(id: email) && userModel.isValidPassword(pwd: password) {
//
//            loginCheck(id: email, pwd: password)
//            SocketIOManager.shared.socket.on("success"){_,_ in
//                self.loginCheck = 1
//                if let removable = self.viewWithTag(102){
//                    removable.removeFromSuperview()
//                }
//            }
//            SocketIOManager.shared.socket.on("fail"){_,_ in
//                print("login fail")
//                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
//                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
//                loginFailLabel.textColor = UIColor.red
//                loginFailLabel.tag = 102
//
//                self.addSubview(loginFailLabel)
//            }
            
            let loginSuccess: Bool = loginCheck(id: email, pwd: password)
            if loginSuccess {
                print("로그인 성공")
                //로그인 체크 변수 변경 -> 로그인 성공 시
                self.loginCheck = 1
                if let removable = self.viewWithTag(102) {
                    removable.removeFromSuperview()
                }

            }
            else {
                print("로그인 실패")
                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                loginFailLabel.tag = 102

                self.addSubview(loginFailLabel)
            }
        }
    } // end of didTapLoginButton
}
