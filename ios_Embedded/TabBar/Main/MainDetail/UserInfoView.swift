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
        
        self.backgroundColor = UIColor(displayP3Red: 220/255, green: 222/255, blue: 222/255, alpha: 1)
        
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
                $0.bottom.equalToSuperview().offset(-100)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.nameLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
            }
            $0.text = "\(UserInfo.shared.name ?? "")"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
        }
        self.infoVstackView.setCustomSpacing(20, after: self.nameLabel)
        self.emailLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
            }
            $0.text = "\(UserInfo.shared.email ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
        self.infoVstackView.setCustomSpacing(20, after: self.emailLabel)
        self.carNameLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
            }
            $0.text = "\(UserInfo.shared.carName ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
        self.infoVstackView.setCustomSpacing(20, after: self.carNameLabel)
        self.carNumBerLabel.do {
            self.infoVstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-30)
            }
            $0.text = "\(UserInfo.shared.carNumber ?? "")"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
        }
    }
}
