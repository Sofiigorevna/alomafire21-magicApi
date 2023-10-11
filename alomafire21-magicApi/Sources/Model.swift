//
//  Model.swift
//  alomafire21-magicApi
//
//  Created by 1234 on 11.10.2023.
//

import Foundation
public struct Cards: Decodable {
    var cards: [Model]
}

public struct Model: Decodable {
    let name: String
    let manaCost: String?
    let type: String
    let setName: String
    let artist: String
}
