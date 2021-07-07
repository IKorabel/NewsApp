//
//  Article.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import Foundation

struct Article: Codable {
    var title: String
    var pubDate: Date
    var link: String
    var source: String
}

extension Array where Element == Article {
    
    func saveToCoreData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(self)
            defaults.set(encoded, forKey: "SavedArticles")
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    mutating func sortTheArrayInDescendingOrder() -> [Article] {
        let sortedArray = self.sorted(by: {$0.pubDate > $1.pubDate })
        return sortedArray
    }
    
    mutating func loadFromCoreData() {
        let defaults = UserDefaults.standard
        guard let savedNews = defaults.object(forKey: "SavedArticles") as? Data else { return }
        let decoder = JSONDecoder()
        do {
            let loadedNews = try decoder.decode([Article].self, from: savedNews)
            self = loadedNews
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
