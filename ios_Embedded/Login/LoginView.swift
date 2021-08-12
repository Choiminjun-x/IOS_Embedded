//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit
import SnapKit
import RxSwift

class LoginView: UIView {
    
    var userModel = UserModel()
    
    private let loginMainLabel: UILabel = .init()
    private let textLabel: UILabel = .init()
    private let idTextField: UITextField = .init()
    private let passwdTextField: UITextField = .init()
    private let loginBtn: UIButton = .init()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    func setAppearance() {
        
        self.do {
            $0.backgroundColor = .systemBlue
        }
        
        self.loginMainLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(100)
                $0.top.equalToSuperview().offset(100)
            }
            $0.text = "이미지뷰로 로고 붙히는 곳"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 30)
            
        }
        
        self.textLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
                $0.top.equalTo(self.loginMainLabel.snp.bottom).offset(55)
            }
            $0.text = "Login to your Account"
            $0.textAlignment = .left
        }
        self.idTextField.do {
            self.addSubview($0)
            $0.placeholder = "id"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.loginMainLabel.snp.bottom).offset(110)
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        self.passwdTextField.do {
            self.addSubview($0)
            $0.placeholder = "password"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 10
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
            $0.layer.cornerRadius = 10
            $0.snp.makeConstraints{
                $0.top.equalTo(passwdTextField.snp.bottom).offset(15)
                $0.height.equalTo(40)
                $0.width.equalToSuperview().offset(-100)
                $0.centerX.equalToSuperview()
            }
            $0.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        }
        
        
    }
    
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    // TextField 흔들기 애니메이션
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
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
            let loginSuccess: Bool = loginCheck(id: email, pwd: password)
            if loginSuccess {
                print("로그인 성공")
                if let removable = self.viewWithTag(102) {
                    removable.removeFromSuperview()
                }
                //로그인 성공 시 넘어가는 코드 -> 민준 작업 Rx로
                
                //self.performSegue(withIdentifier: "showMain", sender: self)
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
