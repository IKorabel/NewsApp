//
//  NewsManager.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import UIKit
import FeedKit

class NewsManager {
    static let shared = NewsManager()
    private let feedURL = URL(string: "https://news.google.com/rss?pz=1&cf=all&hl=en-US&topic=n&gl=US&ceid=US:en")!
    var delegate: NewsManagerDelegate? = nil
    
    func getTheNews() {
        let parser = FeedParser(URL: feedURL)
        var articles = [Article]()
        //articles.loadFromCoreData()
        parser.parseAsync { [self] result in
            switch result {
            case .success(let news):
                articles = news.rssFeed?.items?.convertToArticleArray() ?? []
                let sortedArticles = articles.sortTheArrayInDescendingOrder()
                sortedArticles.saveToCoreData()
                delegate?.didGetNewsWithSuccess(articles: sortedArticles)
            case .failure(let error):
                delegate?.didGetNewsWithError(errorDescription: error.localizedDescription, cachedArticles: articles)
            }
        }
    }
}

protocol NewsManagerDelegate {
    func didGetNewsWithSuccess(articles: [Article])
    func didGetNewsWithError(errorDescription: String,cachedArticles: [Article]?)
}
