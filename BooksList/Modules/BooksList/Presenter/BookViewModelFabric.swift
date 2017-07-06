//
//  BookViewModelFabric.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit

final class BookViewModelFabric {

  private let authorsPrefix = "By: "
  private let narratorsPrefix = "With: "

  func booksViewModel(from book: Book) -> BookViewModel {
    let authors: String = authorsPrefix + book.authors.map({$0.name}).joined(separator: ", ")
    let narrators: String = narratorsPrefix + book.narratots.map({$0.name}).joined(separator: ", ")
    return BookViewModel(title: book.title, image: book.image.url, authors: authors, narrators: narrators)
  }

  func booksListHeaderViewModel(from header: BooksListHeader?) -> BooksListHeaderViewModel? {
    guard let header = header else { return nil }
    return BooksListHeaderViewModel(title: header.title, image: header.cover.url)
  }

}
