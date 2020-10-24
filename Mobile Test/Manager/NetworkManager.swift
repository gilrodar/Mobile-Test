//
//  NetworkManager.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUsers(page: Int, completion: @escaping (Result<UserResponse, UserError>) -> ()) {
        guard let url = URL(string: "https://randomuser.me/api/?page=\(page)&results=50") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let users = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.serializationError))
            }
        }.resume()
    }
    
}
