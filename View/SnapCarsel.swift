//
//  SnapCarsel.swift
//  SnapCarsel
//
//  Created by nyannyan0328 on 2021/08/01.
//

import SwiftUI

struct SnapCarsel<Content:View,T : Identifiable>: View {
    
    var content : (T) -> Content
    var list : [T]
    var trailingSpace : CGFloat
    var spacing : CGFloat
    
    
    @Binding var index : Int
    
    
    init(spacing : CGFloat = 15,trailingSpace : CGFloat = 100,index : Binding<Int>,items : [T],@ViewBuilder content : @escaping(T)->Content){
        
        
        self.content = content
        self.list = items
        self.trailingSpace = trailingSpace
        self.spacing = spacing
        self._index = index
        
        
    }
    
    @State var currentIndex : Int = 0
    @GestureState var offset : CGFloat = 0
    
    var body: some View{
        
        GeometryReader{proxy in
            
            
            let width = proxy.size.width - (trailingSpace - spacing)
            
            let adustWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing:15){
                
                ForEach(list){item in
                    
                    
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                       
                }
                
                
                
            }
            .padding(.horizontal,spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adustWidth : 0) + offset)
            .gesture(
            
                DragGesture().updating($offset, body: { value, out, _ in
                    
                    
                    out = value.translation.width
                })
                    .onEnded({ value in
                        
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                       currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                    currentIndex = index
                        
                    })
                    .onChanged({ value in
                        
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                       index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                   
                        
                    })
            
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
    
    
    
}

struct SnapCarsel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
