//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 24/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    func get(
        from url: URL,
        completion: @escaping (Error?, HTTPURLResponse?) -> Void
    )
}

public final class RemoteFeedLoader {
    
    // MARK: - Dependencies
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
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
        completion: @escaping (Error) -> Void
    ) {
        client.get(from: url) { error, response in
            if response != nil {
                completion(.invalidData)
            } else {
                completion(.connectivity)
            }
        }
    }
}
