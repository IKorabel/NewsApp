//
//  RSSFeedItem.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import Foundation
import AlamofireRSSParser

extension RSSItem {
    
    func convertToArticle() -> Article {
        return Article(title: title ?? "", pubDate: pubDate!, link: link ?? "Link isn't available",source: source ?? "")
    }
}

extension Array where Element == RSSItem {
    
    func convertToArticleArray() -> [Article] {
        return map({$0.convertToArticle()})
    }
    
}
