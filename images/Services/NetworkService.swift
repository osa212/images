//
//  NetworkService.swift
//  images
//
//  Created by osa on 21.09.2021.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let accessKey = "563492ad6f917000010000019319e05ba1f24769b869274166c1a138"
    
    func fetchPictures(url: String, completion: @escaping (Result<[Picture], Error>) -> Void) {
        guard let url = URL.with(string: url) else { return }
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue(accessKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            if let data = data {
                do {
                    let pictures = try JSONDecoder().decode([Picture].self, from: data)
                    completion(.success(pictures))
                } catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
            URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print("can't get data and response")
                return
                }
            //guard url == response.url else {return}
            completion(data, response)
                
            }.resume()
        }
    
    private init() {}
}
