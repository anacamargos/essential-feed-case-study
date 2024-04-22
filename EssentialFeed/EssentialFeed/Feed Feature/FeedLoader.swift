//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 18/01/24.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load (completion: @escaping (Result) -> Void)
}
