//
//  Parser.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

struct Parser {

  func parseBooksListHeader(dictionary: [String: Any]) -> BooksListHeader? {
    guard let metadata = dictionary["metadata"] as? [String: Any],
      let title = metadata["title"] as? String,
      let coverDictionary = metadata["cover"] as? [String: Any],
      let image = parseImage(dictionary: coverDictionary)
      else { return nil }
    return BooksListHeader(title: title, cover: image)
  }

  func parseBooks(dictionary: [String: Any]) -> [Book] {
    guard let consumables = dictionary["consumables"] as? [[String: Any]] else { return [] }
    return consumables.map({ parseBook(dictionary: $0) }).flatMap({ $0 })
  }

  // MARK: - Private

  private func parseBook(dictionary: [String: Any]) -> Book? {
    guard let metadata = dictionary["metadata"] as? [String: Any],
    let title = metadata["title"] as? String,
      let cover = metadata["cover"] as? [String: Any],
      let image = parseImage(dictionary: cover),
      let authorsDictionaries = metadata["authors"] as? [[String: Any]],
      let narratorsDictionaries = metadata["narrators"] as? [[String: Any]]
      else { return nil }
    let narrators = narratorsDictionaries.map({ parsePerson(dictionary:$0) }).flatMap({$0})
    let authors = authorsDictionaries.map({ parsePerson(dictionary:$0) }).flatMap({$0})
    return Book(title: title, image: image, narratots: narrators, authors: authors)
  }

  private func parsePerson(dictionary: [String: Any]) -> Person? {
    guard let name = dictionary["name"] as? String else { return nil }
    return Person(name: name)
  }

  private func parseImage(dictionary: [String: Any]) -> Image? {
    guard let urlString = dictionary["url"] as? String,
      let url = URL(string: urlString) else { return nil }
    return Image(url: url)
  }

}
