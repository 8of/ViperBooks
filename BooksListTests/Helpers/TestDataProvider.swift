//
//  TestDataProvider.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

final class TestDataProvider {

  static private let dataUrl: String? = Bundle(for: TestNetworkClient.self).path(forResource: "booksList", ofType: "json")

  static func getData() -> [String: Any]! {
    let jsonData: Data
    let jsonAny: Any?
    do {
      jsonData = try Data(contentsOf: URL.init(fileURLWithPath: dataUrl!), options: .mappedIfSafe)
      jsonAny = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
    } catch {
      assertionFailure("Broken data")
      jsonAny = nil
    }
    guard let jsonDictionary = jsonAny as? [String: Any] else {
      assertionFailure("Broken data")
      return nil
    }
    return jsonDictionary
  }
}
