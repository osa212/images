//
//  StorageService.swift
//  images
//
//  Created by osa on 22.09.2021.
//

import UIKit

class StorageService {
    
    static let shared = StorageService()
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let imageUrl = URL(string: url) else {
            completion(nil, nil)
            return
        }

        if let cachedImage = getCachedImage(from: imageUrl) {
            completion(cachedImage, nil)
        }
        
        NetworkService.shared.fetchImage(from: imageUrl) { data, response in
            self.saveDataToCash(data: data, response: response)
            completion(data, nil)
        }
        
    }
    
    private func saveDataToCash(data: Data, response: URLResponse) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        guard let url = response.url else {return}
        let request = URLRequest(url: url)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
}
