//
//  BooksListViewInterface.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

protocol BooksListViewInput: class {
  func didRefreshBooks()
  func appendBooks(at indexes: [IndexPath])
}

protocol BooksListViewOutput: class {
  func viewDidLoad()
  func reloadBooks()
  func loadMoreBooks()
  func booksCount() -> Int
  func book(at index: Int) -> BookViewModel
  func header() -> BooksListHeaderViewModel?
}
