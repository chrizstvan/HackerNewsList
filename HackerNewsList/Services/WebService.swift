//
//  WebService.swift
//  HackerNewsList
//
//  Created by Chris Stev on 06/10/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import Combine

class WebService {
    
    func fetchDataWithCombine() -> AnyPublisher<[Int], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            fatalError("invalid URL")
            
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    func getStroryById(id: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") else {
            fatalError("invalid id")
            
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .catch { _ in Empty<Story, Error>() }
            .eraseToAnyPublisher()
    }
}
