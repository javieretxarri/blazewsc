//
//  AudioModel.swift
//
//
//  Created by Nacho on 11/3/24.
//

import Foundation

public struct AudioModel: Decodable, Hashable {
    public let audio: AudioDataModel
    
    public init(audio: AudioDataModel) {
        self.audio = audio
    }
}

public struct AudioDataModel: Decodable, Hashable {
    public let id: String
    public let name: String
    public let url: String
    public let type: String?
    public let fileName: String?
    public let format: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
        case type = "type"
        case fileName = "fileName"
        case format = "format"
    }
    
    public init(id: String, name: String, url: String, type: String?, fileName: String?, format: String) {
        self.id = id
        self.name = name
        self.url = url
        self.type = type
        self.fileName = fileName
        self.format = format
    }
}

extension AudioDataModel {
    public static let preview = AudioDataModel(id: "97368d36-0506-41cd-912b-b9b1a906f4db",
                                        name: "prueba multimedia audio prueba 1",
                                        url: "https://statics-des-maker.llt-services.com/7x7h591vluoijvs740za/documents/2023/10/23/790829f6-69ab-4b2d-b146-42bea116633a-749.mp3",
                                        type: "mp3",
                                        fileName: "Bizarrap-Quevedo-Quedate-Tiesto-Remix.mp3",
                                        format: "audio")
}


extension AudioModel {
   public static let preview = AudioModel(audio: .preview)
}
