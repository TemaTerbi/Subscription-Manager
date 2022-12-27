//
//  AddNewServiceWindow.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import SwiftUI
import SwiftUICalendar

struct AddNewServiceWindow: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        mainViewModel.showAddWindow = false
                        mainViewModel.height = 700
                        mainViewModel.clearData()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                
                Spacer()
                
                TextField("Name of Service", text: $mainViewModel.nameService)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Paymanet Every Month", text: $mainViewModel.paymentEveryMonth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                
                DatePicker("Payment day", selection: $mainViewModel.dayPayment)
                
                Button {
                    mainViewModel.addNewService()
                } label: {
                    VStack {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(Color.indigo)
                    .cornerRadius(15)
                }
                .contentShape(Rectangle())
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.white.ignoresSafeArea())
        .cornerRadius(50)
        .padding(.horizontal, 15)
        .environmentObject(mainViewModel)
        .onDisappear() {
            mainViewModel.clearData()
        }
        .shadow(radius: 70)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct AddNewServiceWindow_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK: - Some Extension for date and hide keyboard

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
