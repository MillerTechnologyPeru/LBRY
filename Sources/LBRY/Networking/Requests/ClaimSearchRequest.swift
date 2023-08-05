//
//  ClaimSearchRequest.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

/// Search for stream and channel claims on the blockchain.
///
/// [API ](https://lbry.tech/api/sdk#claim_search)
public struct ClaimSearchRequest: Equatable, Hashable, Codable {
    
    public var claimType: [ClaimType]?
    public var streamTypes: [StreamType]?
    public var noTotals: Bool?
    public var page: Int?
    public var pageSize: Int?
    public var releaseTime: [String]?
    public var duration: String?
    public var hasNoSource: Bool?
    public var limitClaimsPerChannel: Int?
    public var anyTags: [String]?
    public var notTags: [String]?
    public var channelIds: [String]?
    public var notChannelIds: [String]?
    public var claimIds: [String]?
    public var orderBy: [String]?
    
    public init(claimType: [ClaimType]? = nil, streamTypes: [StreamType]? = nil, noTotals: Bool? = nil, page: Int? = nil, pageSize: Int? = nil, releaseTime: [String]? = nil, duration: String? = nil, hasNoSource: Bool? = nil, limitClaimsPerChannel: Int? = nil, anyTags: [String]? = nil, notTags: [String]? = nil, channelIds: [String]? = nil, notChannelIds: [String]? = nil, claimIds: [String]? = nil, orderBy: [String]? = nil) {
        self.claimType = claimType
        self.streamTypes = streamTypes
        self.noTotals = noTotals
        self.page = page
        self.pageSize = pageSize
        self.releaseTime = releaseTime
        self.duration = duration
        self.hasNoSource = hasNoSource
        self.limitClaimsPerChannel = limitClaimsPerChannel
        self.anyTags = anyTags
        self.notTags = notTags
        self.channelIds = channelIds
        self.notChannelIds = notChannelIds
        self.claimIds = claimIds
        self.orderBy = orderBy
    }
}

public extension RPCMethod {
    
    /// Search for stream and channel claims on the blockchain.
    ///
    /// [API ](https://lbry.tech/api/sdk#claim_search)
    static var claimSearch: RPCMethod { "claim_search" }
}

extension ClaimSearchRequest: RPCRequestConvertible {
    
    public typealias Response = Page<Claim>
    
    public static var method: RPCMethod { .claimSearch }
}
