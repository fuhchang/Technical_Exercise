import Foundation
import SwiftUI

struct bitbucketInfo: Codable  {
    let pagelen : Int?
    var values : [values]?
    var next : String?
}

struct values : Codable {
    let scm : String?
    let links : links?
    var owner : owner?
    var project: project?
    let website: String?
    let updated_on : String?
    let language: String?
    let created_on: String?
}

struct avatar : Codable {
    let href : String?
}

struct owner : Codable {
    let display_name : String?
    let uuid : String?
    let links : links?
    let type : String?
    let nickname : String?
    let account_id : String?
    let avatar : avatar?
    var imageData: Data?
}

struct links : Codable {
    let avatar : avatar?
    let html: html?
}

struct project: Codable {
    let links : links?
    let full_name: String?
    let fork_policy: String?
    let name: String?
    let mainbranch: String?
    var imageData: Data?
}

struct mainbranch: Codable {
    let type: String?
    let name: String?
}
struct html: Codable {
    let href : String?
}
