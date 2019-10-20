//
//  main.swift
//  homeworkfour
//
//  Created by Nikita Boiko on 20/10/2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation

enum CarActions: String {
    case startEngine = "Запуск двигателя"
    case stopEngine = "Остановка двигателя"
    case openWindows = "Открытие окон"
    case closeWindows = "Закрытие окон"
    case getInTrunk = "Загрузка кузова"
    case getOffTrunk = "Разгрузка кузова"
}

enum CustomAtions: String {
    case trunkActionUp = "Поднятие кузова"
    case trunkActionDown = "Опускание кузова"
    case sportActionStartNitro = "Включение закиси азота"
    case sportActionStopNitro = "Отключение закиси азота"
}

class Car {
    var brand: String
    var year: Int
    var volume: UInt
    var isStartEngine: Bool
    var isOpenWindows: Bool
    var currentVolume: UInt
    
    init(brand: String, year: Int, volume: UInt) {
        self.brand = brand
        self.year = year
        self.volume = volume
        isOpenWindows = false
        isStartEngine = false
        currentVolume = 0
    }
    
    func action(actionType: CarActions, volume: UInt = 0) {
        switch actionType {
        case .startEngine:
            isStartEngine = true
            print("У автомобиля \(brand): Двигатель запущен")
        case .stopEngine:
            isStartEngine = false
            print("У автомобиля \(brand): Двигатель заглушен")
        case .openWindows:
            isOpenWindows = true
            print("У автомобиля \(brand): Окна открыты")
        case .closeWindows:
            isOpenWindows = false
            print("У автомобиля \(brand): Окна закрыты")
        case .getInTrunk:
            let amount = volume + currentVolume
            if amount > self.volume {
                currentVolume = self.volume
                print("У автомобиля \(brand): Превышен допустимый объем. \(amount - self.volume) осталось не загружено")
            } else {
                currentVolume += volume
            }
            print("У автомобиля \(brand): Текущая загрузка составляет \(currentVolume)")
        case .getOffTrunk:
            let amount = Int(currentVolume - volume)
            if amount < 0 {
                currentVolume = 0
                print("У автомобиля \(brand): Автомобиль разгружен полностью.")
            } else {
                currentVolume -= volume
            }
            print("У автомобиля \(brand): Текущая загрузка составляет \(currentVolume)")
        }
    }
    
    func customAction(action: CustomAtions) {
        print("Выполняется действие: \(action.rawValue)")
    }
    
}

class SportCar: Car {
    var nitro: Bool = false
    
    override func customAction(action: CustomAtions) {
        if action == .sportActionStartNitro || action == .sportActionStopNitro {
            super.customAction(action: action)
            nitro(action: action)
            
        } else {
            print("этот автомобиль не предназначен для выполнения этого действия")
        }
    }
    
    private func nitro(action: CustomAtions) {
        if !super.isStartEngine {
            print("Двигатель выключен. Включение нитро бесполезно")
            return
        }
        sleep(3)
        if action == .sportActionStartNitro {
            nitro = true
            print("Закись азота включена")
        } else {
            nitro = false
            print("Закись азота выключена")
        }
    }
}

class TruсkCar: Car {
    var dumpRaised: Bool = false
    
    override func customAction(action: CustomAtions) {
        if action == .trunkActionUp || action == .trunkActionDown {
            super.customAction(action: action)
            raiseDump(action: action)
        } else {
            print("этот автомобиль не предназначен для выполнения этого действия")
        }
    }
    
    private func raiseDump(action: CustomAtions) {
        sleep(3)
        if action == .trunkActionUp {
            dumpRaised = true
            print("Кузов поднят")
            print("Груз сброшен")
            super.currentVolume = 0
        } else {
            dumpRaised = false
            print("Кузов опущен")
        }
    }
}

let nissanGTR = SportCar(brand: "Nissan", year: 2009, volume: 200)
let scaniaTruck = TruсkCar(brand: "Scania", year: 2017, volume: 3000)

nissanGTR.customAction(action: .sportActionStartNitro)
scaniaTruck.action(actionType: .getInTrunk, volume: 1000)
scaniaTruck.customAction(action: .trunkActionUp)
nissanGTR.action(actionType: .startEngine)
nissanGTR.customAction(action: .sportActionStartNitro)
