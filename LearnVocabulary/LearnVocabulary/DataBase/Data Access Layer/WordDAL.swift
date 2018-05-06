//
//  WordDAL.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 06/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import CoreData

enum WordKeys: String {
  case isHighlighted = "isHighlighted"
}

class WordDAL: DataAccessLayer<NSManagedObject> {

  override func entityName() -> String {
    return "Word"
  }

  // MARK: - Entity Fetchs
  func fetchHighlightedWords() -> [Word]? {
    let predicate = NSPredicate(format: "%@ == %@", WordKeys.isHighlighted.rawValue, true)
    guard let wordsHighlighted = fetch(with: predicate) as? [Word] else {
      return nil
    }
    return wordsHighlighted
  }
}
