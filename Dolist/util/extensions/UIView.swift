//
//  UIView.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

extension UIView{
  @IBInspectable var cornerRadius: CGFloat {
   get{return layer.cornerRadius}
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable var cornerTop: CGFloat {
   get{return layer.cornerRadius}
    set {
      clipsToBounds = true
      layer.cornerRadius = newValue
      layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
  }
  
  @IBInspectable var shadowColor: UIColor? {
    get {return UIColor(cgColor: layer.shadowColor!)}
    set {layer.shadowColor = newValue?.cgColor}
  }
  
  @IBInspectable var shadowRadius: CGFloat {
    get {return layer.borderWidth}
    set {
      layer.borderWidth = newValue
      layer.shadowOffset = .zero
      layer.shadowOpacity = 0.4
    }
  }
}
