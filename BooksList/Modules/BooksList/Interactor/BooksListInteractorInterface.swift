//
//  BooksListInteractorInterface.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

protocol BooksListInteractorInput: class {
  func reloadBooks()
  func getMoreBooks()
  func booksCount() -> Int
  func book(at index: Int) -> Book
  func headerInfo() -> BooksListHeader?
}

protocol BooksListInteractorOutput: class {
  func got(booksCount: Int, refresh: Bool)
}
