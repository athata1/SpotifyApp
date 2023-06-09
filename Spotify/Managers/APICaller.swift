//
//  APICaller.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {
        
    }
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func fetchData<T: Decodable>(from url: URL?, responseType: T.Type, requestType: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        
        createRequest(with: url, type: requestType) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    if (responseType == String.self) {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                    }
                    
                    let result = try JSONDecoder().decode(responseType, from: data)
                    /*if (responseType == SearchResultResponse.self) {
                        print(result)
                    }*/
                    completion(.success(result))
                } catch {
                    print("\(T.self): \(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        let url: URL? = URL(string: "\(Constants.baseAPIURL)/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&type=album,artist,playlist,track&limit=10")
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap({SearchResult.track(model: $0)}))
                    searchResults.append(contentsOf: result.albums.items.compactMap({SearchResult.album(model: $0)}))
                    searchResults.append(contentsOf: result.artists.items.compactMap({SearchResult.artist(model: $0)}))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({SearchResult.playlist(model: $0)}))
                    completion(.success(searchResults))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        
    }
    
    
    
    // MARK: Search Query
    
    public func getCategories(completion: @escaping ((Result<AllCategoriesResponse, Error>) -> Void)) {
        let url: URL? = URL(string:"\(Constants.baseAPIURL)/browse/categories")
        fetchData(from: url, responseType: AllCategoriesResponse.self, requestType: .GET, completion: completion)
    }
    
    public func getCategoryPlaylists(category: Category, completion: @escaping ((Result<CategoryPlaylistResponse, Error>) -> Void)) {
        let url: URL? = URL(string: "\(Constants.baseAPIURL)/browse/categories/\(category.id)/playlists?limit=50")
        fetchData(from: url, responseType: CategoryPlaylistResponse.self, requestType: .GET, completion: completion)
    }
    
    // MARK: Album
    public func getAlbumDetails(for album: Album, completion: @escaping ((Result<AlbumDetailsResponse, Error>) -> Void)) {
        let url: URL? = URL(string: "\(Constants.baseAPIURL)/albums/\(album.id)")
        fetchData(from: url, responseType: AlbumDetailsResponse.self,requestType: .GET, completion: completion)
    }
    
    // MARK: Playlists
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping ((Result<PlaylistDetailsResponse, Error>) -> Void)) {
        /*createRequest(with: URL(string: "\(Constants.baseAPIURL)/playlists/\(playlist.id)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in

                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                    
                }
                catch {
                    print("Playlist Details: \(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }*/
        let url = URL(string: "\(Constants.baseAPIURL)/playlists/\(playlist.id)")
        self.fetchData(from: url, responseType: PlaylistDetailsResponse.self,requestType: .GET, completion: completion)
    }
    
    // MARK: Browse
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>)) -> Void) {
        createRequest(with:
                        URL(string: "\(Constants.baseAPIURL)/recommendations/available-genre-seeds"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in

                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                    
                }
                catch {
                    print("Genre Recommendations: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with:
                        URL(string: "\(Constants.baseAPIURL)/recommendations?seed_genres=\(seeds)&limit=40"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                    
                }
                catch {
                    print("Recommendations: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>)) -> Void) {
        createRequest(with:
                        URL(string: "\(Constants.baseAPIURL)/browse/featured-playlists?limit=40"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in

                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                    
                }
                catch {
                    print("FeaturedPlaylist: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with:
                        URL(string: "\(Constants.baseAPIURL)/browse/new-releases?limit=40"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                    
                }
                catch {
                    print("New Releases: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("User Profile: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken() { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
