//
//  Asset.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/8.
//

import Foundation

// MARK: - Asset
struct Asset: Codable {
    let id, numSales: Int?
    let imageURL, imagePreviewURL, imageThumbnailURL: String?
    let imageOriginalURL, animationURL, animationOriginalURL, name: String?
    let assetDescription, externalLink: String?
    let assetContract: AssetContract?
    let permalink: String?
    let collection: Collection?
    let decimals: Int?
    let tokenMetadata: String?
    let isNsfw: Bool?
    let owner: Creator?
    let sellOrders: String?
    let creator: Creator?
    let lastSale, topBid, listingDate: String?
    let isPresale: Bool?
    let transferFeePaymentToken, tokenID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case numSales = "num_sales"
        case imageURL = "image_url"
        case imagePreviewURL = "image_preview_url"
        case imageThumbnailURL = "image_thumbnail_url"
        case imageOriginalURL = "image_original_url"
        case animationURL = "animation_url"
        case animationOriginalURL = "animation_original_url"
        case name
        case assetDescription = "description"
        case externalLink = "external_link"
        case assetContract = "asset_contract"
        case permalink, collection, decimals
        case tokenMetadata = "token_metadata"
        case isNsfw = "is_nsfw"
        case owner
        case sellOrders = "sell_orders"
        case creator
        case lastSale = "last_sale"
        case topBid = "top_bid"
        case listingDate = "listing_date"
        case isPresale = "is_presale"
        case transferFeePaymentToken = "transfer_fee_payment_token"
        case tokenID = "token_id"
    }
}

// MARK: - AssetContract
struct AssetContract: Codable {
    let address, assetContractType, createdDate, name: String?
    let nftVersion, openseaVersion: String?
    let owner: Int?
    let schemaName, symbol, totalSupply, assetContractDescription: String?
    let externalLink, imageURL: String?
    let defaultToFiat: Bool?
    let devBuyerFeeBasisPoints, devSellerFeeBasisPoints: Int?
    let onlyProxiedTransfers: Bool?
    let openseaBuyerFeeBasisPoints, openseaSellerFeeBasisPoints, buyerFeeBasisPoints, sellerFeeBasisPoints: Int?
    let payoutAddress: String?

    enum CodingKeys: String, CodingKey {
        case address
        case assetContractType = "asset_contract_type"
        case createdDate = "created_date"
        case name
        case nftVersion = "nft_version"
        case openseaVersion = "opensea_version"
        case owner
        case schemaName = "schema_name"
        case symbol
        case totalSupply = "total_supply"
        case assetContractDescription = "description"
        case externalLink = "external_link"
        case imageURL = "image_url"
        case defaultToFiat = "default_to_fiat"
        case devBuyerFeeBasisPoints = "dev_buyer_fee_basis_points"
        case devSellerFeeBasisPoints = "dev_seller_fee_basis_points"
        case onlyProxiedTransfers = "only_proxied_transfers"
        case openseaBuyerFeeBasisPoints = "opensea_buyer_fee_basis_points"
        case openseaSellerFeeBasisPoints = "opensea_seller_fee_basis_points"
        case buyerFeeBasisPoints = "buyer_fee_basis_points"
        case sellerFeeBasisPoints = "seller_fee_basis_points"
        case payoutAddress = "payout_address"
    }
}

// MARK: - Collection
struct Collection: Codable {
    let bannerImageURL, chatURL, createdDate: String?
    let defaultToFiat: Bool?
    let collectionDescription, devBuyerFeeBasisPoints, devSellerFeeBasisPoints, discordURL: String?
    let displayData: DisplayData?
    let externalURL: String?
    let featured: Bool?
    let featuredImageURL: String?
    let hidden: Bool?
    let safelistRequestStatus, imageURL: String?
    let isSubjectToWhitelist: Bool?
    let largeImageURL, mediumUsername, name: String?
    let onlyProxiedTransfers: Bool?
    let openseaBuyerFeeBasisPoints, openseaSellerFeeBasisPoints, payoutAddress: String?
    let requireEmail: Bool?
    let shortDescription, slug, telegramURL, twitterUsername: String?
    let instagramUsername, wikiURL: String?
    let isNsfw: Bool?

    enum CodingKeys: String, CodingKey {
        case bannerImageURL = "banner_image_url"
        case chatURL = "chat_url"
        case createdDate = "created_date"
        case defaultToFiat = "default_to_fiat"
        case collectionDescription = "description"
        case devBuyerFeeBasisPoints = "dev_buyer_fee_basis_points"
        case devSellerFeeBasisPoints = "dev_seller_fee_basis_points"
        case discordURL = "discord_url"
        case displayData = "display_data"
        case externalURL = "external_url"
        case featured
        case featuredImageURL = "featured_image_url"
        case hidden
        case safelistRequestStatus = "safelist_request_status"
        case imageURL = "image_url"
        case isSubjectToWhitelist = "is_subject_to_whitelist"
        case largeImageURL = "large_image_url"
        case mediumUsername = "medium_username"
        case name
        case onlyProxiedTransfers = "only_proxied_transfers"
        case openseaBuyerFeeBasisPoints = "opensea_buyer_fee_basis_points"
        case openseaSellerFeeBasisPoints = "opensea_seller_fee_basis_points"
        case payoutAddress = "payout_address"
        case requireEmail = "require_email"
        case shortDescription = "short_description"
        case slug
        case telegramURL = "telegram_url"
        case twitterUsername = "twitter_username"
        case instagramUsername = "instagram_username"
        case wikiURL = "wiki_url"
        case isNsfw = "is_nsfw"
    }
}

// MARK: - DisplayData
struct DisplayData: Codable {
    let cardDisplayStyle: String?

    enum CodingKeys: String, CodingKey {
        case cardDisplayStyle = "card_display_style"
    }
}

// MARK: - Creator
struct Creator: Codable {
    let user: User?
    let profileImgURL: String?
    let address, config: String?

    enum CodingKeys: String, CodingKey {
        case user
        case profileImgURL = "profile_img_url"
        case address, config
    }
}

// MARK: - User
struct User: Codable {
    let username: String?
}
