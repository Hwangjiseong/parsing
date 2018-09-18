//
//  ViewController.swift
//  parsing
//
//  Created by D7703_08 on 2018. 9. 17..
//  Copyright © 2018년 D7703_08. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate,UITableViewDataSource {
    
    //딕셔너리 배열
    var elements : [[String:String]] = []
    
    //배열
    var item : [String:String] = [:]
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
//            if let myParser = XMLParser(contentsOf: path) {
//                // XMLParserDelegate와 ViewController와 connection
//                myParser.delegate = self
//
//                if myParser.parse() {
//                    print("Parsing succed!")
//                    print(elements)
//                } else {
//                    print("Parsing failed!")
//                }
//
//            } else {
//                print("parser nil")
//            }
//        } else {
//            print("XML file not found!")
//        }
//
//    }
        
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        if NSURL(string: strURL) != nil {
            if let parser = XMLParser(contentsOf: NSURL(string: strURL)! as URL) {
                parser.delegate = self
                
                if parser.parse() {
                    print("parsing success")
                    print(elements)
                } else {
                    print("parsing fail")
                }
                
            }
        }
        
        myTableView.delegate = self
        myTableView.dataSource = self
        

    }
    
    //XMLParserDelegate 메소드 호출
    //1. tag(element)fmf 만났을때 호출
    @IBOutlet weak var myTableView: UITableView!
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //print("currentElement = \(currentElement)")
    }
    //2. 문자열을 만났을때 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            item[currentElement] = data
        }
    }
    //3. tage을 끝을 만났을때 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
        
    }
    // TableVeiw Delegate 메소드 호출
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
        {
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        let myItem = elements[indexPath.row]
            myCell.textLabel?.text = "Name : " + myItem["name"]!
            myCell.detailTextLabel?.text = "Cost : " + myItem["cost"]!
        return myCell
    }
}

