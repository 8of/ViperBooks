//
//  BooksListAssembly.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit.UIViewController

final class BooksListAssembly {

  let view: BooksListViewController
  private weak var presenter: BooksListViewOutput?
  private weak var interactor: AnyObject?

  init() {
    let interactor = BooksListInteractor()
    let viewModelFabric = BookViewModelFabric()
    self.interactor = interactor
    let presenter = BooksListPresenter(interactor: interactor, viewModelFabric: viewModelFabric)
    self.presenter = presenter
    view = BooksListViewController.init(output: presenter)
    presenter.userInterface = view
    interactor.output = presenter
  }

  func setupAsRoot(on navigationController: UINavigationController) {
    navigationController.viewControllers = [view]
  }

}
