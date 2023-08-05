//
//  RPCResponse.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public struct RPCResponse <Result>: Identifiable {
    
    public let version: JSONRPCVersion
    
    public let id: UInt
    
    public let method: RPCMethod
    
    public let result: Result
    
    enum CodingKeys: String, CodingKey {
        
        case version = "jsonrpc"
        case method
        case id
        case result
    }
}

extension RPCResponse: Encodable where Result: Encodable { }

extension RPCResponse: Decodable where Result: Decodable { }

extension RPCResponse: Equatable where Result: Equatable { }

extension RPCResponse: Hashable where Result: Hashable { }
