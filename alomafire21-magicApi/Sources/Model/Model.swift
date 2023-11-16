//
//  Model.swift
//  alomafire21-magicApi
//
//  Created by 1234 on 11.10.2023.
//

import Foundation

public struct Cards: Decodable {
    var cards: [Model]
    
    enum CodingKeys: String, CodingKey {
        case cards
    }
}

public struct Model: Decodable {
    let name: String?
    let manaCost: String?
    let type: String?
    let setName: String?
    let artist: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case manaCost
        case type
        case setName
        case artist
        case imageUrl
    }
}
