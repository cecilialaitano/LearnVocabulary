//
//  DataAccessLayer.swift
//  LearnVocabulary
//
//  Created by Cecilia Laitano on 04/05/2018.
//  Copyright © 2018 panadie. All rights reserved.
//

import Foundation
import CoreData

class DataAccessLayer<T: NSManagedObject>: NSObject {

  private let context = DataController.sharedInstance.persistentContainer.viewContext

  // MARK: - Create and save managed objects
  func createNewEntity(managedObject: T) -> NSManagedObject {
    let entity = NSEntityDescription.insertNewObject(forEntityName: entityName(), into: context)
    return entity
  }

  func saveContext() throws {
    do {
      try context.save()
    } catch let error {
      //TODO: Review the option to Add rollback.
      //fatalError("Failure to save context: \(error)")
      throw error
    }
  }

  // MARK: - Fetching Objects
  func fetchAll() -> [T] {
    let entityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName())
    do {
      let entities = try context.fetch(entityFetch) as! [T]
      return entities
    } catch let error {
      //TODO: handle error
      fatalError("Some error ocurr while trying to retrive data from core data \(error)")
    }
  }

  func fetch(with predicate: NSPredicate) -> [T] {
    let entityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName())
    entityFetch.predicate = predicate

    do {
      let entities = try context.fetch(entityFetch) as! [T]
      return entities
    } catch let error {
      //TODO: handle error
      fatalError("Some error ocurr while trying to retrive data from core data \(error)")
    }
  }

  // MARK: - Override point
  func entityName() -> String {
    return String()
  }
}


