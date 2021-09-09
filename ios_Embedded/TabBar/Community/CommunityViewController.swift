//
//  CommunityViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit
import RxSwift
import RxCocoa

struct Result: Codable {
    var title: String?
    var question: String?
    var answer: [String]?
}

class CommunityViewController: UIViewController{
    
    //MARK: - Properties
    private let pageView: CommunityView = .init()
    
    var socket = SocketIOManager.shared
    

    private var results: [Result]? = []

    var dic: Dictionary<String,Any> = [:]
    
    internal var searchResults: [Result]? = []

    
    private let disposeBag: DisposeBag = .init()
    
    let searchController = SearchController()
    private var filteredResults = [Result]()
    
    //MARK: - LifeCycle 
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeCellModels()
        self.pageChange()
        self.searchConf()
        
    }
    
    //MARK: - searchConf
    func searchConf(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: - Socket 통신
    func socketManager(_ socketMessage: String, _ message: String){
        socket.sendMessage(socketMessage: socketMessage, message: message)
        socket.socket.on(socketMessage) {jsonObject, ack in
            for i in jsonObject{
                if let array = i as? NSMutableArray{
                    for a in array{
                        do{
                            let data = try JSONSerialization.data(withJSONObject: a, options: .prettyPrinted)
                            let r = try JSONDecoder().decode(Result.self, from: data)
                            self.searchResults?.append(r)
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Make Cell 
    func makeCellModels() {
        let cellModels: [CommnuityListCellModel] = searchResults?.compactMap {
            guard let title = $0.title else { return nil }
            guard let answer = $0.answer else { return nil }
            return .init(title: title,
                         answer: answer)
        } ?? []
        self.displayCommunityList(cellModels: cellModels)
    }
    
    func displayCommunityList(cellModels: [CommnuityListCellModel]) {
        self.pageView.displayTableView(cellModels: cellModels)
    }
    
    //MARK: - Page Change
    func pageChange() {
        self.pageView.communityCellTapEvent
            .subscribe(onNext: { index in
                //배열 정보를 넘겨야 함
              let page = CommunityDetailViewController()
                self.navigationController?.pushViewController(page, animated: true)
                page.requestCommunityDetail(searchResults: self.searchResults!, index: index)
            }).disposed(by: disposeBag)
    }
    
    //MARK - searchBar..
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //여기서 소켓으로 보냈다가 받아야 함
        socket.sendMessage(socketMessage: "search_text", message: searchText)
        
        socket.socket.on("search_text"){jsonObject, ack in
            for i in jsonObject{
                if let array = i as? NSMutableArray{
                    for a in array{
                        do{
                            let data = try JSONSerialization.data(withJSONObject: a, options: .prettyPrinted)
                            let r = try JSONDecoder().decode(Result.self, from: data)
                            
                            self.filteredResults.append(r)
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        
        //데이터 리로드 해주기...
        //tableView.reloadData()
        let cellModels: [CommnuityListCellModel] = filteredResults.compactMap {
            guard let title = $0.title else { return nil }
            return .init(title: title)
        }
       self.displayCommunityList(cellModels: cellModels)
    }

    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension CommunityViewController: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
      }

}
