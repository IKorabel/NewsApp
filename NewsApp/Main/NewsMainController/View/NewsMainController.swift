//
//  ViewController.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 22.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class NewsMainController: UITableViewController {
    @IBOutlet weak var changeLanguageBarButton: UIBarButtonItem!
    
    private let viewModel = NewsControllerViewModel.shared
    private let disposeBag = DisposeBag()
    public var articles = PublishSubject<[Article]>()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        setTableViewSettings()
        activateInteractionsWithUI()
        bindTableData()
        bindArticles()
    }
    
    func setTableViewSettings() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.backgroundView = activityIndicator
    }
    
    func bindTableData() {
        
        articles.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: NewsFeedTableViewCell.self)) {  (row,article,cell) in
            cell.setArticle(article: article)
        }.disposed(by: disposeBag)
        
    }
    
    func activateInteractionsWithUI() {
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [self] indexPath in
            guard let cell = self.tableView.cellForRow(at: indexPath) as? NewsFeedTableViewCell else { return }
            viewModel.openWebsiteWithArticle(vc: self, link: cell.link)
        }).disposed(by: disposeBag)
        
        changeLanguageBarButton.rx.tap.subscribe(onNext: { _ in
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }).disposed(by: disposeBag)
        
    }
    
    func bindArticles() {
        
        //LoadingObserver
        viewModel
            .loading
            .subscribe(onNext: { [self] in $0 == true ? activityIndicator.startAnimating() : activityIndicator.stopAnimating() })
            .disposed(by: disposeBag)
        
        // Articles Observer
        viewModel
            .articles
            .observe(on: MainScheduler.instance)
            .bind(to: self.articles)
            .disposed(by: disposeBag)
        
            
        // Get the news from server
        viewModel.getTheNews()
    }
    
    
}


