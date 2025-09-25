//
//  UserDetailView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 25/09/25.
//
import SwiftUI

struct UserDetailView: View {
    var userStory: UserStory?
    
    
    
    var body: some View {
        VStack{
            if let selectedItem = userStory {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("\(selectedItem.priorityEnum.rawValue)")
                                .font(.body)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 6)
                                .background {
                                    Capsule()
                                        .fill(selectedItem.priorityEnum.returnColor())
                                }
                        }
                        
                        HStack{
                            Image(systemName: "person")
                            Text(selectedItem.responsable)
                            
                            Text("\(Int.random(in: 0...7)) story Points")
                                .padding(.horizontal, 4)
                            
                            Text("\(0)/\(userStory?.tasks.count ?? 0) tasks completed")
                                .padding(.leading, 4)
                        }
                        
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
                                        .font(.body)
                                    Text(task.description)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    Text(task.role)
                                        .foregroundStyle(.white)
                                        .font(.body)
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 6)
                                        .background{
                                            Capsule()
                                                .fill(Role.cretateByString(name: task.role).returnColor())
                                        }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 0.5))
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
