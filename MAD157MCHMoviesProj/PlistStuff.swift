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
        return documentDirectoryURL.appendingPathComponent("dictionaryKam1.plist")
        //.. this "file" (above) gets hidden in a really long complicated directory -  I used the error msg, terminal, and Atom to find directory/file and to open file to see .xml with movie "records"
        //.. Example of directory where plist is stored (not always the same) =
        //..   /Users/kam/Library/Developer/CoreSimulator/Devices/546DFFAC-C0F5-4FC6-9702-5D72DF9B8133/data/Containers/Data/Application/3AFC5C2A-7302-4734-A9AE-2DB6F32781F8/Documents/dictionaryKam1.plist
    }

    
    func savePropertyList(_ plist: Any) throws
    {
        print("..in savePropertyList - plist = \(plist)")
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        print("..plistData = \(plistData)")
        
        do {
            try plistData.write(to: plistURL)
            } catch {
                print("..plist write FAILED..")
            }
    }

    func loadPropertyList() throws -> [String:String]
    {
        print(".. in loadPropertyList")
        let data = try Data(contentsOf: plistURL)
        print("..data from plist = \(data)")
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            print(".. plist load FAILED..")
            return [:]
        }
        print("..movie plist currently has: \(plist)")
        return plist
    }


}
