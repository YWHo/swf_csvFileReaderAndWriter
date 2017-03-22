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
    
    // Other methods
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
    
    func writeDataToFile(file:String, textData: String?) -> Bool{
        
        // check that our data exists
        guard let data = textData else {return false}
        print("Data to write: \(data)\n")
        
        //get the file path for the file in the bundle
        // if it doesn't exist, make it in the bundle
        var fileName = file + ".txt"
        if let filePath = Bundle.main.path(forResource: file, ofType: "txt") {
            fileName = filePath
        } else {
            fileName = Bundle.main.bundlePath + fileName
        }
        
        //write to file, return true if it works, false otherwise.
        do{
            try data.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
            return true
        } catch{
            return false
        }
        
    }
    
    
    
}
