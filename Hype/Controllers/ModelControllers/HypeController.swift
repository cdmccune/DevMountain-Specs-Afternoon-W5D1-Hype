//
//  HypeController.swift
//  Hype
//
//  Created by Curt McCune on 6/13/22.
//

import Foundation
import CloudKit

class HypeController {
    
    
    
    
    static let shared = HypeController()
    
    var hypes: [Hype] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD
    
    //Create
    func saveHype(with text: String, completion: @escaping(Bool)->Void) {
        //Initialize hype object
        let newHype = Hype(body: text)
        //turn into a ckrecord
        let hypeRecord = CKRecord(hype: newHype)
        //Call the db save function to save ckrecord to the cloud
        publicDB.save(hypeRecord) { record, error in
            //handle errpr
            if let error = error {
                print("error in \(#function) : \(error.localizedDescription), \(error)")
                completion(false)
                return
            }
            //unwrapping record and checking integrity of new hype object initalized
            guard let record = record,
                  let savedHype = Hype(ckRecord: record)
            else {return completion(false)}
            //Adding to sot array
            print("saved hype successfully")
            self.hypes.insert(savedHype, at: 0)
            return completion(true)
        }
    }
    
    //Fetch
    func fetchHypes(completion: @escaping (Bool)-> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: HypeStrings.recordTypeKey, predicate: predicate)
        
    var toAddHypeList: [Hype] = []
        
        publicDB.fetch(withQuery: query) { result in
            switch result {
            case .success((let matchResults, _)):
                matchResults.forEach { (_, matchResult) in
                    switch matchResult {
                    case .success(let record):
                        print("fetched hype")
                        if let hype = Hype(ckRecord: record) {
                            toAddHypeList.append(hype)
                            return completion(true)
                        } else {
                            return completion(false)
                        }
                      
                    case .failure(let error):
                        print(error)
                        return completion(false)
                    }
                }
                self.hypes = toAddHypeList
            case .failure(let error):
                print(error)
                return completion(false)
            }
        }
    }
}
