//
//  ServiceCard.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import SwiftUI

struct ServiceCard: View {
    
    @State var service: Services
    @State var colorOfCard: Color = .indigo
    @State var date = ""
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Text(service.nameService.first?.description ?? "")
                        .foregroundColor(colorOfCard)
                        .font(.title)
                        .bold()
                }
                .padding(10)
                .background(colorOfCard.opacity(0.2))
                .clipShape(Rectangle())
                
                Text(service.nameService)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Text("₽" + service.paymenteveryMonth + " /")
                Text(date + "th")
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(Color.white.ignoresSafeArea())
        .cornerRadius(15)
        .padding()
        .onAppear() {
            let red = service.red
            let green = service.green
            let blue = service.blue
            
            let components = service.dayPayment.get(.day, .month, .year)
            let day = components.day ?? 0
            date = String(day)
            
            colorOfCard = Color(UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))
        }
    }
}

struct ServiceCard_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
