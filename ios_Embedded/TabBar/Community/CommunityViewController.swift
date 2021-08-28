//
//  CommunityViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit

struct Result {
    var name: String?
}

class CommunityViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: CommunityView = .init()
    
    private var results: [Result]?
    //MARK: - LifeCycle 
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = []
        self.makeCellModels()
    }
    
    func makeCellModels() {
        var result = Result()
        result.name = "first community name"
        results?.append(result)
        result.name = "second community name"
        results?.append(result)
        
        let cellModels: [CommnuityListCellModel] = results?.compactMap {
            guard let name = $0.name else { return nil }
            return .init(title: name)
        } ?? []
        self.displayCommunityList(cellModels: cellModels)
    }
    
    func displayCommunityList(cellModels: [CommnuityListCellModel]) {
        self.pageView.displayTableView(cellModels: cellModels)
        
    }
}
