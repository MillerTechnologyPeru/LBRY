import XCTest
@testable import LBRY

final class LBRYTests: XCTestCase {
    
    func testServerURL() throws {
        
        XCTAssertEqual(LBRYServer.odysee.rawValue, "https://api.na-backend.odysee.com/api/v1/proxy")
        XCTAssertEqual(LBRYServer.localhost(), LBRYServer(rawValue: "http://localhost:5279"))
        XCTAssertEqual(LBRYServer.localhost().url.port, 5279)
        XCTAssertEqual(LBRYServer.localhost(port: 1234).url.port, 1234)
    }
}
