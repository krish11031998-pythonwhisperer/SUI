//
//  Images.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI
import SUI

struct ImageComponents: View  {
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVStack(alignment: .center, spacing: 10) {
				ImageView(url: "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png")
					.frame(size: .init(width: 100, height: 100))
					.clipContent(radius: 16)
					.containerize(title: "Rectangle Image".systemHeading1(color: .textColor),
								  subTitle: "Caption".systemBody(color: .textColor))
				
				ImageView(url: "https://weathereport.mypinata.cloud/ipfs/QmZJ56QmQpXQJamofJJYbR5T1gQTxVMhN5uHYfhvAmdFr8/85.png")
					.frame(size: .init(width: 100, height: 100))
					.clipContent(radius: 50)
					.containerize(title: "Circle Image".systemHeading1(color: .textColor), subTitle: "Caption".systemBody(color: .textColor))

			}
		}
//		.navigationTitle("Image Components")
//		.navigationBarTitleDisplayMode(.inline)
	}
}

