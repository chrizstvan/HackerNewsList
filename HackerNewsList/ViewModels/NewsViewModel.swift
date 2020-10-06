//
//  NetworkManager.swift
//  HackerNewsList
//
//  Created by My Mac on 26/08/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        guard let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let decoder = JSONDecoder()
            if let safeData = data {
                do {
                    let results = try decoder.decode(Results.self, from: safeData)
                    DispatchQueue.main.async {
                        self.posts = results.hits
                    }
                } catch {
                    print(error)
                }
                
            }
            
        }
        task.resume()
    }
    
    // combine prop
    @Published var stories = [StoryViewModel]()
    private var cancelable: AnyCancellable?
    
    init() {
        fetchTopStories()
    }
    
    func fetchTopStories() {
        self.cancelable = WebService().fetchDataWithCombine().map { storyIds in
            storyIds.map { StoryViewModel(id: $0)}
        }
        .sink(receiveCompletion: { _ in }) { (storyVM) in
            self.stories = storyVM
        }
    }
}

// with combine implementation
struct StoryViewModel {
    let id: Int
}

class StoryDetailViewModel: ObservableObject {
    var storyId: Int
    private var cancelable: AnyCancellable?
    
    @Published private var story: Story!
    
    init(storyId: Int) {
        self.storyId = storyId
        
        WebService().getStroryById(id: storyId)
            .sink(receiveCompletion: { _ in }) { (story) in
                self.story = story
        }
    }
}

extension StoryDetailViewModel {
    var title: String {
        self.story.title
    }
    
    var url: String {
        self.story.url
    }
}
