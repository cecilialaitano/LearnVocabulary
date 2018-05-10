//
//  AddWordViewController.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 01/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import UIKit

protocol AddWordProtocol {
  func displaySavedSucces()
  func displaySaveError(_ error: String)
}

enum TextViewCase: Int {
  case definition = 0
  case example = 1
}

typealias WordBuilder = (word: String?, definition:String?, example: String?)

class AddWordViewController: UIViewController {

  @IBOutlet weak var newWordTextField: UITextField!
  @IBOutlet weak var definitionLabel: UILabel!
  @IBOutlet weak var exampleLabel: UILabel!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var definitionTextView: InputTextView!
  @IBOutlet weak var exampleTextView: InputTextView!
  
  // MARK: - Properties
  private var presenter: AddNewWordPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Dismiss keyboard on touch screen
    view.endEditing(true)
  }

  private func setup() {
    //TODO: Add adapter with factory class
    presenter = AddNewWordPresenter(view: self, adapter: WordPersistentAdapter())
    setupView()
  }

  private func setupView() {
    definitionTextView.setupInputTextView(
      type: .definition,
      placeholder: presenter.getDefinitionPlaceholder(),
      state: .empty)
    exampleTextView.setupInputTextView(
      type: .example,
      placeholder: presenter.getExamplePlacehololder(),
      state: .empty)
    
    definitionLabel.text = presenter.getDefinitionTitle()
    newWordTextField.placeholder = presenter.getAddWordPlaceholder()
    exampleLabel.text = presenter.getExampleTitle()
    saveButton.setTitle(presenter.getSaveButtonTitle(), for: .normal)
  }

  private func displayEmpty() {
    newWordTextField.text = String()
    definitionTextView.state = .empty
    exampleTextView.state = .empty
  }

  // MARK: - Actions
  @IBAction func onTapSaveButton(_ sender: Any) {
    let word = WordBuilder(word: newWordTextField.text,
                       definition: definitionTextView.text,
                       example: exampleTextView.text)

    presenter.onTapSave(word: word)
  }
}

extension AddWordViewController: AddWordProtocol {

  func displaySavedSucces() {
    //TODO: display status alert
    let alertSaved = UIAlertController(title: "Saved", message: nil, preferredStyle: .alert)
    alertSaved.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      self.displayEmpty()
    }))
    present(alertSaved, animated: true, completion: nil)
  }

  func displaySaveError(_ error: String) {
    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension AddWordViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.text = presenter.validateWhitespaces(textField.text)
    textField.resignFirstResponder()

    //TODO: Suggestion - Add a magnyifing glass if the word has definition in apple dictionary,
    //so user can touch and see it definition.
    // on tap magnyfing glass open definition

//    let word = "home"
//    if UIReferenceLibraryViewController.dictionaryHasDefinitionForTerm(word) {
//      let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: word)
//      self.presentViewController(ref, animated: true, completion: nil)
//    }

    return true
  }
}

extension AddWordViewController: UITextViewDelegate {

  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    guard let inputTextView = textView as? InputTextView else {
      return false
    }
    textView.text = presenter.textViewShouldBeginEditing(text: inputTextView.text,
                                                           type: inputTextView.type)
    inputTextView.state = .filled
    return true
  }

  func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    guard let inputTextView = textView as? InputTextView else {
      return false
    }
    let result = presenter.textViewShouldEndEditing(text: inputTextView.text,
                                                    type: inputTextView.type)
    if result.styleAsPlaceholder {
        inputTextView.state = .empty
    }
    return true
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    textView.resignFirstResponder()
  }
}
