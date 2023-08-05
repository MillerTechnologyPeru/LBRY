//
//  JSONRPCVersion.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

/// Version of the [JSON-RPC](https://en.wikipedia.org/wiki/JSON-RPC) protocol
public enum JSONRPCVersion: String, Codable {
    
    case v1_0 = "1.0"
    case v1_1 = "1.1"
    case v1_2 = "1.2"
    case v2_0 = "2.0"
}
