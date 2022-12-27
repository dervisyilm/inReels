//
//  Reel.swift
//  Leap
//
//  Created by Dervis YILMAZ on 28.09.2022.
//

import Foundation
import AVKit

struct Reel: Identifiable{
    
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
