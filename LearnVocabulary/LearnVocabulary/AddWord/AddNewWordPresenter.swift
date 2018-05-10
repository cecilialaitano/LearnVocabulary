//
//  AddNewWordPresenter.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 01/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation

class AddNewWordPresenter {

  // MARK: - Properties
  private var view: AddWordProtocol?

  init(view: AddWordProtocol) {
    self.view = view
  }

  // MARK: Getters titles & placeholder
  func getDefinitionTitle() -> String {
    return "Definition".localized()
  }

  func getExampleTitle() -> String {
    return "Example".localized()
  }

  func getAddWordPlaceholder() -> String {
    return "New word".localized()
  }

  func getSaveButtonTitle() -> String {
    return "Save".localized()
  }

  func getDefinitionPlaceholder() -> String {
    return "Definition Placeholder".localized()
  }

  func getExamplePlacehololder() -> String {
    return "Example Placeholder".localized()
  }

  // MARK: - TextField input validation
  func validateWhitespaces(_ text: String?) -> String {
    return WordValidation.removeWhitespacesIfNeeded(text)
  }

  // MARK: - TextView Delegate
  func textViewShouldBeginEditing(text: String?, type: InputType) -> String {
    switch type {
      case .definition:
        if text == getDefinitionPlaceholder() {
          return String()
        }
      case .example:
        if text == getExamplePlacehololder() {
          return String()
        }
      default:
      break
    }
    return text ?? String()
  }

  func textViewShouldEndEditing(text: String?, type: InputType) -> (placeholder: String, styleAsPlaceholder: Bool) {
    var text = text ?? String()
    text = text.trimmingCharacters(in: .whitespacesAndNewlines)

    switch type {
      case .definition:
        if text == String()  {
          return (getDefinitionPlaceholder(), true)
        }
      case .example:
        if text == String()  {
          return (getExamplePlacehololder(), true)
        }
      default: break
    }
    return (text, false)
  }

  // MARK: Validate and Build Word
  func onTapSave(word: WordBuilder) {
    let result = WordValidation().validate(wordBuilder: word)
    if !result.isSuccess {
      view?.displaySaveError(result.error ?? "Some error occur")
    }
    guard let term = word.word else {
      return
    }
    guard let definition = word.definition else {
      return
    }
    let newWord = Word(term: term, definition: definition, example: word.example, isHighlighted: false)

    //TODO: Add a WordPersistenceAdapter class to call WordDAL there instead of.
    WordDAL().saveWord(newWord, saveWordResult: { (word, error) in
      if let error = error {
        view?.displaySaveError(error)
      } else {
        view?.displaySavedSucces()
      }
    })
  }
}
