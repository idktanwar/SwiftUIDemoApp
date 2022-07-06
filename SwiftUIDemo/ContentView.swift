//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Dinesh Tanwar on 06/07/22.
//

import SwiftUI

let W = UIScreen.main.bounds.width
struct TabItem {
    var icon: Image?
    var title: String
}

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    let tabs: [TabItem] = [
        .init(title: "Tab 1"),
        .init(title: "Tab 2"),
        .init(title: "Tab 3")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Tabs
            Tabs(tabs: tabs, geoWidth: W, selectedTab: $selectedTab)
            // Content
            ProductDetailsContentView(selectedTab: $selectedTab)
            
            Spacer()
            
            Divider()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProductDetailsContentView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<3) { i in
                            switch (i)  {
                            case 0:
                                test()
                                .frame(width: W, height: 450)
                                .background(Color.yellow)
                                .padding(.bottom, 10)
                                .id(i)
                                
                            case 1:
                                test()
                                .frame(width: W, height: 450)
                                .background(Color.green)
                                .padding(.bottom, 10)
                                .id(i)
                                
                            case 2:
                                test()
                                .frame(width: W, height: 450)
                                .background(Color.pink)
                                .padding(.bottom, 10)
                                .id(i)
                        
                            default:
                                EmptyView()
                                    .id(i)
                            }
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target, anchor: .top)
                        }
                    }
                }
            }
        }
        .background(Color(UIColor(red: 246 / 255, green: 249 / 255, blue: 250 / 255, alpha: 1)))
    }
    
    @ViewBuilder
    func test() -> some View {
        VStack(spacing: 20) {
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
            
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
            Text("Example 1")
        }
    }
}

struct Tabs: View {
    var fixed = true
    var tabs: [TabItem]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                                        
                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                            .accentColor(Color.white)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .background(Color(UIColor(red: 35.0/255.0, green: 117.0/255.0, blue: 187.0/255.0, alpha: 1.0)))
    }
}
