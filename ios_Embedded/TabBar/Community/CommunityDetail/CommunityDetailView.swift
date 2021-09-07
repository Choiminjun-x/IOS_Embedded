//
//  CommunityDetailView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/01.
//

import UIKit

struct CommunityDetailModel {
    var question: String?
    var answer: String?
}

class CommunityDetailView: UIView {
    
    private let vscrollView: UIScrollView = .init()
    private let contentView: UIView = .init()
    private let vstackView: UIStackView = .init()
    private let questionLabel: UILabel = .init()
    private let answerLabel: UILabel = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    private func displayDetail() {
        
    }
    //MARK: - View Method
    private func setAppearance() {
        
        self.backgroundColor = .white
        
        self.vscrollView.do {
            self.addSubview($0)
            self.vscrollView.alwaysBounceVertical = true
            $0.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            }
        }
        // contentLayoutGuide -> ScrollView에 들어갈 Content의 전체영역이다.
        // frameLayoutGuide -> ScrollView의 Frame에 해당하는 영역
        self.contentView.do {
            vscrollView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.vscrollView.contentLayoutGuide.snp.top)
                $0.bottom.equalTo(self.vscrollView.contentLayoutGuide.snp.bottom)
                $0.leading.equalTo(self.vscrollView.contentLayoutGuide.snp.leading)
                $0.trailing.equalTo(self.vscrollView.contentLayoutGuide.snp.trailing)
                $0.width.equalTo(self.vscrollView.frameLayoutGuide.snp.width)
            }
        }
        self.vstackView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-60)
                $0.height.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-30)
                $0.leading.equalToSuperview().offset(30)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.questionLabel.do {
            self.vstackView.addArrangedSubview($0)
            $0.text = "질문: "
        }
        self.answerLabel.do {
            self.vstackView.addArrangedSubview($0)
            $0.text = "대답: "
        }
    }
}
