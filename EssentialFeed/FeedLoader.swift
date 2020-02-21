//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 21/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
