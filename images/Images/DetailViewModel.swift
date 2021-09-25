//
//  DetailViewModel.swift
//  images
//
//  Created by osa on 22.09.2021.
//

import Foundation

protocol DetailViewModelProtocol {
    var picture: Picture { get }
    var image: Data { get }
    
    init(picture: Picture, image: Data)
}

class DetailViewModel: DetailViewModelProtocol {
    
    var picture: Picture
    
    var image: Data
    
    required init(picture: Picture, image: Data) {
        self.picture = picture
        self.image = image
    }
    
}
