//
//  ServerURL.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

/// HTTP Method
public struct LBRYServer: Codable, Equatable, Hashable, Sendable {
    
    internal let url: URL
    
    internal init(url: URL) {
        self.url = url
    }
}

public extension URL {
    
    init(server: LBRYServer) {
        self = server.url
    }
}

// MARK: - RawRepresentable

extension LBRYServer: RawRepresentable {
    
    public init?(rawValue: String) {
        guard let url = URL(string: rawValue) else {
            return nil
        }
        self.init(url: url)
    }
    
    public var rawValue: String {
        url.absoluteString
    }
}

// MARK: - CustomStringConvertible

extension LBRYServer: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue
    }
    
    public var debugDescription: String {
        rawValue
    }
}

// MARK: - Definitions

public extension LBRYServer {
    
    static func localhost(port: UInt = 5279) -> LBRYServer {
        return LBRYServer(rawValue: "http://localhost:" + port.description)!
    }
    
    static var odysee: LBRYServer {
        return LBRYServer(rawValue: "https://api.na-backend.odysee.com/api/v1/proxy")!
    }
}
