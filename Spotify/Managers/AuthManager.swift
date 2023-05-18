//
//  AuthManager.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private var refreshingToken = false
    struct Constants {
        static let clientID: String = "34ce4c4ccbe44b53b5c6e9b2830c4a5b"
        static let clientSecret: String = Bundle.main.infoDictionary?["API_SECRET"] as? String ?? ""
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.google.com"
        static let scopes = "user-read-email%20user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read"
    }
    
    private init() {
        
    }
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code" +
        "&client_id=\(Constants.clientID)" +
        "&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)" +
        "&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return self.accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        return currentDate.addingTimeInterval(TimeInterval(300)) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        _ code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        //Get token
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)

                self?.cacheToken(result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [(String) -> Void]()
    
    //Supplies valid token for the API Caller
    public func withValidToken(completion: @escaping (String) -> Void) {
        
        guard !refreshingToken else {
            // Append completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshAccessToken() { success in
                if (success) {
                    if let token = self.accessToken {
                        completion(token)
                    }
                }
            }
        }
        else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshAccessToken(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        //Refresh token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion?(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            self?.refreshingToken = false
            
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                    
                self?.onRefreshBlocks.forEach {$0(result.access_token)}
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result)
                completion?(true)
            }
            catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(_ result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
