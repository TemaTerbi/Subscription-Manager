//
//  Home.swift
//  SubscriptionManager
//
//  Created by Артем Соловьев on 27.12.2022.
//

import SwiftUI
import SwiftUICalendar

struct Home: View {
    
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(alignment: .center) {
                        Text("Service:")
                        
                        Spacer()
                        
                        Text("Payment every month:")
                            .frame(width: 100)
                            .lineLimit(3)
                    }
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.secondary)
                    .padding()
                    ScrollView {
                        ForEach(mainViewModel.services.reversed()) { service in
                            ServiceCard(service: service)
                                .contextMenu {
                                    Button {
                                        mainViewModel.deleteService(object: service)
                                    } label: {
                                        Text("Delete Service")
                                    }

                                }
                                .frame(maxHeight: 55)
                        }
                        .animation(.spring(), value: mainViewModel.services)
                    }
                    
                    Spacer()
                }
                .background(Color.indigo.opacity(0.1))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            mainViewModel.showAddWindow = true
                            mainViewModel.height = -70
                        } label: {
                            Image(systemName: "plus.viewfinder")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                AddNewServiceWindow()
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .offset(CGSize(width: 0, height: mainViewModel.height))
                    .animation(.spring(), value: mainViewModel.height)
                    .environmentObject(mainViewModel)
            }
        }
        .preferredColorScheme(.light)
        .onAppear() {
            mainViewModel.fetchDataFromDataBase()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
