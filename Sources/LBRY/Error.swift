//
//  Error.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public enum LBRYError: Error {
    
    case authenticationRequired
    case invalidStatusCode(Int)
    case invalidResponse(Data)
    case serverError(RPCError)
}
