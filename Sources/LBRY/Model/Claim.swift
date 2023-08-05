//
//  Claim.swift
//  
//
//  Created by Alsey Coleman Miller on 8/5/23.
//

import Foundation

public final class Claim: Codable {
    
    public var address: String?
    public var amount: String?
    public var canonicalUrl: String?
    public var claimId: String?
    public var claimOp: String?
    public var confirmations: Int?
    public var height: Int?
    public var isChannelSignatureValid: Bool?
    public var meta: Meta?
    public var name: String?
    public var normalizedName: String?
    public var nout: Int?
    public var permanentUrl: String?
    public var shortUrl: String?
    public var signingChannel: Claim?
    public var repostedClaim: Claim?
    public var timestamp: Int64?
    public var txid: String?
    public var type: String?
    public var value: Metadata?
    public var valueType: ClaimType?
    
    enum CodingKeys: String, CodingKey {
        case address
        case amount
        case canonicalUrl = "canonical_url"
        case claimId = "claim_id"
        case claimOp = "claim_op"
        case confirmations
        case height
        case isChannelSignatureValid = "is_channel_signature_valid"
        case meta
        case name
        case normalizedName = "normalized_name"
        case nout
        case permanentUrl = "permanent_url"
        case shortUrl = "short_url"
        case signingChannel = "signing_channel"
        case repostedClaim = "reposted_claim"
        case timestamp
        case txid
        case value
        case valueType = "value_type"
    }
}

public extension Claim {
    
    struct Metadata: Codable, Equatable, Hashable {
        
        public var title: String?
        public var description: String?
        public var thumbnail: Resource?
        public var languages: [String]?
        public var tags: [String]?
        public var locations: [Location]?

        // channel
        public var publicKey: String?
        public var publicKeyId: String?
        public var cover: Resource?
        public var email: String?
        public var websiteUrl: String?
        public var featured: [String]?

        // stream
        public var license: String?
        public var licenseUrl: String?
        public var releaseTime: String?
        public var author: String?
        public var fee: Fee?
        public var streamType: String?
        public var source: Source?
        public var video: StreamInfo?
        public var audio: StreamInfo?
        public var image: StreamInfo?
        public var software: StreamInfo?

        // collection
        public var claims: [String]?

        enum CodingKeys: String, CodingKey {
            case title
            case description
            case thumbnail
            case languages
            case tags
            case locations
            case publicKey = "public_key"
            case publicKeyId = "public_key_id"
            case cover
            case email
            case websiteUrl = "website_url"
            case featured
            case license
            case licenseUrl = "license_url"
            case releaseTime = "release_time"
            case author
            case fee
            case streamType = "stream_type"
            case source
            case video
            case audio
            case image
            case software
            case claims
        }
    }

    struct Source: Codable, Hashable {
        
        public var sdHash: String?
        public var mediaType: String?
        public var hash: String?
        public var name: String?
        public var size: String?

        enum CodingKeys: String, CodingKey {
            case sdHash = "sd_hash"
            case mediaType = "media_type"
            case hash
            case name
            case size
        }
    }

    struct Fee: Codable, Hashable {
        
        public var amount: String?
        public var currency: String?
        public var address: String?
    }

    struct Location: Codable, Hashable {
        
        public var country: String?
    }

    struct Resource: Codable, Hashable {
        
        public var url: URL?
    }

    struct StreamInfo: Codable, Hashable {
        
        public var duration: Int64?
        public var height: Int64?
        public var width: Int64?
        public var os: String?
    }

    struct Meta: Codable, Hashable {
        
        public var effectiveAmount: String?

        enum CodingKeys: String, CodingKey {
            case effectiveAmount = "effective_amount"
        }
    }
}

public enum ClaimType: String, Codable {
    
    case channel
    case stream
    case repost
    case collection
}

public enum StreamType: String, Codable {
    
    case audio
    case binary
    case document
    case image
    case model
    case video
}
