//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Ana Leticia Camargos on 11/03/24.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://a-url.com")!
}
