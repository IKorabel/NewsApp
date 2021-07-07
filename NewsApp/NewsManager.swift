//
//  NewsManager.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import UIKit
import FeedKit
import Alamofire
import AlamofireRSSParser

class NewsManager {
    static let shared = NewsManager()
    
    let defaultNewsURL = "https://news.google.com/rss?pz=1&cf=all&hl=en-US&topic=n&gl=US&ceid=US:en"
    
    func getTheNewsViaAlamofire(completion: @escaping ([Article]?) -> Void) {
        
        var translatedNewsURL = URL(string: defaultNewsURL)! // Default Link
        
        do {
          translatedNewsURL = try NSLocalizedString("localizedNewsURL", comment: "articlesLanguage").asURL()
        } catch {
          print(error.localizedDescription)
        }
        
        var articles = [Article]()
        
        guard Connectivity.isConnectedToInternet else {
            print("Is not connected")
            articles.loadFromCoreData()
            completion(articles)
            return
        }
        
        AF.request(translatedNewsURL).responseRSS { response in
            guard let news = response.value?.items else { return }
            let newsItems = news.convertToArticleArray()
            newsItems.saveToCoreData()
            completion(newsItems)
        }
    }
}
