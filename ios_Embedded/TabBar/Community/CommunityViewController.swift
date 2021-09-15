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

class CommunityViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: CommunityView = .init()
    
    var socket = SocketIOManager.shared
    
    internal var searchResults: [Result] = []
    internal var carAccidentResults: [Result] = []
    internal var bumperResults: [Result] = []
    internal var wiperResults: [Result] = []
    internal var mirrorResults: [Result] = []

    let searchController = UISearchController(searchResultsController: nil)
    
    private let disposeBag: DisposeBag = .init()
    
    internal var filteredResults = [Result]()
    var searchPoint = 0
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeCellModels()
        self.pageChange()
        self.searchBarConf()
        
        print(searchResults?.count)
        print(carAccidentResults?.count)
        print(bumperResults?.count)
        print(wiperResults?.count)
        print(mirrorResults?.count)
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
                            //배열에 넣기
                            if message == "자동차 사고" {
                                self.carAccidentResults.append(r)
                            }
                            else if message == "범퍼" {
                                self.bumperResults.append(r)
                            }
                            else if message == "와이퍼" {
                                self.wiperResults.append(r)
                            }
                            else if message == "미러" {
                                self.mirrorResults.append(r)
                            }
                            
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
        searchResults = self.carAccidentResults + self.bumperResults + self.wiperResults + self.mirrorResults
        let cellModels: [CommnuityListCellModel] = searchResults.compactMap {
            guard let title = $0.title else { return nil }
            guard let question = $0.question else { return nil }
            return .init(title: title,
                         question: question)
        }
        self.displayCommunityList(cellModels: cellModels)
    }
    
    func makeFilterCellModels() {
        let cellModels: [CommnuityListCellModel] = filteredResults.compactMap {
            guard let title = $0.title else { return nil }
            guard let question = $0.question else { return nil }
            return .init(title: title,
                         question: question)
        }
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
                if self.filteredResults.isEmpty { //검색어 필터 적용된 리스트 비어있는지 확인
                    page.requestCommunityDetail(searchResults: self.searchResults, index: index)
                }else {
                page.requestCommunityDetail(searchResults: self.filteredResults, index: index)
                }
            }).disposed(by: disposeBag)
    }
    
    //MARK: - searchConf
    func searchBarConf(){

        self.navigationItem.searchController = searchController
        self.navigationItem.title = "커뮤니티"
        self.navigationItem.hidesSearchBarWhenScrolling = true
    
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "검색"

        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self

        
        //ScopeBar
        searchController.searchBar.scopeButtonTitles = [ "자동차 사고", "범퍼", "와이퍼", "미러" ]
        searchController.searchBar.showsScopeBar = true
    }
    
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredResults = searchResults.filter({( result : Result) -> Bool in
            return result.title!.lowercased().contains(searchText.lowercased())
      })
        self.makeFilterCellModels()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension CommunityViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPoint += 1
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
}
