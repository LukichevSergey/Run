//
//  UIImageView+SetImage.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(imageUrl: String, withCurvedCorners: Bool = true, completion: (() -> Void)? = nil) {
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        self.kf.setImage(with: URL(string: imageUrl),
                         options: withCurvedCorners ? [.transition(.fade(0.2)),
                                                       .processor(processor)] : [.transition(.fade(0.2))]) { _ in
            completion?()
        }
    }
    /// Выставляет картинку, либо стандартный плейсхолдер
    /// - Parameter placeholderKey: название картинки плейсхолдера
    /// - Parameter completion: блок заверешения
    func setImageWithPlaceholder(imageUrl: String?,
                                 placeholderKey: String = "imgPlaceholder",
                                 completion: (() -> Void)? = nil) {
        if let imageUrl = imageUrl, !imageUrl.trimm.isEmpty, imageUrl.isImage() {
            self.kf.setImage(with: URL(string: imageUrl),
                             options: [.transition(.fade(0.2)),
                                       .fromMemoryCacheOrRefresh]) { [weak self] result in
                if case .failure = result {
                    self?.image = UIImage(named: placeholderKey)
                }
                completion?()
            }
        } else {
            image = UIImage(named: placeholderKey)
            completion?()
        }
    }
    /// Выставляет картинку, либо стандартный плейсхолдер
    /// - Parameter placeholderKey: название картинки плейсхолдера
    /// - Parameter completion: блок заверешения
    func setImageWithPlaceholderAndCompletionImage(imageUrl: String?,
                                                   placeholderKey: String = "imgPlaceholder",
                                                   completion: ((UIImage?) -> Void)? = nil) {
        if let imageUrl = imageUrl, !imageUrl.trimm.isEmpty, imageUrl.isImage() {
            self.kf.setImage(with: URL(string: imageUrl),
                             options: [.transition(.fade(0.2)),
                                       .fromMemoryCacheOrRefresh]) { result in
                switch result {
                case .failure:
                    completion?(nil)
                case .success(let imgResult):
                    completion?(imgResult.image)
                }
            }
        } else {
            image = UIImage(named: placeholderKey)
            completion?(nil)
        }
    }
}
