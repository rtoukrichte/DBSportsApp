//
//  TeamsViewModel.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

class TeamsViewModel: NSObject {
    
    private var serviceManager = ServiceManager.shared
    
    var teamsBadge: ObservableBox<[String]> = ObservableBox([])
    var errorType : ObservableBox<NetworkError>?
    
    override init() {
        super.init()
    }
    
    func getTeamsByLeague(_ leagueName: String) {
        var badgeLinks = [String]()
        
        serviceManager.loadTeams(leagueName) { [weak self] result in
            switch result {
            case .success(let teamsModel):
                let sortedTeams = teamsModel.teams.sorted { $0.strTeam ?? "" > $1.strTeam ?? "" }
                
                for team in sortedTeams {
                    badgeLinks.append(team.strTeamBadge ?? "")
                }
                
                self?.teamsBadge.value = badgeLinks
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.errorType?.value = error
            }
        }
    }
}
