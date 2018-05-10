//
//  WordPersistentAdapterProtocol.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 10/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation

protocol WordPersistentAdapterProtocol {
  func save(word: Word, saveWordResult: @escaping SaveWordResult)
  func fetchAll() -> [Word]?
}
