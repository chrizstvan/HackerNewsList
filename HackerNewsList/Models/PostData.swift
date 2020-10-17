//
//  PostData.swift
//  HackerNewsList
//
//  Created by My Mac on 26/08/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

// combine implementation
struct Story: Codable {
    let id: Int
    let title: String
    let url: String
}

extension Story {
    static func placeholder() -> Story {
        Story(id: 0, title: "N/A", url: "")
    }
}


