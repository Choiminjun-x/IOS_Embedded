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
                $0.height.equalTo(200)
            }
        }
            
            UIButton().do {
                self.addSubview($0)
                $0.setTitle("yewon", for: .normal)
                $0.setTitleColor(.blue, for: .normal)
                $0.backgroundColor = .cyan
                $0.snp.makeConstraints {
                    $0.width.equalToSuperview()
                    $0.height.equalTo(200)
                    $0.top.equalTo(loginLabel.snp.bottom)
                }
                $0.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
            }
    }
    
    @objc
    func changeColor(sender: UIButton){
        loginLabel.text = "Login Success!!"
        loginLabel.textColor = .blue
    }
}
