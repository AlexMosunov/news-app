//
//  ViewController.swift
//  news-app
//
//  Created by Alex Mosunov on 05.09.2020.
//  Copyright © 2020 Alex Mosunov. All rights reserved.


import UIKit
import SafariServices

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var newsManager = NewsManager()
    var filterVC = FilterViewController()
    
    
    var news = NewsFeed()
    var refreshControl: UIRefreshControl = {
        let refrControl = UIRefreshControl()
        refrControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refrControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        newsManager.delegate = self
        
        tableView.refreshControl = refreshControl
        
        newsManager.fetchNews(country: nil, sources: nil, category: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        newsManager.fetchNews()
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        newsManager.fetchNews()
        tableView.reloadData()
        
    }
    
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
    }
    
    

}

//MARK: - UITableViewDelegate,UITableViewDataSource,SFSafariViewControllerDelegate

extension MainViewController: UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsArticleCell", for: indexPath) as! NewsArticleCell
        
        let article = news.articlesArray[indexPath.row]
        
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.descr
        cell.authorLabel.text = article.author
        cell.soucreLabel.text = article.source
        
        let url = URL(string: article.image)
        DispatchQueue.global().async {
            do {
                if let imageURL = url {
                    let data = try Data(contentsOf: imageURL)
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(data: data)
                    }
                }
            } catch {
                print("error with image url- \(error)")
            }
        }

        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = news.articlesArray[indexPath.row]
        print(article.url)
        
        let urlString = article.url
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


//MARK: - UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {
    
    
    @IBAction func searchTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let keyword = searchTextField.text {
            print(keyword)
            newsManager.fetchNews(searchKeyword: keyword)
        }
        searchTextField.text = ""
    }
}




//MARK: - NewsManagerDelegate

extension MainViewController: NewsManagerDelegate  {
    func didUpdateNews(_ newsManager: NewsManager, articles: [ArticleModel]) {
        news.articlesArray = articles
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
}

