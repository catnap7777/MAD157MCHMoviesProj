//
//  PlistStuff.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/24/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import Foundation


class PlistStuff {
    
    var plistURL : URL {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent("dictionarykaren1.plist")
    }

    
    func savePropertyList(_ plist: Any) throws
    {
        print("in savePropertyList - plist = \(plist)")
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        print("plistData = \(plistData)")
        
        do {
            try plistData.write(to: plistURL)
            } catch {
                print("yup, didn't save it")
            }
    }
//        do {
//            try typeTextHere.text.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
//        } catch {
//            print("Error writing file")
//        }
//    }


    func loadPropertyList() throws -> [String:String]
    {
        print("trying to load the stupid plist")
        let data = try Data(contentsOf: plistURL)
        print("data from trying to load plist  == \(data)")
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            print("that didn't work")
            return [:]
        }
        print("my plist has: \(plist)")
        return plist
    }


}
