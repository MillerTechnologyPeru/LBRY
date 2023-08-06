//
//  RPCResponse.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public struct RPCResponse <Result>: Identifiable {
    
    public let version: RPCVersion
    
    public let id: UInt?
        
    public let result: Result?
    
    public let error: RPCError?
    
    enum CodingKeys: String, CodingKey {
        
        case version = "jsonrpc"
        case id
        case result
        case error
    }
}

extension RPCResponse: Encodable where Result: Encodable { }

extension RPCResponse: Decodable where Result: Decodable { }

extension RPCResponse: Equatable where Result: Equatable { }

extension RPCResponse: Hashable where Result: Hashable { }

public extension Result where Success: Decodable, Failure == RPCError {
    
    init?(response: RPCResponse<Success>) {
        if let error = response.error {
            self = .failure(error)
        } else if let result = response.result {
            self = .success(result)
        } else {
            return nil
        }
    }
}

