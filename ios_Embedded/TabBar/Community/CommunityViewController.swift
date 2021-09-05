//
//  CommunityViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit

struct Result: Codable {
    var title: String?
    var question: String?
    var answer: [String]?
    
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
        socket.sendMessage(socketMessage: "community_init", message: "자동차 사고")
        var result = Result()
        
        socket.socket.on("community_init") { jsonObject, ack in
            for i in jsonObject{
                do{
                    //utf8로 바꿔서
                    
                    let r = try? JSONDecoder().decode(Result.self, from: i as! Data)
                    result.title=r?.title
                    result.question=r?.question
                    result.answer=r?.answer
                    self.results?.append(result)
                    print(result)
                }catch{
                    print(error)
                }
            }
//            do{
//                let getInstanceData = try JSONDecoder().decode(Result.self, from: jsonObject)
//                print(getInstanceData)
//            }catch{
//                print(error)
//            }
        }
                
        
        let cellModels: [CommnuityListCellModel] = results?.compactMap {
            guard let title = $0.title else { return nil }
            return .init(title: title)
        } ?? []
        self.displayCommunityList(cellModels: cellModels)
    }
    
    func displayCommunityList(cellModels: [CommnuityListCellModel]) {
        self.pageView.displayTableView(cellModels: cellModels)
        
    }
}
