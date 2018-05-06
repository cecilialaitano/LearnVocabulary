//
//  WordValidation.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 06/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation

enum WordBuilderError: String {
  case missingWord = "Word can not be empty."
  case missingDefinition = "Definition can not be empty."
}

struct WordValidation {

  func validate(wordMaker: WordMaker) -> (isSuccess: Bool, error: String?) {
    guard let word = wordMaker.word, word != String() else {
      return (false, WordBuilderError.missingWord.rawValue)
    }
    guard let definition = wordMaker.definition, definition != String() else {
      return (false, WordBuilderError.missingDefinition.rawValue)
    }
    return (true, nil)
  }
}
