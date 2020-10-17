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
        self.cancelable = WebService().fetchDataWithCombine().map { stories in
            stories.map { StoryViewModel(story: $0)}
        }
        .sink(receiveCompletion: { _ in }) { (storyVM) in
            self.stories = storyVM
            print(storyVM)
        }
    }
}

// with combine implementation same with news view model in the prev version
struct StoryViewModel {
    //let id: Int -> comment out after combined API
    
    // after combine merge api create this story
    let story: Story
    
    var id: Int {
        return self.story.id
    }
    
    var title: String {
        self.story.title
    }
    
    var url: String {
        self.story.url
    }
}
