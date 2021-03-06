//
//  Audio.swift
//  VKMusic
//

func ==(lhs: Audio, rhs: Audio) -> Bool {
    return lhs.url == rhs.url
}

import SwiftSoup

struct Audio: Equatable {
    
    var url = ""
    var title = ""
    var artist = ""
    var duration = 0
    
    init(url: String, title: String, artist: String , duration: Int) {
        self.url = url
        self.title = title
        self.artist = artist
        self.duration = duration
    }
    
    init(withElement element: Element) {
        var title = ""
        //ARTIST NAME:
        //print(try! element.child(1).select("span").array()[1].select("a").text())
        let artist = try! element.child(1).select("span").array()[1].select("a").text()
        //MP3 file name
        if try! element.child(1).select("span").array().count < 3 {
            //print(try! element.child(1).select("span").array()[1].select("span").first()?.text() ?? "")
            title = try! element.child(1).select("span").array()[1].select("span").first()?.text() ?? ""
        } else {
            //print(try! element.child(1).select("span").array()[2].select("span").first()?.text() ?? "")
            title = try! element.child(1).select("span").array()[2].select("span").first()?.text() ?? ""
        }
        //EXTRACT TRACK MP3 FILE
        let url = try! element.child(0).select("li").attr("data-url")
        //print(try! element.child(0).select("li").attr("data-url"))
        //GET DURATION
        let duration = try! element.child(2).text()
        
        self.url = url
        self.title = title
        self.artist = artist
        self.duration = duration.durationToInt
    }
}
