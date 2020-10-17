//
//  StoryDetailView.swift
//  HackerNewsList
//
//  Created by Chris Stev on 06/10/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import SwiftUI

struct StoryDetailView: View {
    //@ObservedObject private var storyDetailVM: StoryDetailViewModel
    let url: String
    
//    init(storyId: Int) {
//        //self.storyDetailVM = StoryDetailViewModel(storyId: storyId)
//    }
    
    var body: some View {
        //Text(storyDetailVM.title)
        WebView(urlString: url)
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(url: "")
    }
}
