//
//  JSON.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public extension JSONEncoder {
    
    static var lbry: JSONEncoder {
        let encoder = JSONEncoder()
        return encoder
    }
}

public extension JSONDecoder {
    
    static var lbry: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}
