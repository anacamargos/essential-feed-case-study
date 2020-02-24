//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 21/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

import XCTest

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        // Given
        let client = HTTPClient()
        
        // When
        _ = RemoteFeedLoader()
        
        // Then
        XCTAssertNil(client.requestedURL)
    }
    
}
