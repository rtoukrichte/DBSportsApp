//
//  TeamsModel.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

// MARK: - Teams
struct TeamsModel: Codable {
    let teams: [Team]
}

// MARK: - Team
struct Team: Codable {
    let idTeam                : String?
    let idSoccerXML           : String?
    let idAPIfootball         : String?
    let intLoved              : String?
    let strTeam               : String?
    let strTeamShort          : String?
    let strAlternate          : String?
    let intFormedYear         : String?
    let strSport              : String?
    let strLeague             : String?
    let idLeague              : String?
    let strLeague2            : String?
    let idLeague2             : String?
    let strLeague3            : String?
    let idLeague3             : String?
    let strLeague4            : String?
    let idLeague4             : String?
    let strLeague5            : String?
    let idLeague5             : String?
    let strLeague6            : String?
    let idLeague6             : String?
    let strLeague7            : String?
    let idLeague7             : String?
    let strDivision           : String?
    let strStadium            : String?
    let strKeywords           : String?
    let strRSS                : String?
    let strStadiumThumb       : String?
    let strStadiumDescription : String?
    let strStadiumLocation    : String?
    let intStadiumCapacity    : String?
    let strWebsite            : String?
    let strFacebook           : String?
    let strTwitter            : String?
    let strInstagram          : String?
    let strDescriptionEN      : String?
    let strDescriptionDE      : String?
    let strDescriptionFR      : String?
    let strDescriptionCN      : String?
    let strDescriptionIT      : String?
    let strDescriptionJP      : String?
    let strDescriptionRU      : String?
    let strDescriptionES      : String?
    let strDescriptionPT      : String?
    let strDescriptionSE      : String?
    let strDescriptionNL      : String?
    let strDescriptionHU      : String?
    let strDescriptionNO      : String?
    let strDescriptionIL      : String?
    let strDescriptionPL      : String?
    let strKitColour1         : String?
    let strKitColour2         : String?
    let strKitColour3         : String?
    let strGender             : String?
    let strCountry            : String?
    let strTeamBadge          : String?
    let strTeamJersey         : String?
    let strTeamLogo           : String?
    let strTeamFanart1        : String?
    let strTeamFanart2        : String?
    let strTeamFanart3        : String?
    let strTeamFanart4        : String?
    let strTeamBanner         : String?
    let strYoutube            : String?
    let strLocked             : String?
}
