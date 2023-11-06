//
//  FileManager.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 5/11/23.
//

import Foundation

class DoFile{
  //--------------------------------------------------------------------
  //Variables
  private let FILENAME = "DolistM"
  private let DocumetDirUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  //--------------------------------------------------------------------
  func write(text: String){
    let fileURL = DocumetDirUrl.appendingPathComponent(FILENAME).appendingPathExtension("txt")
    //log(object: "File Path: \(fileURL.path)")
    do{
      try text.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    }catch let error as NSError{
      log(object: "Failed to write to URL/n \(error)")
    }
  }
  func read()-> String{
    let fileURL = DocumetDirUrl.appendingPathComponent(FILENAME).appendingPathExtension("txt")
    var readString = ""
    do{
      readString = try String(contentsOf: fileURL)
    }catch let error as NSError{
      log(object: "Failed to read file \(error)")
      write(text: "")
    }
    return readString
  }
}
