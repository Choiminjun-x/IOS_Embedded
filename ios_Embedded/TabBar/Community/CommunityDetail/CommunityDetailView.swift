//
//  CommunityDetailView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/01.
//

import UIKit
import RxCocoa
import RxSwift


class CommunityDetailView: UIView {
    
    //MARK: - Properties
    private let vscrollView: UIScrollView = .init()
    private let contentView: UIView = .init()
    private let vstackView: UIStackView = .init()
    private let vstackView2: UIStackView = .init()
    private let vstackView4: UIStackView = .init()
    private let titleLabel: UILabel = .init()
    private let questionLabel: UILabel = .init()
    private let answerLabel: UILabel = .init()
    private let lineView: UIView = .init()
    private let quetionLineLabel: UILabel = .init()
    private let answerLineLabel: UILabel = .init()
    private let logoImageView: UIImageView = .init()
    private let logotextLabel: UILabel = .init()
    private let answerImageView: UIImageView = .init()
    private let pageLabel: UILabel = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    //MARK: - View Method
    private func setAppearance() {
        
        self.backgroundColor = .white
        
        self.vscrollView.do {
            self.addSubview($0)
            self.vscrollView.alwaysBounceVertical = true
            $0.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            }
        }
        // contentLayoutGuide -> ScrollView에 들어갈 Content의 전체영역이다.
        // frameLayoutGuide -> ScrollView의 Frame에 해당하는 영역
        self.contentView.do {
            self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
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
                $0.width.equalToSuperview().offset(-20)
                $0.height.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.leading.equalToSuperview().offset(10)
                $0.trailing.equalToSuperview().offset(-10)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.logoImageView.do{
            self.contentView.addSubview($0)
            $0.image = UIImage(named: "AppIconLogo")
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(10)
                $0.height.equalTo(80)
                $0.width.equalTo(80)
            }
        }
        
        //유저사진과 제목
        self.vstackView2.do {
            self.vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-20)
                $0.height.equalTo(80)
                $0.top.equalTo(80)
                $0.leading.equalToSuperview().offset(10)

            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.titleLabel.do {
            self.vstackView2.addArrangedSubview($0)
            $0.font = UIFont(name:"HelveticaNeue-Bold", size: 23.0)
            $0.numberOfLines = 0
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        
        self.vstackView.setCustomSpacing(10, after: vstackView2)
    
        self.questionLabel.do {
            self.vstackView.addArrangedSubview($0)
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15)

            
        }
        self.vstackView.setCustomSpacing(10, after: self.questionLabel)
        
        self.lineView.do{
            self.vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints{
                $0.width.equalToSuperview().offset(-20)
                $0.height.equalTo(1)
            }
            $0.backgroundColor = .gray
        }
        
        self.vstackView.setCustomSpacing(10, after: self.lineView)
        
        //큐앤에이사진과 답변레이블
        self.vstackView4.do {
            self.vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.equalTo(80)
            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.answerImageView.do{
            self.vstackView4.addArrangedSubview($0)
            $0.image = UIImage(named: "answer")
            $0.snp.makeConstraints{
                $0.width.equalTo(80)
            }
        }
        
        self.answerLineLabel.do{
            self.vstackView4.addArrangedSubview($0)
            $0.text = "<답변>"
        }
        self.answerLabel.do {
            self.vstackView.addArrangedSubview($0)
            $0.numberOfLines = 0
        }
        
        self.vstackView.setCustomSpacing(30, after: answerLabel)
        
        self.pageLabel.do{
            self.vstackView.addArrangedSubview($0)
            $0.textAlignment = .center
        }
    }
    
    //MARK: - displayDetailView
    func displayCellModel(_ model: [Result], index: Int) {
        self.titleLabel.text = "\(model[index].title ?? "") "
        self.questionLabel.text = "\(model[index].question ?? "")"
        self.answerLabel.text = "\(model[index].answer![0])"
        self.pageLabel.text = "-"+String(index+1)+"번째 글-"
    }
}
