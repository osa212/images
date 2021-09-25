//
//  URL + extension.swift
//  images
//
//  Created by osa on 21.09.2021.
//

import Foundation

extension URL {
    private static var baseUrl: String {
        return "https://picsum.photos/v2/list"
    }
    
    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)")
    }
}
