//
//  BooksListPresenter.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import Foundation

final class BooksListPresenter {

  var userInterface: BooksListViewInput?
  weak var output: BooksListModuleOutput?
  fileprivate let interactor: BooksListInteractorInput
  fileprivate let viewModelFabric: BookViewModelFabric

  init(interactor: BooksListInteractorInput, viewModelFabric: BookViewModelFabric) {
    self.interactor = interactor
    self.viewModelFabric = viewModelFabric
  }

}

extension BooksListPresenter: BooksListViewOutput {

  func reloadBooks() {
    interactor.reloadBooks()
  }

  func loadMoreBooks() {
    interactor.getMoreBooks()
  }

  func viewDidLoad() {
    interactor.reloadBooks()
  }

  func booksCount() -> Int {
    return interactor.booksCount()
  }

  func book(at index: Int) -> BookViewModel {
    return viewModelFabric.booksViewModel(from: interactor.book(at: index))
  }

  func header() -> BooksListHeaderViewModel? {
    return viewModelFabric.booksListHeaderViewModel(from: interactor.headerInfo())
  }

}

extension BooksListPresenter: BooksListInteractorOutput {

  func got(booksCount: Int, refresh: Bool) {
    if refresh {
      userInterface?.didRefreshBooks()
    } else {
      let startIndex = interactor.booksCount() - booksCount
      let endIndex = interactor.booksCount()
      let indexes = (startIndex ..< endIndex).map({IndexPath.init(row: $0, section: booksSection())})
      userInterface?.appendBooks(at: indexes)
    }
  }

  private func booksSection() -> Int {
    return 1;
  }

}
