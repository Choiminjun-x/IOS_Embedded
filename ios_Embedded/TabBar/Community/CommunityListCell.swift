//
//  CommunityListCell.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/28.
//

import UIKit
import SnapKit
import RxSwift

struct CommnuityListCellModel {
    var title: String
}

class CommunityListCell: UITableViewCell {
    //MARK: - Properties
    private let vstackView: UIStackView = .init()
    private let titleLabel: UILabel = .init()
    
    // Object LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setAppearance()
    }
    
    //MARK: - View
    private func setAppearance() {
        
        self.vstackView.do {
            self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.titleLabel.do {
            vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalToSuperview()
            }
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14)
        }
    }
    
    func displayCellModel(_ model: CommnuityListCellModel) {
        self.titleLabel.text = model.title
    }
}
