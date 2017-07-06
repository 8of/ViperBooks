//
//  LoadingListItemCollectionViewCell.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 06/06/2017.
//  Copyright © 2017 8of. All rights reserved.
//

import UIKit

final class LoadingListItemCollectionViewCell: UICollectionViewCell {

  let activity: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    view.hidesWhenStopped = false
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    activity.startAnimating()
    contentView.addSubview(activity)
    activity.autoCenterInSuperview()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    activity.startAnimating()
  }
    
}
