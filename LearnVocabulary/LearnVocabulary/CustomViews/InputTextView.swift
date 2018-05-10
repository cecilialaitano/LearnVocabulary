//
//  InputTextView.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 07/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import UIKit

enum InputType {
  case definition
  case example
  case other
}

enum InputState {
  case filled
  case empty
}

class InputTextView: UITextView {
  // MARK: - Properties
  var type: InputType = InputType.other
  var placeholder: String?
  var state: InputState = .empty {
    didSet {
      switch state {
        case .filled:
          styleAsFilled()
        case .empty:
          text = placeholder
          styleAsEmpty()
      }
    }
  }

  // MARK: - Initial setup
  func setupInputTextView(type: InputType, placeholder: String, state: InputState, text: String? = nil) {
    self.type = type
    self.placeholder = placeholder
    self.text = text
    self.state = state
    self.isEditable = true
  }

  private func styleAsEmpty() {
      textColor = .gray
  }

  private func styleAsFilled() {
      textColor = .black
  }
}
