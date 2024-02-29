//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Ana Leticia Camargos on 29/02/24.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
