//
//  UserResponse.swift
//  foodies
//
//  Created by Bryan Bramaskara on 25/03/25.
//

//import SwiftUI
//
//struct UserResponse: View {
//    let message: String
//    var body: some View {
//        HStack{
//            Spacer()
//            Text(message)
//                .padding()
//                .background(Color .green)
//                .foregroundColor(.white)
//                .cornerRadius(20)
//                .frame(maxWidth: UIScreen.main.bounds.width*0.7, alignment: .trailing)
//        }
//        .padding(.vertical, 4)
//    }
//}
//
//#Preview {
//    UserResponse(message: "Hello! This is a user message.")
//}
import SwiftUI

func UserResponse(_ message: String) -> some View {
    HStack {
        Spacer()
        Text(message)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(20)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
    }
    .padding(.vertical, 4)
}

#Preview {
    UserResponse("Hello! This is a user message.")
}
