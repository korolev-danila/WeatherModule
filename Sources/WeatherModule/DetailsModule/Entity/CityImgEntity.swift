//
//  File.swift
//  
//
//  Created by Данила on 29.11.2022.
//

import Foundation

// This file was ge// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let citysImgResponse = try? newJSONDecoder().decode(CitysImgResponse.self, from: jsonData)

import Foundation

// MARK: - CitysImgResponse
struct CitysImgResponse: Codable {
    let embedded: CitysImgResponseEmbedded
    let links: CitysImgResponseLinks
    let count: Int

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case count
    }
}

// MARK: - CitysImgResponseEmbedded
struct CitysImgResponseEmbedded: Codable {
    let uaItem: [UaItem]

    enum CodingKeys: String, CodingKey {
        case uaItem = "ua:item"
    }
}

// MARK: - UaItem
struct UaItem: Codable {
    let embedded: UaItemEmbedded
    let links: UaItemLinks
    let boundingBox: BoundingBox
    let continent: Continent
    let fullName: String
    let isGovernmentPartner: Bool
    let mayor: String?
    let name, slug: String
    let teleportCityURL: String
    let uaID: String

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case boundingBox = "bounding_box"
        case continent
        case fullName = "full_name"
        case isGovernmentPartner = "is_government_partner"
        case mayor, name, slug
        case teleportCityURL = "teleport_city_url"
        case uaID = "ua_id"
    }
}

// MARK: - BoundingBox
struct BoundingBox: Codable {
    let latlon: Latlon
}

// MARK: - Latlon
struct Latlon: Codable {
    let east, north, south, west: Double
}

enum Continent: String, Codable {
    case africa = "Africa"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - UaItemEmbedded
struct UaItemEmbedded: Codable {
    let uaImages: UaImages

    enum CodingKeys: String, CodingKey {
        case uaImages = "ua:images"
    }
}

// MARK: - UaImages
struct UaImages: Codable {
    let links: UaImagesLinks
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case photos
    }
}

// MARK: - UaImagesLinks
struct UaImagesLinks: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - Photo
struct Photo: Codable {
    let attribution: Attribution
    let image: Image
}

// MARK: - Attribution
struct Attribution: Codable {
    let license, photographer: String
    let site: Site
    let source: String
}

enum Site: String, Codable {
    case empty = ""
    case flickr = "Flickr"
    case googlePhotos = "Google Photos"
    case pixabay = "Pixabay"
    case unsplash = "Unsplash"
    case wikimediaCommons = "Wikimedia Commons"
    case wikipedia = "Wikipedia"
}

// MARK: - Image
struct Image: Codable {
    let mobile, web: String
}

// MARK: - UaItemLinks
struct UaItemLinks: Codable {
    let linksSelf: SelfClass
    let uaAdmin1Divisions: [Ua]
    let uaCities: SelfClass
    let uaContinent: Ua
    let uaCountries: [Ua]
    let uaDetails: SelfClass
    let uaIdentifyingCity: Ua
    let uaImages: SelfClass
    let uaPrimaryCities: [Ua]
    let uaSalaries, uaScores: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case uaAdmin1Divisions = "ua:admin1-divisions"
        case uaCities = "ua:cities"
        case uaContinent = "ua:continent"
        case uaCountries = "ua:countries"
        case uaDetails = "ua:details"
        case uaIdentifyingCity = "ua:identifying-city"
        case uaImages = "ua:images"
        case uaPrimaryCities = "ua:primary-cities"
        case uaSalaries = "ua:salaries"
        case uaScores = "ua:scores"
    }
}

// MARK: - Ua
struct Ua: Codable {
    let href: String
    let name: String
}

// MARK: - CitysImgResponseLinks
struct CitysImgResponseLinks: Codable {
    let curies: [Cury]
    let linksSelf: SelfClass
    let uaItem: [Ua]

    enum CodingKeys: String, CodingKey {
        case curies
        case linksSelf = "self"
        case uaItem = "ua:item"
    }
}

// MARK: - Cury
struct Cury: Codable {
    let href, name: String
    let templated: Bool
}
