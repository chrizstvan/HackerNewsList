//
//  StoryDetailViewModel.swift
//  HackerNewsList
//
//  Created by Chris Stev on 17/10/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import Combine

// this is not necessary needed because we have combined & merge api call: (WebService line 35)
class StoryDetailViewModel: ObservableObject {
    var storyId: Int
    private var cancelable: AnyCancellable?
    
    @Published private var story: Story!
    
    init(storyId: Int) {
        self.storyId = storyId
        
        self.cancelable = WebService().getStroryById(id: self.storyId)
            .catch { _ in Just(Story.placeholder())}
            .sink(receiveCompletion: { _ in }, receiveValue: { story in
                self.story = story
            })
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
