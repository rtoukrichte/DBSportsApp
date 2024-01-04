//
//  ServiceManager.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

enum NetworkError: Error {
    case noConnectionInternet
    case serverError
    case badURL
    case parsingDataError
    case unknownError
}

final class ServiceManager {
    
    // MARK: - singleton instance
    static let shared = ServiceManager()
    
    private init() {}
    
    // MARK: - Load All Leagues From DBSport APIs
    func loadLeagues(completionHandler:@escaping (Result<LeaguesModel, NetworkError>) -> Void) {
        
        guard let leaguesURL = URL(string: Constants.allLeaguesURL) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        if Reachability.isConnectedToNetwork() {
            URLSession.shared.dataTask(with: leaguesURL) { (data, response, error) in
                
                guard let data = data else {
                    return
                }
                do {
                    let leaguesData = try JSONDecoder().decode(LeaguesModel.self, from: data)
                    completionHandler(.success(leaguesData))
                    
                } catch (let decodingError) {
                    debugPrint(decodingError)
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 500 {
                            completionHandler(.failure(.serverError))
                        }
                    }
                    completionHandler(.failure(.unknownError))
                }
            }.resume()
        }
        else {
            completionHandler(.failure(.noConnectionInternet))
        }
    }
    
    
    // MARK: - Load Teams of League From DBSport APIs
    func loadTeams(_ leagueName: String, completionHandler:@escaping (Result<TeamsModel, NetworkError>) -> ()) {
        
        let paramsUrl = String(format: "?l=%@", leagueName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
        
        guard let teamsURL = URL(string: Constants.teamsLeagueURL + paramsUrl) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        if Reachability.isConnectedToNetwork() {
            URLSession.shared.dataTask(with: teamsURL) { (data, response, error) in
                
                guard let data = data else { return }
                do {
                    
                    let teamsData = try JSONDecoder().decode(TeamsModel.self, from: data)                    
                    completionHandler(.success(teamsData))
                    
                } catch (let decodingError) {
                    debugPrint(decodingError)
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 500 {
                            completionHandler(.failure(.serverError)) // 500..<600
                        }
                    }
                    completionHandler(.failure(.unknownError))
                }
            }.resume()
        }
        else {
            completionHandler(.failure(.noConnectionInternet))
        }
    }
}
