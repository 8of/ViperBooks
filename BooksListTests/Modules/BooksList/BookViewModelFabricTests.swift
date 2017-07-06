//
//  BookViewModelFabricTests.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import XCTest
@testable import BooksList

final class BookViewModelFabricTests: XCTestCase {

  let viewModelFabric = BookViewModelFabric()

  func testBooksViewModelFromModel() {
    let book = generateBook()
    let bookViewModel = viewModelFabric.booksViewModel(from: book)
    XCTAssertEqual(bookViewModel.title, "Book title")
    XCTAssertFalse(bookViewModel.authors.isEmpty)
    XCTAssertFalse(bookViewModel.narrators.isEmpty)
    XCTAssertEqual(bookViewModel.authors, "By: The Person, The Person")
    XCTAssertEqual(bookViewModel.narrators, "With: The Person, The Person")
  }

  private func generateBook() -> Book {
    let person = Person(name: "The Person")
    let image = Image(url: URL.init(string: "http://www.image.com/image.jpg")!)
    return Book(title: "Book title", image: image, narratots: [person, person], authors: [person, person])
  }

}
