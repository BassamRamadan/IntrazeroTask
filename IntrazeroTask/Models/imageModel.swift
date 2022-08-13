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
    let photo: Data?
    enum CodingKeys: String, CodingKey {
        case id, author, photo
        case downloadURL = "download_url"
    }
}
