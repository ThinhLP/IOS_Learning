//
//  Student.swift
//  StudentManagement
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class Student {
  var name: String
  var university: String
  var age: Int
  var description: String
  
  init(name: String, university: String, age: Int, description: String) {
    self.name = name
    self.university = university
    self.age = age
    self.description = description
  }
}
