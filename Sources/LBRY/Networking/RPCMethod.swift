//
//  RPCMethod.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

/// HTTP Method
public struct RPCMethod: RawRepresentable, Codable, Equatable, Hashable, Sendable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

// MARK: - ExpressibleByStringLiteral

extension RPCMethod: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension RPCMethod: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue
    }
    
    public var debugDescription: String {
        rawValue
    }
}
