//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 24/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
    
    // MARK: - Dependencies
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    public typealias Result = LoadFeedResult<Error>
    
    // MARK: - Initializer
    
    public init(
        url: URL,
        client: HTTPClient
    ) {
        self.url = url
        self.client = client
    }
    
    // MARK: - Public Methods
    
    public func load(
        completion: @escaping (Result) -> Void
    ) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
