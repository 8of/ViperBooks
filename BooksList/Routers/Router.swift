//
//  Router.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit.UIViewController

final class Router {

  func setupRootViewController(on viewController: UIViewController?) {
    guard let navigationController = viewController as? UINavigationController else {
      assert(viewController is UINavigationController, "Should be UINavigationController")
      return;
    }
    let assembly = BooksListAssembly()
    navigationController.viewControllers = [assembly.view]
  }

}
