//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 21/02/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

class RemoteFeedLoader {
    
    let client: HTTPClient
    let url: URL
    
    init(
        url: URL,
        client: HTTPClient
    ) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

import XCTest

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        // Given
        // When
        let (_, client) = makeSUT()
        
        // Then
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // Given
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        // When
        sut.load()
        
        // Then
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Testing Helpers
    
    private func makeSUT(
        url: URL =  URL(string: "https://a-url.com")!
    ) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
}

private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    func get(from url: URL) {
        requestedURL = url
    }
}
