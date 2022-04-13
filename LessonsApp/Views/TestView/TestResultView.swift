//
//  TestResultView.swift
//  LessonsApp
//
//  Created by Kevin Tierney on 4/13/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var correctAnswers = 0
    
    var body: some View {
        
        VStack{
            Spacer()
            
            Text(resultText)
                .font(.title)
            
            Spacer()
            
            Text("you got \(correctAnswers) out of \(model.currentModule?.test.questions.count ?? 0) questions correct")
                
            Spacer()
            
            Button{
                model.currentTestSelected = nil
            } label:{
                
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height:48)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            Spacer()
            
        }
    }
    
    var resultText:String{
        
        let percent = Double(correctAnswers) / Double(model.currentModule?.test.questions.count ?? 0)
        
        if percent > 0.5 {
            return "Awesome"
        }
        else if percent > 0.2 {
            return "good Job"
        }
        else{
            return "Need some work"
        }
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView()
    }
}
