//
//  HomePresenter.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import Foundation
class HomeViewModel{
  weak private var view: HomeView?
  
  init(view: HomeView? = nil) {
    self.view = view
  }
}
