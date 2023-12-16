//
//  DetailedTrainingEnum.swift
//  Run
//
//  Created by Evgenii Kutasov on 11.12.2023.
//

enum EnumDetailedViewCell: Hashable {
    case detailedInfo(DetailedInfoViewModel)
    case detailedResult(DetailedResultViewModel)
    case detailedEveryKilometer(DetailedEveryKilometrViewModel)
    case detailedPulse(DetailedPulseViewModel)
    case detailedMap(DetailedMapViewModel)
}
