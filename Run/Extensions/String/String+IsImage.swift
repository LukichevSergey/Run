//
//  String+IsImage.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import UIKit

extension String {

    public func isImage() -> Bool {
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }

        return false
    }

    public func getExtension() -> String? {
       let ext = (self as NSString).pathExtension

       if ext.isEmpty {
           return nil
       }

       return ext
    }

    public func isURL() -> Bool {
       return URL(string: self) != nil
    }
}
