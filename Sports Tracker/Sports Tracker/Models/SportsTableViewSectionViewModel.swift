//
//  SportsTableViewSectionViewModel.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 22/09/2024.
//

import Foundation

struct SportsTableViewSectionViewModel {
    var id = UUID()
    var sportImageName: String
    var title: String
    var isCollapsed: Bool
    var content: [EventCellViewModel]
    
    mutating func updateContentFavoriteWithID(_ id: UUID, favorite: Bool) {
        guard let index = self.content.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        var mutableContentElement = self.content[index]
        mutableContentElement.updateFavorite(isFavorite: favorite)
        
        var mutableContent = content
        mutableContent[index] = mutableContentElement
        
        mutableContent.sort(by: { $0.targetDate < $1.targetDate })
        mutableContent.sort(by: { $0.isFavorite == true && $1.isFavorite == false })
        
        self.content = mutableContent
    }
}

struct EventCellViewModel {
    var id = UUID()
    var targetDate: Date
    var info: String
    var isFavorite: Bool
    
    var participant1: String {
        return String(describing: info.split(separator: "-").first ?? "")
    }
    
    var participant2: String {
        return String(describing: info.split(separator: "-").last ?? "")
    }
    
    mutating func updateFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
