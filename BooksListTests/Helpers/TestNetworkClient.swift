//
//  TestNetworkClient.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

final class TestNetworkClient {

}

extension TestNetworkClient: NetworkClientInterface {

  func getBooks(page: Int, success: @escaping ([String : Any]) -> (), error: @escaping () -> ()) {
    success(TestDataProvider.getData())
  }

}
