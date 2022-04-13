//
//  TestView.swift
//  LessonsApp
//
//  Created by Kevin Tierney on 4/13/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submited = false
    
    var body: some View {
        
        
        if model.currentQuestion != nil{
            
            VStack(alignment:.leading){
                
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                
                CodeTextView()
                    .padding(.horizontal, 20)
                // Answer
                ScrollView{
                    
                    VStack{
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button{
                                // track the selected index
                                selectedAnswerIndex = index
                            }
                        label: {
                            ZStack{
                                
                                if submited == false{
                                    RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                        .frame(height:48)
                                }
                                
                                else{
                                    // Answer has been submitted
                                    
                                    if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex{
                                        
                                        // User has selected the right answer
                                        // Show a green Background
                                        RectangleCard(color: .green)
                                            .frame(height:48)
                                        
                                    }
                                    
                                    else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                        
                                        // User has selected the wrong answer
                                        // Show a red Background
                                        RectangleCard(color: .red)
                                            .frame(height:48)
                                    }
                                    
                                    else if index == model.currentQuestion!.correctIndex{
                                        
                                        // This button is the correct answer
                                        // Show a green Background
                                        RectangleCard(color: .green)
                                            .frame(height:48)
                                    }
                                    else{
                                        
                                        RectangleCard(color: .white)
                                            .frame(height:48)
                                    }
                                }
                                
                                Text(model.currentQuestion!.answers[index])
                                
                            }
                            
                        }
                        .disabled(submited)
                            
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // Button
                
                Button{
                    // check if answer has been submitted
                    if submited == true {
                        
                        // answer has been submitted move to next questions
                        model.nextQuestion()
                        
                        // reset properties
                        
                        submited = false
                        selectedAnswerIndex = nil
                        
                    }
                    else{
                        
                        // submit the answer
                        // change submitted state to true
                        submited = true
                        //submit answer and check if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect+=1
                        }
                    }
                 
                    
                }label:{
                    
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height:48)
                        
                            Text(buttonText)
                                .bold()
                                .foregroundColor(.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        }
        
        else{
            
            TestResultView( correctAnswers: numCorrect)
        }
        
        
    }
    
    var buttonText:String {
        
        // check if annswer has been submitted
        if submited == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                return "Finish"
            }
            else{
                return "Next Question"
            }
           
        }
        else{
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
