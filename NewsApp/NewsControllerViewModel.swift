//
//  NewsControllerViewModel.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 06.07.2021.
//

import Foundation
import UIKit
import RxSwift
import SafariServices

class NewsControllerViewModel {
    public var articles: PublishSubject<[Article]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    static let shared = NewsControllerViewModel()
    
    func getTheNews() {
        self.loading.onNext(true)
        NewsManager.shared.getTheNewsViaAlamofire() { [self] articles in
            self.loading.onNext(false)
            guard var downloadedArticles = articles else {
            print("Не удалось получить статьи")
            return
            }
            self.articles.onNext(downloadedArticles.sortTheArrayInDescendingOrder())
        }
    }
    
//    
    func openWebsiteWithArticle(vc: UIViewController, link: String) {
        guard let sourceURL = URL(string: link) else { return }
        let safariVC = SFSafariViewController(url: sourceURL)
        vc.present(safariVC, animated: true, completion: nil)
    }
    
}
