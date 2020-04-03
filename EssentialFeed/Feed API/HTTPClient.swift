//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 03/04/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(
        from url: URL,
        completion: @escaping (HTTPClientResult) -> Void
    )
}
