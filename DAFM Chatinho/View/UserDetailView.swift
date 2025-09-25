//
//  UserDetailView.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//
import SwiftUI

struct UserDetailView: View {
    var userStory: UserStory?
    var body: some View {
        VStack{
            if let selectedItem = userStory {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                        }
                        
                        Text(selectedItem.description)
                            .font(.body)
                        
                        ForEach(selectedItem.acceptanceCriteria, id: \.self){ criteria in
                            Text(criteria)
                                .font(.headline)
                        }
                        
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
                        .border(.red)
                    
                    
                }.padding()
                    .border(.blue)
            }
        }
    }
}
