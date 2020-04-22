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
        session.dataTask(with: url) { _, _, _ in }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        // Given
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClient(session: session)
        
        // When
        sut.get(from: url)
        
        // Then
        XCTAssertEqual(task.resumeCallCount, 1)
    }
}

// MARK: - Test Helpers

final class URLSessionSpy: URLSession {
    private var stubs = [URL: URLSessionDataTask]()
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return stubs[url] ?? FakeURLSessionDataTask()
    }
    
    func stub(url: URL, task: URLSessionDataTask) {
        stubs[url] = task
    }
}

final class FakeURLSessionDataTask: URLSessionDataTask {}

final class URLSessionDataTaskSpy: URLSessionDataTask {
    var resumeCallCount = 0
    
    override func resume() {
        resumeCallCount += 1
    }
}
