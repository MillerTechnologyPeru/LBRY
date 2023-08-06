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
    
    public var version: RPCVersion
    
    public let id: UInt
    
    public var method: RPCMethod
    
    public var parameters: Parameters
    
    public init(
        version: RPCVersion = .v2_0,
        id: UInt = UInt(Date().timeIntervalSince1970),
        method: RPCMethod,
        parameters: Parameters
    ) {
        self.version = version
        self.id = id
        self.method = method
        self.parameters = parameters
    }
    
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
    
    init(parameters: Parameters, id: UInt = UInt(Date().timeIntervalSince1970)) {
        self.init(
            version: .v2_0,
            id: id,
            method: Parameters.method,
            parameters: parameters
        )
    }
}

// MARK: - URL Client

public extension URLClient {
    
    func response<Request, Response>(
        for request: RPCRequest<Request>,
        id: UInt = UInt(Date().timeIntervalSince1970),
        server: LBRYServer = .localhost(),
        token: AuthorizationToken? = nil
    ) async throws -> Response where Request: Encodable, Response: Decodable {
        let decoder = JSONDecoder.lbry
        let urlRequest = try URLRequest(
            request: request,
            server: server,
            token: token
        )
        let (data, urlResponse) = try await self.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard httpResponse.statusCode >= 200,
              httpResponse.statusCode < 300 else {
            throw LBRYError.invalidStatusCode(httpResponse.statusCode)
        }
        let response = try decoder.decode(RPCResponse<Response>.self, from: data)
        guard let result = Result<Response, RPCError>.init(response: response) else {
            throw LBRYError.invalidResponse(data)
        }
        return try result
            .mapError { LBRYError.serverError($0) }
            .get()
    }
    
    func response<Request: RPCRequestConvertible>(
        for request: Request,
        id: UInt = UInt(Date().timeIntervalSince1970),
        server: LBRYServer = .localhost(),
        token: AuthorizationToken? = nil
    ) async throws -> Request.Response {
        let request = RPCRequest(method: Request.method, parameters: request)
        return try await response(for: request, id: id, server: server, token: token)
    }
}
