//
//  PostListViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation
import UIKit

class PostListViewModel {

    func getPostData(completion:  @escaping (Result<[ResponsePost], NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.getPost.url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }

    func deletePostData(id: Int, completion:  @escaping (Result<ResponsePost, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.deletePost(postId: id).url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }
}
