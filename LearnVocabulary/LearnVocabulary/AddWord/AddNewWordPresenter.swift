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

  // MARK: Getters localized strings
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

  // MARK: - Save button
  func saveButtonIsEnable() -> Bool {
    //TODO: add implementation: is false if word & definition are empty.
    return true
  }

  // MARK: - New word TextField
  func validateWhitespaces(_ text: String?) -> String {
    if text?.trimmingCharacters(in: .whitespaces) == String() {
     return String()
    } else {
      return text ?? String()
    }
  }

  // MARK: - TextView Delegate
  func textViewShouldBeginEditing(text: String?, type: TextViewCase?) -> String {
    guard let textViewType = type else {
      return String()
    }

    switch textViewType {
      case .definition:
        if text == getDefinitionPlaceholder() {
          return String()
        }
      case .example:
        if text == getExamplePlacehololder() {
          return String()
        }
    }

    return text ?? String()
  }

  func textViewShouldEndEditing(text: String?, type: TextViewCase?) -> (placeholder: String, styleAsPlaceholder: Bool) {
    guard let textViewType = type else {
      return (String(), false)
    }
    var text = text ?? String()
    text = text.trimmingCharacters(in: .whitespacesAndNewlines)

    switch textViewType {
      case .definition:
        if text == String()  {
          return (getDefinitionPlaceholder(), true)
        }
      case .example:
        if text == String()  {
          return (getExamplePlacehololder(), true)
        }
    }
    return (text, false)
  }

  // MARK: Validate and Build Word
  func onTapSave(word: WordMaker) -> (isSuccess: Bool, error: String?) {
    let result = WordValidation().validate(wordMaker: word)
    if !result.isSuccess {
      return (false, result.error)
    }
    return build(word)
  }

  func build(_ wordMaker: WordMaker) -> (isSuccess: Bool, error: String?) {

    let word = WordDAL().createNewEntity(managedObject: Word())

    word.setValue(wordMaker.word!, forKey: "term")
    word.setValue(wordMaker.definition!, forKey: "definition")
    word.setValue(wordMaker.example, forKey: "example")

    do {
      try WordDAL().saveContext()
      return(true, nil)
    } catch {
      //TODO: Rewrite handle error
      return (false, "Some problem ocurre while trying to save data. Please try again")
    }
  }
}

