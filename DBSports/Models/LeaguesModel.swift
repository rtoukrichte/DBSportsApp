//
//  LeaguesModel.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

// MARK: - Leagues
struct LeaguesModel: Codable {
    let leagues: [League]
}

// MARK: - League
struct League: Codable {
    let idLeague: String?
    let strLeague: String?
    let strSport: String?
    let strLeagueAlternate: String?
}
