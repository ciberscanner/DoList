//
//  UITableView.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

extension UITableView{
  func getReusableCell<T: UITableViewCell>(
    byIdentifier identifier: String? = nil
  ) -> T! {
    let identifier = identifier ?? T.className
    guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
      print("Could not dequeue cell with identifier: \(identifier)")
      return T()
    }
    return cell
  }
}
