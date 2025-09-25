//
//  UserDetailView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 25/09/25.
//
import SwiftUI

//struct UserDetailView: View {
//    var userStory: UserStory?
//    
//    var priorityColor: Color {
//        var color: Color = .red
//        if let priorityNumber = userStory?.priority {
//            let priority = Priority.cretateByNumber(number: priorityNumber)
//            color = priority.returnColor()
//        }
//       return color
//    }
//    
//    var body: some View {
//        VStack{
//            if let selectedItem = userStory {
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(selectedItem.shortDescription)
//                                .font(.largeTitle)
//                            
//                            Capsule()
//                                .fill(priorityColor)
//                                .overlay(
//                                    Text("\(selectedItem.priority)")
//                                        .font(.largeTitle)
//                                )
//                                .frame(maxWidth: 200)
//                        }.padding(.vertical)
//                        
//                        Text("Description:")
//                            .font(.headline)
//                            .padding(.vertical, 4)
//                        
//                        Text("\(selectedItem.description)")
//                            .font(.body)
//                            .padding(.vertical, 4)
//                        
//                        Text("Acceptance Criteria:")
//                            .font(.headline)
//                            .padding(.vertical, 4)
//                        
//                        ForEach(selectedItem.acceptanceCriteria, id: \.self){ criteria in
//                            Text(criteria)
//                                .font(.body)
//                        }
//                        .padding(.bottom, 8)
//                        
//                        Text("Tasks:")
//                            .font(.headline)
//                            .padding(.vertical, 4)
//                        
//                        ForEach(selectedItem.tasks, id: \.name) { task in
//                            HStack{
//                                Text(task.name)
//                                    .font(.title)
//                                Text(task.role)
//                                    .font(.title2)
//                                Text("\(task.priority)")
//                                    .font(.title)
//                                    .foregroundStyle(.red)
//                            }
//                            
//                            Text(task.description)
//                                .font(.body)
//                        }
//
//                    }.frame(maxWidth: .infinity, alignment: .leading)
////                    .border(.red)
//                }.padding()
//                    .border(.blue)
//            }
//        }
//    }
//}

struct UserDetailView: View {
    var userStory: UserStory?
    
    var priorityColor: Color {
        var color: Color = .red
        if let priorityNumber = userStory?.priority {
            let priority = Priority.cretateByNumber(number: priorityNumber)
            color = priority.returnColor()
        }
        return color
    }
    
    var priority: Priority {
        if let userStory = userStory {
            Priority.cretateByNumber(number: userStory.priority)
        } else {
            .high
        }
        
    }
    
    var body: some View {
        VStack{
            if let selectedItem = userStory {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                                .bold()
                            
                            Capsule()
                                .fill(priorityColor)
                                .overlay(
                                    Text("\(priority.rawValue)")
                                        .font(.title3)
                                )
                                .frame(maxWidth: 200)
                        }.padding(.vertical)
                
                        Text(selectedItem.description)
                            .font(.body)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Acceptance Criteria")
                                .font(.title2)
                                .bold()
                            
                            ForEach(selectedItem.acceptanceCriteria, id: \.self) { item in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                        .imageScale(.medium)
                                    Text(item)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }.cardStyle
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Tasks")
                                .font(.title2)
                                .bold()

                            ForEach(selectedItem.tasks, id: \.name) { task in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(task.name)
                                        .font(.title2)
                                    Text(task.description)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    Text(task.role)
                                        .foregroundStyle(.white)
                                        .font(.body)
                                        .padding(6)
                                        .background{
                                            Capsule()
                                                .fill(Role.cretateByString(name: task.role).returnColor())
                                        }

                                }
                            }
                        }.cardStyle
                    }
                }.padding()
            }
        }
    }
}

extension View {
    var cardStyle: some View {
        self
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemFill))
            )
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
