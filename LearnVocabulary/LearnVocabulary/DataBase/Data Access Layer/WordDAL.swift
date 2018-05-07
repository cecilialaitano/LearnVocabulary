//
//  WordDAL.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 06/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import CoreData

typealias SaveWordResult = (_ entity: Word?, _ error: String?) -> ()

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
  func saveWord(_ word: Word, saveWordResult: SaveWordResult) {
    let wordMO = createNewEntity(managedObject: WordMO())
    wordMO.setValue(word.term, forKey: termKey)
    wordMO.setValue(word.definition, forKey: definitionKey)
    wordMO.setValue(word.example, forKey: exampleKey)

    let wordResult = mapWord(wordMO)

    do {
      try saveContext()
      saveWordResult(wordResult, nil)
    } catch let error {
      saveWordResult(wordResult, error.localizedDescription)
    }
  }

  // MARK: - Entity Fetchs
  func fetchAllWords() -> [Word]? {
    guard let wordsMO = fetchAll() as? [WordMO] else {
      return nil
    }
    var fetchedWords = [Word]()
    for wordMO in wordsMO {
      if let newWord = mapWord(wordMO) {
        fetchedWords.append(newWord)
      }
    }
    return fetchedWords
  }

  func fetchHighlightedWords() -> [WordMO]? {
    let predicate = NSPredicate(format: "%@ == %@", isHighlightedKey, true)
    guard let wordsHighlighted = fetch(with: predicate) as? [WordMO] else {
      return nil
    }
    return wordsHighlighted
  }

  //MARK: - Private
  private func mapWord(_ wordMO: NSManagedObject) -> Word? {
    guard let wordMO = wordMO as? WordMO else {
      return nil
    }
    guard let term = wordMO.term else {
      return nil
    }
    guard let definition = wordMO.definition else {
      return nil
    }
    return Word(
      term: term,
      definition: definition,
      example: wordMO.example,
      isHighlighted: wordMO.isHighlight
    )
  }

}
