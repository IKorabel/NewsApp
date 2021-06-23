//
//  RSSFeedItem.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import Foundation
import FeedKit

extension RSSFeedItem {
    
    func convertToArticle() -> Article {
        return Article(title: title ?? "", pubDate: pubDate!, link: link ?? "Link isn't available",source: source?.value ?? "")
    }
}

extension Array where Element == RSSFeedItem {
    
    func convertToArticleArray() -> [Article] {
        return map({$0.convertToArticle()})
    }
    
}
