//
//  NewsFeedTableViewCell.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 06.07.2021.
//

import Foundation
import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var articleTitleTextView: UITextView!
    @IBOutlet weak var articlePublicationDateLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!
    var link: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        articleTitleTextView.isSelectable = false
    }
    
    func setArticle(article: Article) {
        articleTitleTextView.text = article.title
        articlePublicationDateLabel.text = article.pubDate.convertToString()
        articleSourceLabel.text = article.source
        link = article.link
    }
    
}
