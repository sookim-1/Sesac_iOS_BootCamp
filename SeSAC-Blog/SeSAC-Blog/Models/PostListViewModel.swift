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
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostListVC())
                windowScene.windows.first?.makeKeyAndVisible()
            }
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }

}
