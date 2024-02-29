//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 18/01/24.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load (completion: @escaping (LoadFeedResult) -> Void)
}
