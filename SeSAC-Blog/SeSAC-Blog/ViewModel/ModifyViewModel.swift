//
//  ModifyViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/13.
//

import Foundation

class ModifyViewModel {

    func modifyPostData(id: Int, model: ModifyPostModel, completion:  @escaping (Result<ResponsePost, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.updatePost(postId: id).url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }

    func modifyCommentData(id: Int, model: ModifyCommentModel, completion:  @escaping (Result<ResponseComment, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.updateComment(commentId: id).url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }
}
