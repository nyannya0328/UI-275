//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/08/01.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    @State var posts : [Post] = []
    @Namespace var animation
    @State var currentTab = "Slide Now"
    var body: some View {
        VStack(spacing:15){
            
            VStack(alignment: .leading, spacing: 15) {
                
                Button {
                    
                } label: {
                    Label {
                        Text("Back")
                    } icon: {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                        
                    }
                    .foregroundColor(.primary)

                }
                Text("My Wishes")
                    .font(.title2)
                    .fontWeight(.black)

                
                
            }
            .padding()
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            HStack(spacing:0){
                
                
                TabButton(title: "Slide Now", animation: animation, currentTab: $currentTab)
                
                TabButton(title: "List", animation: animation, currentTab: $currentTab)
            }
            .background(.black.opacity(0.1))
            .padding(.horizontal)
            
            SnapCarsel(index: $currentIndex, items: posts) {post in
                
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    
                    Image(post.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width)
                        .cornerRadius(10)
                    
                    
                    
                    
                }
                
                
            }
            .padding(.vertical,40)
            HStack(spacing:15){
                
                ForEach(posts.indices,id:\.self){index in
                    
                    
                    
                    Circle()
                        .fill(.black.opacity(currentIndex == index ? 1 : 0.1))
                        .foregroundColor(.purple)
                        .frame(width: 10, height: 10)
                        .scaleEffect(currentIndex == index ? 1.5 : 1)
                        .animation(.spring(), value: currentIndex == index)
                }
                
                
                
                
            }
            .padding(.bottom,40)
        }
        .frame(maxHeight:.infinity,alignment: .top)
        .onAppear {
            
            for index in 1...7{
                
                posts.append(Post(imageURL: "p\(index)"))
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabButton : View{
    
    var title : String
    var animation : Namespace.ID
    @Binding var currentTab : String
    var body: some View{
        
        Button {
            withAnimation{
                
                currentTab = title
            }
        } label: {
            
            Text(title)
                .foregroundColor(currentTab == title ? .white : .black)
                .font(.title2.bold())
                .frame(maxWidth:.infinity)
                .padding(.vertical,10)
                .background(
                
                    ZStack{
                        
                        if currentTab == title{
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                            
                            
                        }
                    }
                
                )
            
            
        }

    }
}
