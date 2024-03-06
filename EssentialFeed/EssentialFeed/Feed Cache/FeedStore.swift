//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 28/02/24.
//

import Foundation

public enum RetrieveCachedFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias Completion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedFeedResult) -> Void
    
    func deleteCachedFeed(completion: @escaping Completion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping Completion)
    func retrieve(completion: @escaping RetrievalCompletion)
}
