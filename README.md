# DBAssignment
Deutsche Bank Trade Assignment

Requirement: Write a program (in your preferred programming language) with all the test cases. TDD approach will be preferred. Time to complete the below assignment is 2 to 3 hrs.

Problem Statement
There is a scenario where thousands of trades are flowing into one store, assume any way of transmission of trades. We need to create a one trade store, which stores the trade in the following order

Trade Id	Version	Counter-Party Id	Book-Id	Maturity Date	Created Date	Expired
T1	1	CP-1	B1	20/05/2020	<today date>	N
T2	2	CP-2	B1	20/05/2021	<today date>	N
T2	1	CP-1	B1	20/05/2021	14/03/2015	N
T3	3	CP-3	B2	20/05/2014	<today date>	Y

There are couples of validation, we need to provide in the above assignment
1.	During transmission if the lower version is being received by the store it will reject the trade and throw an exception. If the version is same it will override the existing record.
2.	Store should not allow the trade which has less maturity date then today date.
3.	Store should automatically update the expire flag if in a store the trade crosses the maturity date.
Solution: iOS based application developed to showcase the solution. DBTrade Store App comprised three screen. App usage the Core data to store the data in the Application sandbox. 
	Application follow the protocol based MVVM Architectural pattern. 

Source code git url: https://github.com/rakeshj/DBAssignment.git













DBTradeStore mainly comprises the Three screen:
1)	Home page-> Home page will display when app launched. Home page will be empty in the first launch as there are no record created. Please follow the below image captured with no record and one record. 
   



 














2)	  Add Record screen:  We can create Trade record by navigating to Add Record screen by pressing the ” +” button. This screen is provisioned to add record. 

 













3)	Test Screen: 


   s

This screen let us to simulate all possible scenario which involved to develop the Trade Store. 



Technical Stack:
1)	 swift 5 iOS application. 
2)	CoreData being used to store the Trade record locally in the device. StoreManager.swift has all related implementation. 
3)	MVVM: Protocol based MVVM design pattern opted for project architecture. 
4)	Constants file hold the all constants.
5)	Unit test has been implemented for below view model:
a.	AddRecordViewModel
b.	HomeViewModel
c.	DBStoreManager

