//
//  Picture.swift
//  images
//
//  Created by osa on 21.09.2021.
//

struct Picture: Decodable, Hashable {
    let id: String
    let author: String
    let url: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, url
        case downloadUrl = "download_url"
    }
}


