//
//  RPCError.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

/// JSON-RPC error
public struct RPCError: Equatable, Hashable, Codable, Error {
    
    public let code: Int
    
    public let message: String
}
