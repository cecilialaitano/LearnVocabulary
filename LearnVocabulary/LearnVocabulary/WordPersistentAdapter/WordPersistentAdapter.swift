//
//  WordPersistentAdapter.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 10/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import CoreData

typealias SaveWordResult = (_ entity: Word?, _ error: String?) -> ()

struct WordPersistentAdapter: WordPersistentAdapterProtocol {

  func save(word: Word, saveWordResult: @escaping SaveWordResult) {
    WordDAL().save(word, saveWordCoreDataResult: { (entity, error) in
      if let error = error {
        saveWordResult(nil, error)
      } else {
        if let savedWord = entity {
          let resultWord = mapWord(savedWord)
          saveWordResult(resultWord, nil)
        }
      }
    })
  }

  func fetchAll() -> [Word]? {
    guard let wordsMO = WordDAL().fetchAllWords() else {
      return nil
    }
    var fetchedWords = [Word]()
    for word in wordsMO {
      if let mappedWord = mapWord(word) {
        fetchedWords.append(mappedWord)
      }
    }
    return fetchedWords
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
