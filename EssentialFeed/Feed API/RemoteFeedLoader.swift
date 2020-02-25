//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 24/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    
    // MARK: - Dependencies
    
    private let url: URL
    private let client: HTTPClient
    
    // MARK: - Initializer
    
    public init(
        url: URL,
        client: HTTPClient
    ) {
        self.url = url
        self.client = client
    }
    
    // MARK: - Public Methods
    
    public func load() {
        client.get(from: url)
    }
}
