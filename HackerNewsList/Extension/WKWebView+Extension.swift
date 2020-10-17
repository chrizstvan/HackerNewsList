//
//  WKWebView+Extension.swift
//  HackerNewsList
//
//  Created by Chris Stev on 17/10/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    static func pageNotFoundView() -> WKWebView {
        let wk = WKWebView()
        wk.loadHTMLString("<html><body><h1>Page not found!</h1></body></html>", baseURL: nil)
        return wk
    }
}
