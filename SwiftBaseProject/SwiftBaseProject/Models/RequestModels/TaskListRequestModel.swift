//
//  TaskListRequestModel.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 4/12/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation
struct TaskListRequestModel: RequestModelProtocol {
    typealias Response = TaskListResponseModel
    
    var pageSize: Int
    var pageIndex: Int
    var keyword: String?
    var expired: Bool
    var acceptorId: String?
    var ownerId: String?
    
    init(pageSize: Int, pageIndex: Int, keyword: String? = nil, acceptorId: String? = nil, ownerId: String? = nil, expired: Bool = false) {
        self.pageIndex = pageIndex
        self.pageSize = pageSize
        self.keyword = keyword
        self.expired = expired
        self.acceptorId = acceptorId
        self.ownerId = ownerId
    }
}
extension TaskListRequestModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case pageSize
        case pageIndex
        case keyword
        case challengeStatus = "filter[status]"
        case expired = "filter[expired]"
        case acceptorId = "filter[acceptorId]"
        case ownerId = "filter[ownerId]"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pageSize, forKey: .pageSize)
        try container.encode(pageIndex, forKey: .pageIndex)
        try container.encodeIfPresent(keyword, forKey: .keyword)
        try container.encodeIfPresent(expired, forKey: .expired)
        try container.encodeIfPresent(acceptorId, forKey: .acceptorId)
        try container.encodeIfPresent(ownerId, forKey: .ownerId)
    }
    
}
