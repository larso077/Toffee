//
//  MediaInfo.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/21/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class MediaInfo {
    var mediaId: Int
    var createdBy: Person?
    var mediaTitle: String?
    var messageText: String?
    var photoSrc: String?
    var videoSrc: String?
    var createdDate: Date?
    var expirationDate: Date?
    var hasBeenViewed: Bool = false
    var actualImage: UIImage?
    var mediaToken: String?
    
    init(mediaId: Int) {
        self.mediaId = mediaId
    }
    
    convenience init(mediaId: Int, mediaTitle: String, photoSrc: String?, videoSrc: String?) {
        self.init(mediaId: mediaId)
        
        self.mediaTitle = mediaTitle
        self.photoSrc = photoSrc
        self.videoSrc = videoSrc
    }
    
    convenience init(values: [String: Any?]) {
        let mediaId = values["MediaId"] as? Int ?? -1
        let mediaTitle = values["MediaTitle"] as? String ?? ""
        let mediaSrc = values["MediaSrc"] as? String ?? ""
        let siteURL = KPService.siteURLString
        
        var photoSource: String?
        var videoSource: String?
        
        if mediaSrc.suffix(3) == "mp4" {
            videoSource = "\(siteURL)/\(mediaSrc)"
        } else if mediaSrc != "" {
            photoSource = "\(siteURL)/\(mediaSrc)"
        }
        
        self.init(mediaId: mediaId, mediaTitle: mediaTitle, photoSrc: photoSource, videoSrc: videoSource)
        
        createdDate = values["CreatedDate"] as? Date
        expirationDate = values["ExpirationDate"] as? Date
        hasBeenViewed = values["HasBeenViewed"] as? Bool ?? false
        messageText = values["MessageText"] as? String
        mediaToken = values["MediaToken"] as? String
    }
}
