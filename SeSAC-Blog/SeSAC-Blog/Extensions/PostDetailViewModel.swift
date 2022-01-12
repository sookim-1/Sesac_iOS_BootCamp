//
//  PostDetailViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

class PostDetailViewModel {
    func getCommentData(id: Int, completion:  @escaping (Result<[ResponseComment], NetworkError>) -> Void) {
        var components = URLComponents(string: SeSacAPI.getComment.path)!
        components.queryItems = [
            URLQueryItem(name: "post", value: "\(id)")
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }
}
