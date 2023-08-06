//
//  Mock.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import LBRY

struct MockClient: URLClient {
    
    let data: Data
    
    let response: URLResponse
    
    func data(for request: URLRequest) throws -> (Data, URLResponse) {
        guard request.url == request.url else {
            throw URLError(.badURL)
        }
        return (data, response)
    }
}

extension MockClient {
    
    init(
        json: LBRYMockJSONData,
        url: URL = LBRYServer.localhost().url,
        statusCode: Int = 200
    ) {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        self.init(
            data: json.data,
            response: response
        )
    }
}
