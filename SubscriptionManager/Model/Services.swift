//
//  Services.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import Foundation
import SwiftUI
import RealmSwift

class Services: Object, Identifiable {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var nameService = ""
    @objc dynamic var paymenteveryMonth = ""
    @objc dynamic var dayPayment: Date = Date()
    @objc dynamic var red: Float = 0.0
    @objc dynamic var green: Float = 0.0
    @objc dynamic var blue: Float = 0.0
}
