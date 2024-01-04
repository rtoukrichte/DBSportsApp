//
//  LeaguesViewModel.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 03/01/2024.
//

import Foundation

class LeaguesViewModel: NSObject {
    
    private var serviceManager = ServiceManager.shared
    
    var leaguesNames: ObservableBox<[String]> = ObservableBox([])
    var errorType   : ObservableBox<NetworkError>?
    
    override init() {
        super.init()
        self.getAllLeagues()
    }
    
    func getAllLeagues() {
        var filterItems = [String]()
        
        serviceManager.loadLeagues { [weak self] result in
            switch result {
            case .success(let leaguesModel):
    
                for league in leaguesModel.leagues {
                    filterItems.append(league.strLeague ?? "")
                }
                
                self?.leaguesNames.value = filterItems
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.errorType?.value = error
            }
        }
    }
}
