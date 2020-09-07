//
//  NewsData.swift
//  news-app
//
//  Created by Alex Mosunov on 07.09.2020.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import Foundation


struct NewsData: Codable {
    let status: String
    let articles: [Articles]
}

struct Articles: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let source: Source
    let url: String?
}

struct Source: Codable {
    let name: String?
}
