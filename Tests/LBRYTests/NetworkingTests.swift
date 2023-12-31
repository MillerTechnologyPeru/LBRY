//
//  NetworkingTests.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation
import XCTest
@testable import LBRY
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class NetworkingTests: XCTestCase {
    
    func testClaimSearch() async throws {
        
        let client = MockClient(json: .claimSearchResponse)
        let request = ClaimSearchRequest.mock
        let response = try await client.response(for: request)
        XCTAssertEqual(response.items.count, 20)
    }
}
