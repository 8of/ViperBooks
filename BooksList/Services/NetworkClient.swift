//
//  NetworkClient.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkClient {

  private let baseUrl = "http://8of.org/api/viper_books"
  private let alamofireManager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForResource = 15 // seconds
    return Alamofire.SessionManager(configuration: configuration)
  }()

  // MARK: - Private

  fileprivate func apiCall(_ method: HTTPMethod, path: String, parameters: [String: Any], onGetResponse: @escaping ([String: Any])->(), onError: ((NSError?)->())?) {
    let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
    alamofireManager
      .request(self.getUrl(path: path), method: method, parameters: parameters, encoding: encoding)
      .responseJSON(
        completionHandler: {
          response in
          let statusCode = response.response?.statusCode ?? 404
          guard 200 <= statusCode &&
            statusCode < 300,
            let responseValue = response.result.value as? [String: Any]
            else
          {
            onError?(response.result.error as NSError?)
            return
          }
          onGetResponse(responseValue)
      }
    )
  }

  private func getUrl(path: String) -> String {
    return self.baseUrl + path
  }

}

extension NetworkClient: NetworkClientInterface {

  func getBooks(page: Int, success: @escaping ([String: Any])->(), error: @escaping ()->()) {
    apiCall(
      .get,
      path: "/list.json",
      parameters: ["page": page],
      onGetResponse: success,
      onError: {
        _ in
        error()
      }
    )
  }

}
