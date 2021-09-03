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
    
    var socket = SocketIOManager.shared
    
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

    //cell에 넣을 모델을 만들어주는 과정 
    func makeCellModels() {
        socket.sendMessage(socketMessage: "community_init", message: "커뮤니티 초기화")
        
        socket.socket.on("community_init") { _, _ in
            
        }
        var result = Result()
        //여기서 커뮤니티 크롤링한거 다 넣어주면 되는거야 예원아
        result.name = "first community name"
        results?.append(result)
        result.name = "second community name"
        results?.append(result)
        result.name = "third community name"
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
