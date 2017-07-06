//
//  NetworkClientInterface.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 05/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

protocol NetworkClientInterface: class {
  func getBooks(page: Int, success: @escaping ([String: Any])->(), error: @escaping ()->())
}
