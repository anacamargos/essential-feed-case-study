//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 21/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    var requestedURL: URL?
}

import XCTest

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        // Given
        let client = HTTPClient.shared
        
        // When
        _ = RemoteFeedLoader()
        
        // Then
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // Given
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        // When
        sut.load()
        
        // Then
        XCTAssertNotNil(client.requestedURL)
    }
    
}
