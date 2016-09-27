//
//  TheXMLParser.swift
//  iosAPP_Swift
//
//  Created by raymond on 9/27/16.
//  Copyright © 2016 raymond. All rights reserved.
//

import UIKit
import Alamofire

class TheXMLParser: NSObject, XMLParserDelegate{
    
    var newsArray: [NewsObject] = [NewsObject]()
    private var entry: String = ""
    private var newsItem: NewsObject?
    
    init(url: String) {
        super.init()
        let notif = Notification(name: Notification.Name.init("START_RETRIVE_NEWS_LIST"))
        NotificationCenter.default.post(notif)
        Alamofire.request(url).response { (response) in
            let parser = XMLParser(data: response.data!)
            parser.delegate = self
            self.newsItem = NewsObject()
            parser.parse()
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        entry = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName{
        case "newslist":
            if newsArray.count > 0 {
                for item in newsArray {
                    print(item)
                }
                parser.abortParsing()   //遇到newslist的元素结束标志, 不用再继续解析了
                let notif = Notification(name: Notification.Name.init("END_RETRIVE_NEWS_LIST"))
                NotificationCenter.default.post(notif)
            }
        case "news":
            newsArray.append(newsItem!)
            newsItem = NewsObject()
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch entry {
        case "id":
            newsItem?.id = string
        case "title":
            newsItem?.title = string
        case "body":
            newsItem?.body = string
        case "commentCount":
            newsItem?.commentCount = string
        case "author":
            newsItem?.author = string
        case "authorid":
            newsItem?.authorID = string
        case "pubDate":
            newsItem?.pubDate = string
        case "url":
            newsItem?.url = string
        case "type":
            newsItem?.newstype?.type = string
        case "authoruid2":
            newsItem?.newstype?.authoruID2 = string
        case "eventurl":
            newsItem?.newstype?.eventurl = string
        case "newstype":
            newsItem?.newstype = NewsType()
        default:
            break
        }
        entry = ""  //每次进来都需要置空, 否则一个元素字符串后面的其他符号会造成覆盖赋值
    }
}