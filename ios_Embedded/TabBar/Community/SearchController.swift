//
//  SearchController.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/09.
//

import UIKit

class SearchController: UISearchController{
    
    var socket = SocketIOManager.shared
    private var filteredResults = [Result]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.autocapitalizationType = .none
    }
    
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //여기서 소켓으로 보냈다가 받아야 함
        socket.sendMessage(socketMessage: "search", message: searchText)
        
        socket.socket.on("searchText"){jsonObject, ack in
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
        //self.displayCommunityList(cellModels: cellModels)
    }

    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
}
// MARK: - UISearchResultsUpdating Delegate
extension SearchController: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
      }

}
