//
//  TasksListResponseModel.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 4/12/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation
struct TaskListResponseModel {    
    var pageIndex: Int
    var totalElements: Int
    var totalPages: Int
    init(pageIndex: Int, totalElements: Int, totalPages: Int) {
        self.pageIndex = pageIndex
        self.totalElements = totalElements
        self.totalPages = totalPages
    }
}
extension TaskListResponseModel: Decodable {
    private enum CodingKeys : String, CodingKey {
        case totalElements = "totalElements"
        case pageIndex = "pageIndex"
        case totalPages = "totalPages"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let pageIndex = try container.decode(Int.self, forKey: .pageIndex)
        let totalElements = try container.decode(Int.self, forKey: .totalElements)
        let totalPages = try container.decode(Int.self, forKey: .totalPages)
        
        self.init(pageIndex: pageIndex, totalElements: totalElements, totalPages: totalPages)
    }
}
