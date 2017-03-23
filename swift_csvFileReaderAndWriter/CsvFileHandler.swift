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
    
    private var data:[[String:String]] = []
    private var columnTitles:[String] = []
    
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
    
    private func cleanRows(text:String)->String{
        var cleanFile = text
        
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        
        return cleanFile
    }
    
    private func convertCSV(text: String) {
        let rows = cleanRows(text: text).components(separatedBy: "\n")
        
        if rows.count > 0 {
            
            data = []
            columnTitles = getStringFieldsForRow(row:rows.first!, delimiter:",")
            for row in rows{
                let fields = getStringFieldsForRow(row:row, delimiter:",")
                if fields.count != columnTitles.count {continue}
                
                var dataRow = [String:String]()
                for (index, field) in fields.enumerated() {
                    let fieldName = columnTitles[index]
                    dataRow[fieldName] = field
                }
                data += [dataRow] // append into data array
            }
            
        } else {
            
            print("No data in file")
            
        }
    }
    
    private func getStringFieldsForRow(row:String, delimiter:String)-> [String] {
        return row.components(separatedBy: delimiter)
    }
    
    func formatData(text: String) -> String {
        convertCSV(text: text)
        var tableString = ""
        var rowString = ""
        
        print("data: \(data)")
        for row in data {
            rowString = ""
            for fieldName in columnTitles{
                guard let field = row[fieldName] else{
                    print("field not found: \(fieldName)")
                    continue
                }
                rowString += String(format:"%@     ",field)
            }
            tableString += rowString + "\n"
        }
        
        return tableString

    }
}
