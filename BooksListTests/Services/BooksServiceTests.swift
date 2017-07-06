//
//  BooksServiceTests.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import XCTest
@testable import BooksList

final class BooksServiceTests: XCTestCase {

  let bookService = BooksService(networkClient: TestNetworkClient())

  func testGetBooks() {
    bookService.getBooks(
      page: 0,
      success: {
        books, header in
        XCTAssertNotNil(header)
        XCTAssertFalse(books.isEmpty)
      },
      error: {
        XCTFail("Should not get error")
      }
    )
  }

}
