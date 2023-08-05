//
//  Page.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public struct Page <Item> {
    
    public let items: [Item]
    public let page: UInt
    public let pageSize: UInt
    public let totalPages: UInt?
    public let totalItems: UInt?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        case page
        case pageSize = "page_size"
        case totalPages = "total_pages"
        case totalItems = "total_items"
    }
}

extension Page: Encodable where Item: Encodable { }

extension Page: Decodable where Item: Decodable { }

extension Page: Equatable where Item: Equatable { }

extension Page: Hashable where Item: Hashable { }

extension Page: Identifiable {
    
    public var id: UInt {
        page
    }
}

public extension Page {
    
    var isLastPage: Bool {
        items.count < pageSize
    }
}
