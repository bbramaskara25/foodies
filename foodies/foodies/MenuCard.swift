//
//  MenuCard.swift
//  foodies
//
//  Created by Eliza Vornia on 08/04/25.
//
import SwiftUI

struct MenuCard: View {
    var stall: Stall
    
    var body: some View {
        HStack{
            
            
            VStack(alignment: .leading){
                HStack{
                    Text(stall.name)
                        .font(.headline)
                    
                    Spacer()
                       
                }
               
                
                    HStack{
                        Image(systemName: "wallet.bifold.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.orange)
                            .frame(width: 14, height: 14)
                        
                        Text("5K-20K")
                            .font(.subheadline)
                          
                        
                    }
               
            }
       
        }
    }
}



#Preview {
    MenuCard(stall: Stall.all[0])
}
