//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 05/03/24.
//

import Foundation
import EssentialFeed

final class FeedStoreSpy: FeedStore {
        
    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert([LocalFeedImage], Date)
        case retrieve
    }
    
    var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [Completion]()
    private var insertCompletions = [Completion]()
    private var retrievalCompletions = [RetrievalCompletion]()
    
    func deleteCachedFeed(completion: @escaping Completion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCachedFeed)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping Completion) {
        insertCompletions.append(completion)
        receivedMessages.append(.insert(feed, timestamp))
    }
    
    func completeDeletion(with error: Error, at index: Int = .zero) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = .zero) {
        deletionCompletions[index](nil)
    }
    
    func completeInsertion(with error: Error, at index: Int = .zero) {
        insertCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = .zero) {
        insertCompletions[index](nil)
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        retrievalCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetrieval(with error: Error, at index: Int = .zero) {
        retrievalCompletions[index](.failure(error))
    }
    
    func completeRetrievalWithEmptyCache(at index: Int = .zero) {
        retrievalCompletions[index](.empty)
    }
    
    func completeRetrieval(with feed: [LocalFeedImage], timestamp: Date, at index: Int = .zero) {
        retrievalCompletions[index](.found(feed: feed, timestamp: timestamp))
    }
}
