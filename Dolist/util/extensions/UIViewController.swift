//
//  UIViewController.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

extension UIViewController{
  func hideKeyboardWhenTappedAround() {
      let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
  }
  @objc func dismissKeyboard() {
      view.endEditing(true)
  }
  
  func addLogoToNavigationBarItem() {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
      imageView.contentMode = .scaleAspectFit
      imageView.image = UIImage(named:"logo")
      //imageView.backgroundColor = .lightGray

      // In order to center the title view image no matter what buttons there are, do not set the
      // image view as title view, because it doesn't work. If there is only one button, the image
      // will not be aligned. Instead, a content view is set as title view, then the image view is
      // added as child of the content view. Finally, using constraints the image view is aligned
      // inside its parent.
      let contentView = UIView()
      self.navigationItem.titleView = contentView
      self.navigationItem.titleView?.addSubview(imageView)
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }

}
