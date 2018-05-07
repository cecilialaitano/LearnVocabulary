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
  @IBOutlet weak var definitionTextView: UITextView!
  @IBOutlet weak var exampleLabel: UILabel!
  @IBOutlet weak var exampleTextView: UITextView!
  @IBOutlet weak var saveButton: UIButton!

  // MARK: - Properties
  private var presenter: AddNewWordPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    displayEmpty()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Dismiss keyboard on touch screen
    view.endEditing(true)
  }

  private func setup() {
    presenter = AddNewWordPresenter(view: self)
    setupView()
  }

  private func setupView() {
    setType(definitionTextView, type: .definition)
    setType(exampleTextView, type: .example)
    definitionLabel.text = presenter.getDefinitionTitle()
    newWordTextField.placeholder = presenter.getAddWordPlaceholder()
    exampleLabel.text = presenter.getExampleTitle()
    saveButton.setTitle(presenter.getSaveButtonTitle(), for: .normal)
    definitionTextView.isEditable = true
    exampleTextView.isEditable = true
    definitionTextView.styleAs(placeholder: presenter.getDefinitionPlaceholder())
    exampleTextView.styleAs(placeholder: presenter.getExamplePlacehololder())
  }

  private func displayEmpty() {
    newWordTextField.text = String()
    definitionTextView.text = String()
    exampleTextView.text = String()
  }

  // MARK: - Actions
  @IBAction func onTapSaveButton(_ sender: Any) {
    let word = WordBuilder(word: newWordTextField.text,
                       definition: definitionTextView.text,
                       example: exampleTextView.text)

    presenter.onTapSave(word: word)
  }

  // MARK: - Setup TextView's Types
  func setType(_ textView: UITextView, type: TextViewCase) {
    textView.tag = type.rawValue
  }

  func getType(_ textView: UITextView) -> TextViewCase {
    return TextViewCase(rawValue: textView.tag)!
  }
}

extension AddWordViewController: AddWordProtocol {

  func displaySavedSucces() {
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
    return true
  }
}

extension AddWordViewController: UITextViewDelegate {
  //TODO: Automatically update placeholders and style while editing.
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    textView.text = presenter.textViewShouldBeginEditing(text: textView.text,
                                                   type: getType(textView))
    textView.styleAsFilled()
    return true
  }

  func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    let result = presenter.textViewShouldEndEditing(text: textView.text,
                                                    type: getType(textView))
    if result.styleAsPlaceholder {
      textView.styleAs(placeholder: result.placeholder)
    } 
    return true
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    textView.resignFirstResponder()
  }
}
