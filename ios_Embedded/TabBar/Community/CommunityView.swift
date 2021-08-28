//
//  CommunityView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit
import SnapKit

class CommunityView: UIView {
    
    //MARK: - Properties
    private let communityListView: UITableView = .init(frame: .zero)
    private let CommunityListViewDelegate: CommunityListViewDelegate = .init()
    
    //MARK: - LifeCycle 
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    func setAppearance() {
        
        self.communityListView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalToSuperview()
                $0.top.equalToSuperview().offset(200)
            }
            $0.delegate = self.CommunityListViewDelegate
            $0.dataSource = self.CommunityListViewDelegate
            $0.register(CommunityListCell.self, forCellReuseIdentifier: "CommunityListCell")
        }
    }
    
    func displayTableView(cellModels: [CommnuityListCellModel]) {
        self.CommunityListViewDelegate.cellModels = {
            return cellModels
        }()
        self.communityListView.reloadData()
    }
}

//MARK: - TableView Delegate
fileprivate class CommunityListViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellModels: [CommnuityListCellModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "CommunityListCell", for: indexPath).do {
            guard let cellModel = self.cellModels?[indexPath.row] else { return }
            ($0 as? CommunityListCell)?.displayCellModel(cellModel)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



