//
//  NewsModel.swift
//  news-app
//
//  Created by Alex Mosunov on 05.09.2020.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import Foundation


protocol NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager, articles: [ArticleModel])
}

struct NewsManager {

    let newsURL = "https://newsapi.org/v2/top-headlines?sortBy=publishedAt&apiKey=\(K.apiKey)"

    var news = NewsFeed()
    
    var delegate: NewsManagerDelegate?
    
    var articlesArray: [ArticleModel] = []
    
    func fetchNews (country: String?, sources: String?, category: String?) {
        let urlString = "\(newsURL)&country=\(country ?? "us")&sources=\(sources ?? "")&category=\(category ?? "")"
        performRequest(with: urlString)
        print(urlString)
        
    }
    
    
    func fetchNews (searchKeyword: String) {
        let urlString = "\(newsURL)&q=\(searchKeyword)"
        performRequest(with: urlString)
    }

    func fetchNews () {
        performRequest(with: newsURL)
    }
    
    
    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    
                    if let newsFeed = self.parseJSON(newsData: safeData) {
                        self.delegate?.didUpdateNews(self, articles: newsFeed)
                    }
                    
                }
            }

            task.resume()
        }
        
        
    }
    
    
    func parseJSON(newsData: Data) -> [ArticleModel]? {
        var articlesArray:[ArticleModel] = []
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsData.self, from: newsData)
            for article in decodedData.articles {
                let title = article.title ?? ""
                let descr = article.description ?? ""
                let author = article.author ?? ""
                let image = article.urlToImage ?? ""
                let source = article.source.name ?? ""
                let url = article.url ?? ""
                
                let article = ArticleModel(title: title, descr: descr, author: author, image: image, source: source, url: url)
                articlesArray.append(article)

            }

            return articlesArray
        } catch {
            print("error: \(error); \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
