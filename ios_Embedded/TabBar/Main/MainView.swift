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
        self.backgroundColor = .white
    }
}
