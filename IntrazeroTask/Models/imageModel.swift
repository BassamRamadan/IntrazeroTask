//
//  imageModel.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/11/22.
//

import Foundation

struct imageModel: Codable {
    let id, author: String?
    let downloadURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author
        case downloadURL = "download_url"
    }
}
