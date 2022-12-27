//
//  MainViewModel.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import Foundation
import SwiftUI
import RealmSwift
import Combine

class MainViewModel: ObservableObject {
    
    @Published var nameService = ""
    @Published var paymentEveryMonth = ""
    @Published var dayPayment = Date()
    
    @Published var services: [Services] = []
    
    @Published var showAddWindow = false
    
    @Published var height = 700
    
    @Published var red: Float = 0.0
    @Published var green: Float = 0.0
    @Published var blue: Float = 0.0
    
    func fetchDataFromDataBase() {
        guard let dbRef = try? Realm() else { return }

        let results = dbRef.objects(Services.self)

        self.services = results.compactMap({ (service) -> Services in
            return service
        })
    }
    
    func addNewService() {
        red = Float.random(in: 0...1)
        green = Float.random(in: 0...1)
        blue = Float.random(in: 0...1)
        
        let services = Services()
        services.nameService = nameService
        services.paymenteveryMonth = paymentEveryMonth
        services.dayPayment = dayPayment
        services.red = red
        services.green = green
        services.blue = blue
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write{
            dbRef.add(services)
            
            fetchDataFromDataBase()
        }
        
        self.height = 700
        self.showAddWindow = false
        clearData()
    }
    
    func deleteService(object: Services) {
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write{
            dbRef.delete(object)
            
            fetchDataFromDataBase()
        }
    }
    
    func clearData() {
        nameService = ""
        paymentEveryMonth = ""
        dayPayment = Date()
    }
}
