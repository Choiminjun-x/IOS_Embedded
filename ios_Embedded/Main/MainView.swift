//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let loginLabel: UILabel = .init()
    private let textLabel: UITextField = .init()
    private let textChangeBtn: UIButton = .init()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    
    func setAppearance() {
        
        self.do {
            $0.backgroundColor = .black
        }
        
        loginLabel.do {
            self.addSubview($0)
            $0.text = "Login"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(150)
            }
        }
            
        UIButton().do {
            self.addSubview($0)
            $0.setTitle("yewon", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.backgroundColor = .cyan
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.equalTo(150)
                $0.top.equalTo(loginLabel.snp.bottom)
            }
            $0.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        }
        
        textChangeBtn.do {
            self.addSubview($0)
            $0.setTitle("change", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .darkGray
            $0.snp.makeConstraints{
                $0.bottom.equalTo(loginLabel.snp.top)
                $0.height.equalTo(100)
                $0.width.equalTo(150)
                $0.trailing.equalToSuperview().offset(-20)
            }
            $0.addTarget(self, action: #selector(changeText), for: .touchUpInside)
        }
        
        textLabel.do{
            self.addSubview($0)
            $0.textColor = .white
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 2.0
            $0.textAlignment = .center
            $0.layer.borderColor = CGColor(red: 255/255, green: 153/255, blue: 255/255, alpha: 1.0)
            $0.snp.makeConstraints{
                $0.bottom.equalTo(loginLabel.snp.top)
                $0.height.equalTo(100)
                $0.width.equalTo(150)
                $0.leading.equalToSuperview().offset(20)
            }
        }

    }
    
    @objc
    func changeColor(sender: UIButton){
        loginLabel.text = "Login Success!!"
        loginLabel.textColor = .blue
    }
    
    @objc func changeText(sender: UIButton){
        loginLabel.text = textLabel.text
        loginLabel.textColor = .purple
    }
}
