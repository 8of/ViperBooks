//
//  BooksListMetadataItemCollectionViewCell.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit
import PureLayout
import AlamofireImage

final class BooksListMetadataItemCollectionViewCell: UICollectionViewCell {

  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleToFill
    view.isOpaque = true
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.textAlignment = .center
    label.textColor = UIColor.white
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Style.Color.grey
    addSubview(imageView)
    imageView.backgroundColor = backgroundColor
    addSubview(titleLabel)

    imageView.autoPinEdgesToSuperviewEdges()
    titleLabel.autoPinEdgesToSuperviewEdges()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func set(header: BooksListHeaderViewModel) {
    imageView.af_setImage(withURL: header.image)
    titleLabel.text = header.title
  }

}
