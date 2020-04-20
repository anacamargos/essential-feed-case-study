//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 20/04/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import XCTest

final class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }
    }
}

final class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_createsDataTaskWithURL() {
        // Given
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        // When
        sut.get(from: url)
        
        // Then
        XCTAssertEqual(session.receivedURLs, [url])
    }
}

// MARK: - Test Helpers

final class URLSessionSpy: URLSession {
    var receivedURLs = [URL]()
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        receivedURLs.append(url)
        return FakeURLSessionDataTask()
    }
}

final class FakeURLSessionDataTask: URLSessionDataTask {}
