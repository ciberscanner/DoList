//
//  NSObject.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

extension NSObject {
  static var className: String {
    String(describing: self)
  }
}
