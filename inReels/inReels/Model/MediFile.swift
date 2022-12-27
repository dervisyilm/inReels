//
//  MediFile.swift
//  Leap
//
//  Created by Dervis YILMAZ on 27.09.2022.
//

import Foundation

struct MediaFile: Identifiable {
    
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}
var MediaFileJSON = [

    MediaFile(url: "Reel1", title: "Apple Airtag....."),
    MediaFile(url: "Reel2", title: "Animal Corssing"),
    MediaFile(url: "Reel3", title: "Sponsorship"),
]
