//
//  UserDetailView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 25/09/25.
//
import SwiftUI

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
    
    var body: some View {
        VStack{
            if let selectedItem = userStory {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                            
                            Capsule()
                                .fill(priorityColor)
                                .overlay(
                                    Text("\(selectedItem.priority)")
                                        .font(.largeTitle)
                                )
                                .frame(maxWidth: 200)
                        }.padding(.vertical)
                        
                        Text("Description:")
                            .font(.headline)
                            .padding(.vertical, 4)
                        
                        Text("\(selectedItem.description)")
                            .font(.body)
                            .padding(.vertical, 4)
                        
                        Text("Acceptance Criteria:")
                            .font(.headline)
                            .padding(.vertical, 4)
                        
                        ForEach(selectedItem.acceptanceCriteria, id: \.self){ criteria in
                            Text(criteria)
                                .font(.body)
                        }
                        .padding(.bottom, 8)
                        
                        Text("Tasks:")
                            .font(.headline)
                            .padding(.vertical, 4)
                        
                        ForEach(selectedItem.tasks, id: \.name) { task in
                            HStack{
                                Text(task.name)
                                    .font(.title)
                                Text(task.role)
                                    .font(.title2)
                                Text("\(task.priority)")
                                    .font(.title)
                                    .foregroundStyle(.red)
                            }
                            
                            Text(task.description)
                                .font(.body)
                        }

                    }.frame(maxWidth: .infinity, alignment: .leading)
//                    .border(.red)
                }.padding()
                    .border(.blue)
            }
        }
    }
}
