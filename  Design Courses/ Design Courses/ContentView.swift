//
//  ContentView.swift
//   Design Courses
//
//  Created by Vladyslav Filatov on 11/10/2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero // all values about moving elements will be displayed in this property
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation.default
                        .delay(0.1), value: showCard)

            
            BackCardView()
                .frame(width: showCard ? 300 : 340,height: 220)
                .background(show ? Color(.sRGB, red:1.00000, green:0.00000, blue:0.41700) : Color(.sRGB, red:0.33544, green:0.00000, blue:0.63340))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10 , y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.5), value: showCard)
            
            
            
            BackCardView()
                .frame(width: 340,height: 220)
                .background(show ? Color(.sRGB, red:0.33544, green:0.00000, blue:0.63340) : Color(.sRGB, red:1.00000, green:0.00000, blue:0.41700))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(y: showCard ? -140 : 0)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5)) // if show true = 0 else 5º
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10 , y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.3), value: showCard)

            
            CardView()
                .frame(width: showCard ? 375 : 340, height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                //.cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3,
                                   dampingFraction: 0.6,
                                  blendDuration: 0), value: viewState)
                .onTapGesture {
                    self.showCard.toggle() // change from false to true

                }
                .gesture(
                    DragGesture().onChanged{ value in
                        self.viewState = value.translation // when moving elements around the screen, "value" will change and current "value" will be written to the viewState properties
                        self.show = true // when you start moving elements, all elements are opened
                    }
                        .onEnded{ value in
                            self.viewState = .zero
                            self.show = false
                            
                        }
                 )
            
    //    Text("\(bottomState.height)").offset(y: -300)
            
            ButtonCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                .gesture(
                    DragGesture().onChanged{ value in
                        self.bottomState = value.translation
                        if self.showFull {
                            self.bottomState.height += -300
                        }
                        if self.bottomState.height < -300 {
                            self.bottomState.height = -300
                        }
                    }
                        .onEnded{ value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < 250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                            
                            
                        }
                )

            
        } // ZStack -
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading) {
                    Text("Dising in SwiftUI")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Сertificate")
                        .foregroundColor(Color("Primary"))
                } // VStack - Text("Dising in SwiftUI")
                
                Spacer()
                
                Image("Logo SwiftUI")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .offset(y: -10)
                
            } // VStack - Image logo
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Image("2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 110, alignment: .top)
        } // VStack - Image 2

    }
}

struct BackCardView: View {
    var body: some View {
        VStack{
            
            Spacer()
            
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Spacer()
        } // title Text("Certificate")
    }
}

struct ButtonCardView: View {
    
    @Binding var show: Bool

    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("Learning the features of design development in SwiftUI")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
                
            HStack(spacing: 20) {
                RingView(color1: Color(.sRGB, red:0.00000, green:0.83190, blue:0.95528), color2: Color(.sRGB, red:0.44378, green:0.11598, blue:0.96813), widht: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut(duration: 0.9).delay(0.3), value: show)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Dising in SwiftUI")
                        .bold()
                    Text("39 of 50 lessons completed")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            
            Spacer()
            
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color("Background 3"))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
