//
//  BooksListViewController.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit

final class BooksListViewController: UIViewController {

  fileprivate weak var output: BooksListViewOutput?

  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = Style.Size.padding
    layout.minimumInteritemSpacing = Style.Size.padding
    let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    view.allowsSelection = false
    return view
  }()

  fileprivate let refreshControl = UIRefreshControl()

  init(output: BooksListViewOutput?) {
    super.init(nibName: nil, bundle: nil)
    self.output = output
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  private init() {
    super.init(nibName: nil, bundle: nil)
  }

  private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.white
    view.addSubview(collectionView)
    collectionView.backgroundColor = view.backgroundColor
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    refreshControl.addTarget(self, action: #selector(reloadDataAction), for: .valueChanged)
    collectionView.addSubview(refreshControl)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCells(for: collectionView)
    collectionView.dataSource = self
    collectionView.delegate = self
    output?.viewDidLoad()
  }

  // MARK: - Private

  private func registerCells(for collectionView: UICollectionView) {
    for type: UICollectionViewCell.Type in [BooksListMetadataItemCollectionViewCell.self, BooksListItemCollectionViewCell.self, LoadingListItemCollectionViewCell.self] {
      collectionView.register(type, forCellWithReuseIdentifier: String(describing: type))
    }
  }

  // MARK: - Actions

  @objc private func reloadDataAction() {
    output?.reloadBooks()
  }

}

extension BooksListViewController: BooksListViewInput {

  func didRefreshBooks() {
    refreshControl.endRefreshing()
    collectionView.reloadData()
  }

  func appendBooks(at indexes: [IndexPath]) {
    refreshControl.endRefreshing()

    collectionView.performBatchUpdates(
      {
        self.collectionView.insertItems(at: indexes)
      },
      completion: { _ in })
  }

}

extension BooksListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  fileprivate enum BooksListSection: Int {
    case header
    case books
    case loading
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let output = output else { return 0 }
    switch BooksListSection(rawValue: section)! {
    case .header:
      return (output.header() != nil) ? 1 : 0
    case .books:
      return output.booksCount()
    case .loading:
      return 1
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let output = output else { return UICollectionViewCell() }
    switch BooksListSection.init(rawValue: indexPath.section)! {
    case .header:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BooksListMetadataItemCollectionViewCell.self), for: indexPath) as! BooksListMetadataItemCollectionViewCell
      if let header = output.header() {
        cell.set(header: header)
      }
      return cell
    case .books:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BooksListItemCollectionViewCell.self), for: indexPath) as! BooksListItemCollectionViewCell
      cell.set(book: output.book(at: indexPath.row))
      return cell
    case .loading:
      return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LoadingListItemCollectionViewCell.self), for: indexPath)
    }
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let output = output else { return }
    if indexPath.section == BooksListSection.loading.rawValue {
      output.loadMoreBooks()
    }
  }
  
}

extension BooksListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height: CGFloat!
    switch BooksListSection(rawValue: indexPath.section)! {
    case .header:
      height = 200
    case .books:
      height = 100
    case .loading:
      height = 40
    }
    return CGSize.init(width: collectionView.bounds.width, height: height)
  }

}
