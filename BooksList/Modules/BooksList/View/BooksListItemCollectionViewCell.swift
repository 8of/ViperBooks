//
//  BooksListItemCollectionViewCell.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit
import PureLayout
import AlamofireImage

final class BooksListItemCollectionViewCell: UICollectionViewCell {

  let padding: CGFloat = Style.Size.padding

  private let coverImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.isOpaque = true
    view.backgroundColor = UIColor.white
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()

  private let authorsLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()

  private let narratorsLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Style.Color.grey
    contentView.backgroundColor = backgroundColor
    coverImageView.backgroundColor = backgroundColor
    contentView.addSubview(coverImageView)
    titleLabel.backgroundColor = backgroundColor
    contentView.addSubview(titleLabel)
    authorsLabel.backgroundColor = backgroundColor
    contentView.addSubview(authorsLabel)
    narratorsLabel.backgroundColor = backgroundColor
    contentView.addSubview(narratorsLabel)

    coverImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: padding)
    coverImageView.autoPinEdge(toSuperviewEdge: .top, withInset: padding)
    coverImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: padding)
    coverImageView.autoMatch(.height, to: .width, of: coverImageView)

    titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: padding)
    titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: padding)
    titleLabel.autoPinEdge(.leading, to: .trailing, of: coverImageView, withOffset: padding)

    narratorsLabel.autoPinEdge(.top, to: .bottom, of: authorsLabel)
    narratorsLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: padding)
    narratorsLabel.autoPinEdge(.leading, to: .trailing, of: coverImageView, withOffset: padding)
    narratorsLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: padding)

    authorsLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: padding)
    authorsLabel.autoPinEdge(.leading, to: .trailing, of: coverImageView, withOffset: padding)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    coverImageView.image = nil
    // Prevent layout changes
    authorsLabel.text = " "
    narratorsLabel.text = " "
  }

  func set(book: BookViewModel) {
    coverImageView.af_setImage(withURL: book.image)
    titleLabel.text = book.title
    authorsLabel.text = book.authors
    narratorsLabel.text = book.narrators
  }
    
}
