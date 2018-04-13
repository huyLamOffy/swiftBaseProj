//
//  UserService.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 4/12/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation
class TaskService {
    var clientRequest: APIRequest!
    init(request: APIRequest) {
        self.clientRequest = request
    }
    
    func fetchTask(with taskRequestModel: TaskListRequestModel, completion: @escaping (Result<TaskListRequestModel.Response, APIError>) -> Void) {
        do {
            guard let params = try taskRequestModel.toParameters() else {
                completion(.failure(APIError.jsonConversionFailure))
                return
            }
            let route = TaskRouter.fetchTasksList(taskType: .offers, params: params)
            clientRequest.requestObject(route: route, completion: completion)
        } catch {
            completion(.failure(APIError.jsonConversionFailure))
        }
    }
}
