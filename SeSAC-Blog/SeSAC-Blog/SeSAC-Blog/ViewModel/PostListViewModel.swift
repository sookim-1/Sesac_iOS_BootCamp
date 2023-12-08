//
//  PostListViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation
import UIKit

class PostListViewModel {
    var isPaginating = false
    var postCount = 0

    func getEntirePostCount(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        guard let url = URL(string: SeSacAPI.getPost.path + "/count") else { return }
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }

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

    func getPostPageData(pagination: Bool = false, start: Int = 0, completion:  @escaping (Result<[ResponsePost], NetworkError>) -> Void) {

        if pagination {
            isPaginating = true
        }
        var component = URLComponents(string: SeSacAPI.getPost.path)
        component?.queryItems = [
            URLQueryItem(name: "_start", value: "\(start)"),
            URLQueryItem(name: "_limit", value: "150"),
            URLQueryItem(name: "_sort", value: "created_at:asc")
        ]

        var request = URLRequest(url: (component?.url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {

            URLSession.request(endpoint: request, completion: completion)
        }

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
