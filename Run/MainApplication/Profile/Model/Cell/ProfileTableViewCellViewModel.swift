//
//  ProfileTableViewCellViewModel.swift
//  Run
//
//  Created by Лукичев Сергей on 03.09.2023.
//

import Foundation

struct ProfileTableViewCellViewModel: Hashable {
    let uuid: UUID = UUID()
    let type: CellType
}

extension ProfileTableViewCellViewModel {
    enum CellType {
        case editProfile
        case exit
        var cellTitle: String {
            switch self {
            case .editProfile: return "Редактировать профиль"
            case .exit: return "Выход"
            }
        }
    }
}
