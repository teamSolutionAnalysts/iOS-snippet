Read Me 


This sample project is created to showcase architecture, environment setup, use of customer configurable and reusable components, how we make api calls, how we handle data , how we map data.  To demonstrate above mentioned purpose we have create simple Login , signup screen flow .

	▪	Environment Setup : This sample project is configured for three environment: development, stage and production , this will help us to manage single code for all three different env.  

	▪	Login/Signup UI : in this project we have created login and signup screen using Auto layout. Which is compatible with all mobile iOS devices.

	▪	Custom configurable components: we are using our own create custom configurable components to create UI . So that with minimum line of code we can have different ui with single component. Ex. CustomTextField: this is a custom object using which we can crate different text filed UI .

	▪	Project Architecture: we are using MVVM architecture so that we can make viewcontroler thiner. We can manage code in different separate area so that it is easy to manage and debug code.

	▪	Extensions for Native Component : for all native components like Button, textField, Label, String, we have created extensions to provide UI level and logic level functions. Make code reusable and easy to use 
 
	▪	API Call : we have also done setup for api call, which include how to make call, how to handle response . This reusable utility is easy to use whenever its needed.

	▪	Data Mapping: we are using apple’s default Codable class protocols to make data models to map data, which is secure way to handle data 

	▪	Data storing : we are using apples user  Default  to store login user data 

	▪	User define Build setting : for providing app level  constant like base urls, api keys we are using user defined build setting , using plist we ar accessing data from build setting . Which allow us to set this kind of properties based on environment . Without doing any code level change we can access same parameter for different environment.

	▪	Helper Class : To use all above mentioned utilities we have created helper class for easy and centralise use. 
