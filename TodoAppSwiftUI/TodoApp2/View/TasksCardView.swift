//
//  TasksCardView.swift
//  TodoApp2
//
//  Created by Dima on 06.07.2021.
//

import SwiftUI

struct TasksCardView: View {
    
    var tasking: Tasking
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "m/d/y"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 20){
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 12){
                    
                    Text(tasking.timing, formatter: Self.stackDateFormat)
                        .font(.caption)
                    
                    Text(tasking.title)
                        .font(.title2)
                        .bold()
                    
                    Text(tasking.attribute)
                        .font(.caption)
                }
                Spacer(minLength: 0)
            }
            
            HStack{
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }, label: {
                    Text("Выполнить")
                        .foregroundColor(.black)
                        .font(.system(size: 13, /*weight: .bold,*/ design: .default))
                        .frame(width: 100, height: 40)
                        .background(Color.white)
                        .cornerRadius(30)
                })
            }
        }
        .padding()
        .background(tasking.cardColor)
        .cornerRadius(10)
    }
    
    func getColor() -> Color {
        if tasking.cardColor == Color("Purple") || tasking.cardColor == Color("Red"){
        return .white
        }
        return .black
    }
    
}

struct TasksCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
