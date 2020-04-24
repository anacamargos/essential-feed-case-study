//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 20/04/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import XCTest
import EssentialFeed

protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask
}

protocol HTTPSessionTask {
    func resume()
}

final class URLSessionHTTPClient {
    private let session: HTTPSession
    
    init(session: HTTPSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        // Given
        let url = URL(string: "https://any-url.com")!
        let session = HTTPSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClient(session: session)
        
        // When
        sut.get(from: url) { _ in }
        
        // Then
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    func test_getFromURL_failsOnRequestError() {
        // Given
        let url = URL(string: "https://any-url.com")!
        let error = NSError(domain: "any error", code: 1)
        let session = HTTPSessionSpy()
        session.stub(url: url, error: error)
        let sut = URLSessionHTTPClient(session: session)
        let exp = expectation(description: "Wait for completion")
        
        // When
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError, error)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

// MARK: - Test Helpers

final class HTTPSessionSpy: HTTPSession {
    
    private struct Stub {
        let task: HTTPSessionTask
        let error: Error?
    }
    
    private var stubs = [URL: Stub]()
    
    func stub(url: URL, task: HTTPSessionTask = FakeURLSessionDataTask(), error: Error? = nil) {
        stubs[url] = Stub(task: task, error: error)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask {
        guard let stub = stubs[url] else {
            fatalError("Couldn't find stub for \(url)")
        }
        completionHandler(nil, nil, stub.error)
        return stub.task
    }
}

final class FakeURLSessionDataTask: HTTPSessionTask {
    func resume() {}
}

final class URLSessionDataTaskSpy: HTTPSessionTask {
    var resumeCallCount = 0
    
    func resume() {
        resumeCallCount += 1
    }
}
