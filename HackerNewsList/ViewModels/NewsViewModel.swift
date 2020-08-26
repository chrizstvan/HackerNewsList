//
//  NetworkManager.swift
//  HackerNewsList
//
//  Created by My Mac on 26/08/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation

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
}
