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
    
    private var results: [Result]? = []
    //MARK: - LifeCycle 
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeCellModels()
    }

    func socketManager(_ socketMessage: String, _ message: String){
        socket.sendMessage(socketMessage: socketMessage, message: message)
        var result = Result()
        
        socket.socket.on(socketMessage) { jsonObject, ack in
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
    }
    
    //cell에 넣을 모델을 만들어주는 과정 
    func makeCellModels() {
//        self.socketManager("community_init", "자동차 사고")
//        self.socketManager("community_init", "범퍼")
//        self.socketManager("community_init", "와이퍼")
        
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
