//
//  AddTask.swift
//  TodoApp2
//
//  Created by Dima on 06.07.2021.
//

import SwiftUI

struct AddTask: View {
    
    @State private var name: String = ""
    @State private var attribute: String = ""
    @State public var date = Date()
    
    let attributes = ["Сила", "Ум", "Ответственность", "Отдых"]
 
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "m/d/y"
        return formatter
    }()
    
    @State var currentTaskingData = Tasking(title: "", timing: Date(), attribute: "Ответственность")
    
    @EnvironmentObject var homeModel: HomeViewModel
    
    @State var showDatePicker = false
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Button(action: {
                    
                    homeModel.addNewTasks.toggle()
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                })
                
                Spacer()
            }
            .overlay(
            Text("Добавить задачу")
            )
            
            VStack(alignment: .leading, spacing: 15){
                Text("Введите свою задачу")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                TextField("Hello", text: $currentTaskingData.title)
                    .font(.system(size: 16))
                
                Divider()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 15){
                Text("Время")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                HStack{
                    Text(currentTaskingData.timing, formatter: Self.stackDateFormat)
                
                    Spacer(minLength: 10)
                
                Button(action: {
                    
                    withAnimation{
                        showDatePicker.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Color.yellow)
                        .cornerRadius(20)
                    
                })
                    
                }
                Divider()
            }
            //.padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 15){
                Text("Выбор цвета карты")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                let color = [Color("Blue"), Color("Green"), Color("Purple"), Color("Red"), Color("Orange")]
                
                HStack(spacing: 12){
                    ForEach(color, id: \.self){color in
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 35)
                            .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .opacity(
                                    currentTaskingData.cardColor == color ? 1 : 0
                                    )
                            )
                            .onTapGesture {
                                currentTaskingData.cardColor = color
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            Spacer(minLength: 10)
            
            Button(action: {
                addTasking()
            }, label: {
                Text("Добавить")
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 30)
            })
            .foregroundColor(.black)
            .padding(6)
            .background(Color.black)
            .cornerRadius(20)
            .disabled(currentTaskingData.title == "")
            
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
        .background(Color("Bg"))
        .overlay(CustomDatePicker(date: $currentTaskingData.timing,
                                  showPicker: $showDatePicker))
        .transition(.move(edge: .bottom))
        
    }
    func addTasking(){
        withAnimation{
            homeModel.taskings.append(currentTaskingData)
            homeModel.addNewTasks.toggle()
        }
    }
}

struct CustomDatePicker: View{
    
    @Binding var date:  Date
    @Binding var showPicker: Bool
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color("Bg"))
                .edgesIgnoringSafeArea(.all)
                
            
            DatePicker("", selection: $date, displayedComponents: [.date])
                .labelsHidden()
                .background(Color("Grey"))
            
            Button(action: {
                
                withAnimation{
                    showPicker.toggle()
                }
                
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .opacity(0.3)
                    .cornerRadius(20)
            })
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .opacity(showPicker ? 1 : 0)
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
