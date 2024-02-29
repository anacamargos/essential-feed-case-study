//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 26/01/24.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
