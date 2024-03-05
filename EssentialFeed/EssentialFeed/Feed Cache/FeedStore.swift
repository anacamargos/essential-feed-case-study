//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 28/02/24.
//

import Foundation

public protocol FeedStore {
    typealias Completion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping Completion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping Completion)
    func retrieve()
}
