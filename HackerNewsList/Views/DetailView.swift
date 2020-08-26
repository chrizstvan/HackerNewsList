//
//  DetailView.swift
//  HackerNewsList
//
//  Created by My Mac on 26/08/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(url: "https://www.google.com")
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("Pro Max 11")
            
            DetailView(url: "https://www.google.com")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
        }
    }
}


