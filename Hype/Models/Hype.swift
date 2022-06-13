//
//  Hype.swift
//  Hype
//
//  Created by Curt McCune on 6/13/22.
//

import Foundation
import CloudKit

struct HypeStrings {
    static let recordTypeKey = "Hype"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestamp = "timestamp"
}


class Hype {

    var body: String
    var timstamp: Date
    
    init(body: String, timestamp: Date = Date()) {
        self.body = body
        self.timstamp = timestamp
    }
}

extension Hype {
    /*
     Taking a retreived CKRecord and pulling out the values found to initialize our Hype Model. 
     */
    convenience init?(ckRecord: CKRecord) {
        guard let body = ckRecord[HypeStrings.bodyKey] as? String,
              let timestamp = ckRecord[HypeStrings.timestamp] as? Date
        else{ return nil }
        
        self.init(body: body, timestamp: timestamp)
                
    }
}

extension CKRecord {
    /*
     Packaging out Hyp model properties to be stored in a CKRecord and saved to the cloud
     */
    convenience init(hype: Hype) {
        self.init(recordType: HypeStrings.recordTypeKey)
//        self.setValue(hype.body, forKey: HypeStrings.bodyKey)
//        self.setValue(hype.timstamp, forKey: HypeStrings.timestamp)
        self.setValuesForKeys([
            HypeStrings.bodyKey : hype.body,
            HypeStrings.timestamp : hype.timstamp
        ])
    }
}
