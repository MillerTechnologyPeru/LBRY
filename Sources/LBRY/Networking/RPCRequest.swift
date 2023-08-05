//
//  RPCRequest.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// RPC Request
public struct RPCRequest <Parameters>: Identifiable {
    
    public var version: JSONRPCVersion
    
    public let id: UInt
    
    public var method: RPCMethod
    
    public var parameters: Parameters
    
    enum CodingKeys: String, CodingKey {
        
        case version = "jsonrpc"
        case method
        case id
        case parameters = "params"
    }
}

extension RPCRequest: Encodable where Parameters: Encodable { }

extension RPCRequest: Decodable where Parameters: Decodable { }

extension RPCRequest: Equatable where Parameters: Equatable { }

extension RPCRequest: Hashable where Parameters: Hashable { }

// MARK: - URL Request

public extension URLRequest {
    
    init<Parameters>(
        request: RPCRequest<Parameters>,
        server: LBRYServer,
        token: AuthorizationToken? = nil
    ) throws where Parameters: Encodable {
        let encoder = JSONEncoder.lbry
        let data = try encoder.encode(request)
        self.init(url: server.url)
        self.httpMethod = HTTPMethod.post.rawValue
        self.httpBody = data
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        if let token = token {
            self.setAuthorization(token)
        }
    }
}
// MARK: - Request Convertible

public protocol RPCRequestConvertible: Encodable {
    
    associatedtype Response: Decodable
    
    static var method: RPCMethod { get }
}

public extension RPCRequest where Parameters: RPCRequestConvertible {
    
    init(parameters: Parameters, id: UInt = .random(in: 1 ... 99999)) {
        self.init(
            version: .v2_0,
            id: id,
            method: Parameters.method,
            parameters: parameters
        )
    }
}

