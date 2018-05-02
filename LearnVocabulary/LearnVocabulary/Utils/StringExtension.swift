//
//  StringExtension.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 01/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation

extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
}
