//
//  BooksService.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

final class BooksService {

  private let networkClient: NetworkClientInterface!
  private let parser = Parser()

  init(networkClient: NetworkClientInterface) {
    self.networkClient = networkClient
  }

  private init() {
    networkClient = nil
  }

  func getBooks(page: Int, success: @escaping ([Book], BooksListHeader?)->(), error: @escaping ()->()) {
    networkClient.getBooks(
      page: page,
      success: {
        [weak self]
        dicitonary in
        guard let `self` = self else { return }
        let books = self.parser.parseBooks(dictionary: dicitonary)
        let booksListHeader = self.parser.parseBooksListHeader(dictionary: dicitonary)
        success(books, booksListHeader)
      }, error: error
    )
  }

}
