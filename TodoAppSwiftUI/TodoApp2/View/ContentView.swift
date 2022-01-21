//
//  Home.swift
//  TodoApp2
//
//  Created by Dima on 06.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationButton: Bool = false
    @Namespace var animationID
    @State var currnetTab = "Не выполнено"
    @StateObject var homeModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
//                Text("Привет, юзер")
//                    .font(.title3)
//                    .kerning(1.1)
//                    .frame(maxWidth: .infinity,
//                           alignment: .leading)

                HStack(alignment: .bottom){
                    Text("Просмотр всех задач:")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                }
                .padding(.top, 8)
                

                if homeModel.taskings.isEmpty{
                    Image("confetti")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.top, 140)
                    
                    Text("Задачи отсутствуют")
                        .font(.title2)
                        .padding(.top)
                }
                
                VStack(spacing: 15){
                    ForEach(homeModel.taskings){tasking in
                        TasksCardView(tasking: tasking)
                    }
                }
                .padding(.top, 20)
                
            }
            .padding()
            
        }
        
        .overlay(
            ZStack{
                Group{
                    Circle()
                        .fill(Color.gray)
                        .opacity(self.animationButton ? 0.2 : 0)
                        .scaleEffect(self.animationButton ? 1 : 0)
                        .frame(width: 68, height: 68, alignment: .center)
                    Circle()
                        .fill(Color.gray)
                        .opacity(self.animationButton ? 0.15 : 0)
                        .scaleEffect(self.animationButton ? 1 : 0)
                        .frame(width: 88, height: 88, alignment: .center)
                }
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: self.animationButton)
                
            Button(action: {
                homeModel.addNewTasks.toggle()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .background(Circle().fill(Color.white))
                    .foregroundColor(Color.gray)
                    .frame(width: 48, height: 48, alignment: .center)
                })
            .onAppear(perform: {
                self.animationButton.toggle()
            })
                
            }//: ZSTACK
            .padding(.bottom, 15)
            .padding(.trailing, 15)
            , alignment: .bottomTrailing
            )
        
        .padding(.top, 45)
        .background(Color("Bg"))
        .edgesIgnoringSafeArea(.all)
        .overlay(
            ZStack{
                if homeModel.addNewTasks{
                    AddTask().environmentObject(homeModel)
                }
            }
        )
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
