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
    
    func fetchDataWithCombine() -> AnyPublisher<[Story], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            fatalError("invalid URL")
            
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap({ storyIds in
                self.mergeStories(ids: storyIds)
            })
            .scan([]) { (stories, story) -> [Story] in
                stories + [story]
            }
            .eraseToAnyPublisher()
        
    }
    
    /// THIS IS IMPORTANT PART TO MERGE !!!
    private func mergeStories(ids storyIds: [Int]) -> AnyPublisher<Story, Error> {
        let storyIds = Array(storyIds.prefix(50))
        
        let initalPublisher = getStroryById(id: storyIds[0])
        let reminder = Array(storyIds.dropFirst())
        
        return reminder.reduce(initalPublisher) { (combined, id) in
            return combined.merge(with: getStroryById(id: id))
            .eraseToAnyPublisher()
        }
    }
    
    func getStroryById(id: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") else {
            fatalError("invalid URL")
            
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
