//
//  BooksListInteractor.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

final class BooksListInteractor {

  var output: BooksListInteractorOutput?
  fileprivate var booksService = BooksService(networkClient: NetworkClient())
  fileprivate var loading = false
  fileprivate var emptyItemsBeforeAppending = false
  fileprivate var currentPage = 0
  fileprivate var items: [Book] = []
  fileprivate var header: BooksListHeader?

}

extension BooksListInteractor: BooksListInteractorInput {

  func reloadBooks() {
    currentPage = 0
    emptyItemsBeforeAppending = true
    header = nil
    getMoreBooks()
  }

  func getMoreBooks() {
    if loading {
      return
    }
    loading = true
    booksService.getBooks(
      page: currentPage,
      success: {
        [weak self]
        books, header in
        guard let `self` = self else { return }
        if (self.header == nil) {
          self.header = header
        }
        if self.emptyItemsBeforeAppending {
          self.items = []
        }
        self.emptyItemsBeforeAppending = false
        self.items.append(contentsOf: books)
        self.loading = false
        self.output?.got(booksCount: books.count, refresh: self.currentPage == 0)
        self.currentPage += 1
      }, error: {
        [weak self] in
        self?.loading = false
      }
    )
  }

  func booksCount() -> Int {
    return items.count
  }

  func book(at index: Int) -> Book {
    return items[index]
  }

  func headerInfo() -> BooksListHeader? {
    return header
  }

}
