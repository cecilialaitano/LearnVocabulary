//
//  TextViewExtension.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 02/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {

  func styleAs(placeholder: String) {
    self.textColor = .gray
    self.text = placeholder
  }

  func styleAsFilled() {
    self.textColor = .black
  }
}
