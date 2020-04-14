//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 21/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
