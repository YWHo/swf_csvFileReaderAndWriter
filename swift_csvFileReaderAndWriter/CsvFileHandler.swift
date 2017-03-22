//
//  CsvFileHandler.swift
//  swift_csvFileReaderAndWriter
//
//  Created by Brian Ho on 23/03/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class CsvFileHandler: NSObject {
    
    // Make Singleton
    static let sharedInstance = CsvFileHandler();
    private override init() {};
    
    func readDataFromFile(file: String) -> String? {
        
        guard let filePath = Bundle.main.path(forResource: file, ofType: "txt") else {
                
            return nil
        }
        
        do {
            let contents = try String(contentsOfFile: filePath);
            return contents
        } catch {
            print("File Read Error for file \(filePath)")
            return nil
        }
        
    }
    
    
    
}
