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

  // MARK: Initial setup view's titles
  static func getDefinitionTitle() -> String {
    return "Definition".localized()
  }

  static func getExampleTitle() -> String {
    return "Example".localized()
  }

  static func getAddWordPlaceholder() -> String {
    return "New word".localized()
  }

  static func getSaveButtonTitle() -> String {
    return "Save".localized()
  }

  // MARK: - Save button
  func saveButtonIsEnable() -> Bool {
    //add implementation: is false if word & definition are empty.
    return true
  }

}

