//
//  ParserTests.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import XCTest
@testable import BooksList

final class ParserTests: XCTestCase {

  let data: [String: Any] = TestDataProvider.getData()
  let parser = Parser()

  func testParseBooksListHeader() {
    let header = parser.parseBooksListHeader(dictionary: data)
    XCTAssertNotNil(header)
    XCTAssertEqual(header!.title, "Lorem no ips")
    XCTAssertEqual(header!.cover.url, URL(string: "https://www.storytel.se/images/customList/18.jpg"))
  }

  func testParseBooks() {
    let books = parser.parseBooks(dictionary: data)
    XCTAssertFalse(books.isEmpty)
    guard let firstBook = books.first else {
      XCTFail()
      return
    }
    XCTAssertEqual(firstBook.image.url.absoluteString, "https://www.storytel.se/e/images/640x640/305.jpg")
    XCTAssertEqual(firstBook.title, "Everything I Know About Women I Learned From My Tractor")
    XCTAssertFalse(firstBook.authors.isEmpty)
    XCTAssertFalse(firstBook.narratots.isEmpty)
    XCTAssertEqual(firstBook.authors.first!.name, "Philip J. Fry")
    XCTAssertEqual(firstBook.narratots.last!.name, "Amy Wong")
  }

}
