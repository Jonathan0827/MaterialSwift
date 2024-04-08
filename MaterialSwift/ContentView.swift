//
//  ContentView.swift
//  MaterialSwift
//
//  Created by 임준협 on 4/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(MButtonTypeList, id: \.hashValue) { type in
                    Button(action: {
                        
                    }, label: {
                        Text("Material Button")
                    })
                    .buttonStyle(MaterialButton(type: type))
                    Button(action: {
                        
                    }, label: {
                        Text("Material Button With Icon")
                    })
                    .buttonStyle(MaterialButton(type: type, icon: Image(systemName: "star")))
                    
                }
                HStack {
                    ForEach(MIconButtonTypeList, id: \.hashValue) { type in
                        MaterialIconButton(action: {
                            
                        }, icon: "star", type: type)
                    }
                }
                SegmentedButtons(maximumSelection: 3, buttons: [segmentedButton(text: "First", icon: "star"), segmentedButton(text: "Second", icon: "star"), segmentedButton(text: "Third", icon: "star", showIconOnSelect: true)])
            }

            
        }
    }
    
}
