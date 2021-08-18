//
//  LoadingView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit

class LoadingView: UIView {
    
    //MARK: - Properties
    private let loadingMainLogoLabel: UILabel = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    //MARK: - view
    func setAppearance() {
        self.backgroundColor = .systemBlue
        
        self.loadingMainLogoLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.centerY.centerX.equalToSuperview()
                $0.height.equalTo(100)
            }
            $0.text = "메인 로고 들어갈 곳"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 30)
            $0.textColor = .white
        }
    }
}
