//
//  ContentView.swift
//  Leap
//
//  Created by Dervis YILMAZ on 27.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    // Hiding Tabbar
    init(){
        
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "home"
    
    var body: some View {
        
        VStack(spacing: 0){
            
            TabView(selection: $currentTab){
                
                Home()
                    .tag("home")
                
                Text("Pro")
                    .tag("crown")
                
                Text("Library")
                    .tag("library")
                
                Text("Profile")
                    .tag("profile")
            }
            HStack(spacing: 0){
                // simple creating array for images....
                
                ForEach(
                    ["home", "crown", "library", "profile"], id: \.self) { image in
                        
                        TabBarButton(image: image, currentTab: $currentTab)
                        
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(currentTab == "home" ? .black : .clear)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TabBar Button
struct TabBarButton : View {
    
    var image: String
    @Binding var currentTab: String
    
    var body: some View{
        
        Button{
            withAnimation{currentTab = image}
        } label: {
            
            ZStack{
             
                VStack{
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                    Text(image)
                }
            }
            .foregroundColor(currentTab == image ? currentTab == "home" ? .white : .primary : .gray)
            .frame(maxWidth: .infinity)
            
        }
    }
}
