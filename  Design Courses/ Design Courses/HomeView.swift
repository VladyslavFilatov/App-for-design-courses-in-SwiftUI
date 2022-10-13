//
//  HomeView.swift
//   Design Courses
//
//  Created by Vladyslav Filatov on 12/10/2022.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AvatarView(showProfile: $showProfile)
                    Spacer()

                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    RingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees: geometry.frame(in: .global).minX - 30) / -20, axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title)
                    .bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(widht: screen.width - 60, height: 275, section: sectionData[1])
                    .offset(y: -60)

                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    
    var widht: CGFloat = 275
    var height: CGFloat = 275
    var section: Section
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                Image(section.logo)
                    .frame(height: 25)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: widht, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
    
}

let sectionData = [
    Section(title: "Dising in SwiftUI", text: "50 lessons", logo: "Logo SwiftUI", image: Image("1"), color: Color(.sRGB, red:0.37140, green:0.05206, blue:0.73310)),
    Section(title: "Swift for Beginners", text: "30 lessons", logo: "Logo SwiftUI", image: Image("2"), color: Color(.sRGB, red:0.83472, green:0.05206, blue:0.20773)),
    Section(title: "Level Up in Swift", text: "35 lessons", logo: "Logo SwiftUI", image: Image("4"), color: Color(.sRGB, red:0.00000, green:0.61355, blue:0.72364)),
]

struct RingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12) {
                RingView(color1: Color(.sRGB, red:0.29814, green:0.05206, blue:0.73310), color2: Color(.sRGB, red:0.00000, green:0.77008, blue:0.95738), widht: 44, height: 44, percent: 68, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("7 minutes left")
                        .font(.subheadline)
                        .bold()
                    Text("Watched 15 minutes today")
                        .font(.caption)
                }
            } // HStack 7 minutes left
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            HStack(spacing: 12) {
                RingView(color1: Color(.sRGB, red:0.83391, green:0.08436, blue:0.05035), color2: Color(.sRGB, red:1.00000, green:0.50600, blue:0.12080), widht: 32, height: 32, percent: 54, show: .constant(true))
                
            } // HStack 54%
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            HStack(spacing: 12) {
                RingView(color1: Color(.sRGB, red:0.00000, green:0.71953, blue:0.08994), color2: Color(.sRGB, red:0.87775, green:0.11598, blue:0.96813), widht: 32, height: 32, percent: 32, show: .constant(true))
                
            } // HStack 32%
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        } // HStack RingsView
    }
}
