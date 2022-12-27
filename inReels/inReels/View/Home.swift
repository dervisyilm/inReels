//
//  Home.swift
//  Leap
//
//  Created by Dervis YILMAZ on 27.09.2022.
//

import SwiftUI
import AVKit

struct Home: View {
    
    @State var currentReel = ""
    
    // Extracting AVPlayer from media file...
    @State var reels = MediaFileJSON.map{ item -> Reel in
        
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel(player: player, mediaFile: item)
        
    }
    
    var body: some View {
        
        // Setting width and height for rotated view....
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            // Vertical Page TabView...
            TabView(selection: $currentReel){
                
                ForEach($reels){ $reel in
                
                    ReelsPlayer(reel: $reel,currentReel: $currentReel)
                    .frame(width: size.width)
                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                    .tag(reel.id)
                }
                
            }
            .onAppear{
                currentReel = reels.first?.id ?? ""
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
  
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
        //ContentView()
    }
}

struct ReelsPlayer: View{
    
    @Binding var reel: Reel
    @Binding var currentReel: String
    
    @State var isMuted = false
    @State var volumeAnimation = false
    
    var body: some View{
        
        ZStack{
            
            if let player = reel.player{
                CustomVideoPlayer(player: player)
                GeometryReader{ proxy -> Color in
                    
                    let minY = proxy.frame(in:.global).minY
                    let size = proxy.size
                    
                    DispatchQueue.main.async{
                        if -minY < (size.height / 2) && minY < (size.height / 2)
                            && currentReel == reel.id{
                            
                            player.isMuted = isMuted
                            player.play()
                            
                        }else{
                            
                            player.pause()
                        }
                        
                    }
                    return Color.clear
                    
                }
                VStack{
                    HStack(alignment: .bottom){
                        
                        VStack(spacing: 10){
                            
                            // MARK: Use Template Button
                            
                            
                            Button(action: {
                                
                                print("use template button")
                                
                            }) {
                                ZStack{
                            
                                    HStack{
                                        Spacer()
                                        
                                        Text("Use Template")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .font(.custom("Trap-Bold", size: 20))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .cornerRadius(15)
                                    
                                }
                            
                            }
                            .frame(width: 300, height: 75, alignment: .center)
                            .background(Color(red: 197/255, green: 40/255, blue: 61/255))
                            
                            .cornerRadius(30)
                            
                            HStack(spacing: 15){
                                
                                Text("Duration:")
                                    .foregroundColor(.white)
                                Text("00:21")
                                    .foregroundColor(.white)
                                
                                Text("Clips:")
                                    .foregroundColor(.white)
                                Text("8")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                    }
                    
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(Circle())
                    .foregroundColor(.black)
                    .opacity(volumeAnimation ? 1 : 0)
                
            }
            
        }
        .onTapGesture {
            if volumeAnimation {
                return
            }
            isMuted.toggle()
            reel.player!.isMuted = isMuted
            withAnimation{volumeAnimation.toggle()}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
                withAnimation{volumeAnimation.toggle()}
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        
    }
}
