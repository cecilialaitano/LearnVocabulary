//
//  ListWordsViewController.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 01/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import UIKit

class ListWordsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear(_ animated: Bool) {
    if let words = WordPersistentAdapter().fetchAll() {
      for w in words {
        print(w.term)
        print(w.definition)
        print(w.example ?? String())
      }
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
