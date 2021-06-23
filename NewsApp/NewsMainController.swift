//
//  ViewController.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import UIKit
import FeedKit
import SafariServices

class NewsMainController: UITableViewController {
    
    var articles = [Article]()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsManager.shared.delegate = self
        updateUI()
        getTheNews()
    }
    
    func updateUI() {
        tableView.backgroundView = activityIndicator
    }
    
    func getTheNews() {
        activityIndicator.startAnimating()
        NewsManager.shared.getTheNews()
    }
    
    func openWebsiteWithArticle(indexOfArticle: Int) {
        let articleSourceLink = articles[indexOfArticle].link
        guard let sourceURL = URL(string: articleSourceLink) else { return }
        let safariVC = SFSafariViewController(url: sourceURL)
        present(safariVC, animated: true, completion: nil)
    }
    
    func updateData() {
        DispatchQueue.main.async {
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
        }
    }
}

extension NewsMainController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openWebsiteWithArticle(indexOfArticle: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsFeedTableViewCell else { return UITableViewCell() }
        cell.setArticle(article: articles[indexPath.row])
        return cell
    }
    
    @objc private func refreshTableView(sender: UIRefreshControl) {
        getTheNews()
        sender.endRefreshing()
    }
    
}

extension NewsMainController: NewsManagerDelegate {
    
    func didGetNewsWithSuccess(articles: [Article]) {
        print("success")
        self.articles = articles
        updateData()
    }
    
    func didGetNewsWithError(errorDescription: String, cachedArticles: [Article]?) {
        print("Error: \(errorDescription)")
        guard let cachedArticles = cachedArticles else {
        print("Cache is empty")
        return
        }
        self.articles = cachedArticles
        updateData()
    }
}


class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var articleTitleTextView: UITextView!
    @IBOutlet weak var articlePublicationDateLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        articleTitleTextView.isSelectable = false
    }
    
    func setArticle(article: Article) {
        articleTitleTextView.text = article.title
        articlePublicationDateLabel.text = article.pubDate.convertToString()
        articleSourceLabel.text = article.source
    }
    
}
