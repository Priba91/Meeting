//
//  FileManagerExtension.swift
//  Linguado
//
//  Created by Bojan Markovic on 03/09/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

extension FileManager {
    open func contentsOfDirectoryDateEnumerated(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
        
        let documentsDirectory = self.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if let urlArray = try? FileManager.default.contentsOfDirectory(at: documentsDirectory,
                                                                       includingPropertiesForKeys: [.contentModificationDateKey],
                                                                       options:.skipsHiddenFiles) {
            
            let orderedFullPaths = urlArray.sorted(by: { (url1: URL, url2: URL) -> Bool in
                do {
                    let values1 = try url1.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    let values2 = try url2.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    
                    if let date1 = values1.creationDate, let date2 = values2.creationDate {
                        return date1.compare(date2) == ComparisonResult.orderedDescending
                    }
                } catch _{
                    
                }
                return true
            })
            
            return orderedFullPaths
            
        } else {
            return []
        }
    }
}
