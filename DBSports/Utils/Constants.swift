//
//  Constants.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

struct Constants {
    struct APIKey {
        static let DBSportAPIKey = "50130162"
    }
    
    static let domaineName = "https://www.thesportsdb.com"
    static let path = "/api/v1/json/"
    
    static let baseURL = domaineName + path + APIKey.DBSportAPIKey
    static let allLeaguesURL = baseURL + "/all_leagues.php"
    static let teamsLeagueURL = baseURL + "/search_all_teams.php"
        
}
