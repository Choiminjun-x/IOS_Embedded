//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    //MARK: - Properties
    private let mainScrollView: UIScrollView = .init()
    private let contentView: UIView = .init()
    private let vstackView: UIStackView = .init()
    private let uiView: UIView = .init()
    private let uiView2: UIView = .init()
    
    private let labelOne: UILabel = .init()
    private let labelTwo: UILabel = .init()
    private let labelThree: UILabel = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    //MARK: - View
    private func setAppearance() {
        self.backgroundColor = .blue
        
        self.mainScrollView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.snp.top)
                $0.bottom.equalTo(self.snp.bottom).offset(20)
                $0.leading.equalTo(self.snp.leading)
                $0.trailing.equalTo(self.snp.trailing)
            }
            $0.alwaysBounceVertical = true
        }
        
        self.labelThree.do {
            mainScrollView.addSubview($0)
            $0.text = "Scroll center"
            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(40)
                $0.top.equalToSuperview().offset(70)
            }
        }

        self.labelTwo.do {
            mainScrollView.addSubview($0)
            $0.text = "Scroll Bottom"
            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(40)
                $0.top.equalToSuperview().offset(1000)
                $0.bottom.equalToSuperview().offset(-40)
            }
        }
    }
}
