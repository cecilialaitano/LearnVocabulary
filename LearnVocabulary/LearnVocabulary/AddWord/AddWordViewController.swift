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
}


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
    saveButton.isEnabled = presenter.saveButtonIsEnable()
  }

  private func setup() {
    presenter = AddNewWordPresenter(view: self)
    setupView()
  }

  private func setupView() {
    definitionLabel.text = AddNewWordPresenter.getDefinitionTitle()
    newWordTextField.placeholder = AddNewWordPresenter.getAddWordPlaceholder()
    exampleLabel.text = AddNewWordPresenter.getExampleTitle()
    saveButton.setTitle(AddNewWordPresenter.getSaveButtonTitle(), for: .normal)
  }

  // MARK: - Actions
  @IBAction func onTapSaveButton(_ sender: Any) {

  }

}

extension AddWordViewController: AddWordProtocol {
  func displaySavedSucces() {
    // add implementation
  }
}
