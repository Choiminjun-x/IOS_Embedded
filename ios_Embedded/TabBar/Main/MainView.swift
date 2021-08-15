//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let textLabel: UILabel = .init()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    func setAppearance() {
        
        self.backgroundColor = .cyan
        self.textLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.centerY.width.equalToSuperview()
                $0.height.equalTo(100)
                $0.top.equalToSuperview().offset(100)
            }
            $0.text = "메인이야~~~~"
        }
    }
}
