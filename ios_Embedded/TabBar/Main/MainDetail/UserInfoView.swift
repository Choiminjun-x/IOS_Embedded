//
//  UserInfoView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/04.
//

import UIKit

class UserInfoView: UIView {
    //MARK: - Properties
    private let infoVstackView: UIStackView = .init()
    private let infoHstackView: UIStackView = .init()
    private let infoImageView: UIButton = .init()
    
    private let titleLabel: UILabel = .init()
    private let nameLabel: UILabel = .init()
    private let emailLabel: UILabel = .init()
    private let carNameLabel: UILabel = .init()
    private let carNumBerLabel: UILabel = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    private func setAppearance() {
        
        self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
        
        self.infoVstackView.do {
            self.addSubview($0)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 13
            $0.layer.shadowOpacity = 0.3
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-60)
                $0.trailing.equalToSuperview().offset(-30)
                $0.leading.equalToSuperview().offset(30)
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
                $0.bottom.equalToSuperview().offset(-140)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        self.titleLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
                $0.height.equalTo(30)
            }
            $0.text = "내정보"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 30)
            
        }
        self.nameLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
                $0.height.equalTo(30)
            }
            $0.text = "\(UserInfo.shared.name ?? "")"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
        }
        self.emailLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
                $0.height.equalTo(30)
            }
            $0.text = "아이디 : " + "\(UserInfo.shared.email ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
        self.carNameLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
                $0.height.equalTo(30)
            }
            $0.text = "차종 : " + "\(UserInfo.shared.carRealName ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
        self.carNumBerLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
                $0.height.equalTo(30)
            }
            $0.text = "차량 번호 : " + "\(UserInfo.shared.carNumber ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
    }
}
