//
//  NibInitializable.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit

protocol NibInitializable {
  static var nibName: String { get }
  static func initFromNib() -> Self
}

extension NibInitializable where Self: UIView {
  static var nibName: String {
    return String(describing: Self.self)
  }

  static var nib: UINib {
    return UINib(nibName: nibName, bundle: nil)
  }

  static func initFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("Could not instantiate view from nib with name \(nibName).")
    }

    return view
  }
}
