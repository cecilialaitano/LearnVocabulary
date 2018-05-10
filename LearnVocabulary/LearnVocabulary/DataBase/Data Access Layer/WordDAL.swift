//
//  WordDAL.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 06/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import CoreData

typealias DataAccessResult = (_ entity: [WordMO]?, _ error: String?) -> ()
typealias SaveWordCoreDataResult = (_ entity: WordMO?, _ error: String?) -> ()

class WordDAL: DataAccessLayer<NSManagedObject> {
  private let entity = "WordMO"
  private let termKey = "term"
  private let definitionKey = "definition"
  private let exampleKey = "example"
  private let isHighlightedKey = "isHighlighted"

  override func entityName() -> String {
    return entity
  }

  // MARK: - Create entity
  func save(_ word: Word, saveWordCoreDataResult: SaveWordCoreDataResult) {
    let wordMO = createNewEntity(managedObject: WordMO()) as! WordMO
    wordMO.setValue(word.term, forKey: termKey)
    wordMO.setValue(word.definition, forKey: definitionKey)
    wordMO.setValue(word.example, forKey: exampleKey)

    do {
      try saveContext()
      saveWordCoreDataResult(wordMO, nil)
    } catch let error {
      saveWordCoreDataResult(wordMO, error.localizedDescription)
    }
  }

  // MARK: - Entity Fetchs
  func fetchAllWords() -> [WordMO]? {
    guard let wordsMO = fetchAll() as? [WordMO] else {
      return nil
    }
    return wordsMO
  }

  func fetchHighlightedWords() -> [WordMO]? {
    let predicate = NSPredicate(format: "%@ == %@", isHighlightedKey, true)
    guard let wordsHighlighted = fetch(with: predicate) as? [WordMO] else {
      return nil
    }
    return wordsHighlighted
  }
}
