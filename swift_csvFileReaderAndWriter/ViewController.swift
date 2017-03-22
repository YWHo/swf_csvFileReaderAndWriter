//
//  ViewController.swift
//  swift_csvFileReaderAndWriter
//
//  Created by Brian Ho on 23/03/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - UIButton Action

    @IBAction func reportData(_ sender: UIButton) {
    }
    
    @IBAction func resetData(_ sender: UIButton) {
        textView.text = "Nope, no Pizza here"
    }
    
    @IBAction func readData(_ sender: UIButton) {
        textView.text = CsvFileHandler.sharedInstance.readDataFromFile(file: "data")
    }
    
    @IBAction func writeData(_ sender: UIButton) {
        if CsvFileHandler.sharedInstance.writeDataToFile(file: "data", textData: textView.text) {
            print("data written")
        } else {
            print("data not written")
        }
    }
    
    // MARK: - 
    
    
}

