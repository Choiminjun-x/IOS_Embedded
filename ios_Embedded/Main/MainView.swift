//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    var userModel = UserModel()
    
    private let idLabel: UITextField = .init()
    private let passwdLabel: UITextField = .init()
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
            $0.backgroundColor = .white
        }
        
        idLabel.do {
            self.addSubview($0)
            $0.placeholder = "id"
            $0.textAlignment = .center
            $0.borderStyle = .line
            $0.snp.makeConstraints {
                $0.centerY.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(50)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
            
        passwdLabel.do {
            self.addSubview($0)
            $0.placeholder = "password"
            $0.textAlignment = .center
            $0.borderStyle = .line
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.equalTo(50)
                $0.top.equalTo(idLabel.snp.bottom)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        loginBtn.do {
            self.addSubview($0)
            $0.setTitle("login", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .darkGray
            $0.snp.makeConstraints{
                $0.top.equalTo(passwdLabel.snp.bottom)
                $0.height.equalTo(70)
                $0.width.equalTo(70)
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
        if idLabel.isFirstResponder {
            passwdLabel.becomeFirstResponder()
        }
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let email = idLabel.text, !email.isEmpty else { return }
        guard let password = passwdLabel.text, !password.isEmpty else { return }
            
        if userModel.isValidEmail(id: email){
            if let removable = self.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        }
        else {
            shakeTextField(textField: idLabel)
            let emailLabel = UILabel(frame: CGRect(x: 68, y: 200, width: 279, height: 45))
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
            shakeTextField(textField: passwdLabel)
            let passwordLabel = UILabel(frame: CGRect(x: 68, y: 255, width: 279, height: 45))
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
                //self.performSegue(withIdentifier: "showMain", sender: self)
                
            }
            else {
                print("로그인 실패")
                shakeTextField(textField: idLabel)
                shakeTextField(textField: passwdLabel)
                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                loginFailLabel.tag = 102
                    
                self.addSubview(loginFailLabel)
            }
        }
    } // end of didTapLoginButton
}
