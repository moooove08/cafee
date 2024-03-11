//
//  CafeData.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 05.03.2024.
//

struct RegistrationData {
    
    
    var arrayCitys = [CityInforamation.dnipro.rawValue, CityInforamation.kyiv.rawValue,CityInforamation.kharkiv.rawValue,CityInforamation.lviv.rawValue]
    var sexInformation = ["Немає значення", "Чоловік", "Жінка"]
    
    enum CityInforamation: String, CaseIterable {
        case kyiv = "Київ"
        case kharkiv = "Харків"
        case dnipro = "Дніпро"
        case lviv = "Львів"
    }
}
