//
//  ContentView.swift
//  HackerNewsList
//
//  Created by My Mac on 26/08/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var newsVM = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(newsVM.stories, id: \.id) { story in
                NavigationLink(destination: StoryDetailView(url: story.url)) {
                    HStack {
                        Text(String(story.title))
                        //Text(String(story.id))
                    }
                    
                }
            }
        .navigationBarTitle("Hacker News")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("Pro Max 11")
            
            ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
        }
        
    }
}




