//
//  ImagesViewModel.swift
//  images
//
//  Created by osa on 22.09.2021.
//

import Foundation

protocol ImagesViewModelProtocol {
    var pictures: [Picture: Data] { get }
    var page: Observable<Int> { get }
    
    func getPictures(completion: @escaping () -> Void)
    func detailViewModelInit(indexPath: IndexPath) -> DetailViewModelProtocol
}

class ImagesViewModel: ImagesViewModelProtocol {
    
    var page: Observable<Int> = Observable(2)
    
    var pictures: [Picture: Data] = [:]
    
    func getPictures(completion: @escaping () -> Void) {
            NetworkService.shared.fetchPictures(url: "?page=\(page.value)&limit=10",
                                                completion: { result in
                switch result {
                case .success(let data):
                    data.forEach { picture in
                        
                        StorageService.shared.fetchImage(from: picture.downloadUrl) { data, error in
                            guard let imageData = data else { return }
                            DispatchQueue.main.async { [unowned self] in
                                pictures[picture] = imageData
                                completion()
                            }
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
    
    func detailViewModelInit(indexPath: IndexPath) -> DetailViewModelProtocol {
        let keysArray = Array(pictures.keys)
        let valuesArray = Array(pictures.values)
        let currentKey = keysArray[indexPath.row]
        let currentValue = valuesArray[indexPath.row]
        return DetailViewModel(picture: currentKey, image: currentValue)
    }
    
}
