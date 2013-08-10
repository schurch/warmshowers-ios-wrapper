Warmshowers iOS API Wrapper
===========================

This is an iOS API wrapper for the [warmshowers.org](http://www.warmshowers.org) API.

The documentation for the API endpoints can be found on [Randy Fay's](http://www.github.com/rfay) GitHub page at [https://github.com/rfay/Warmshowers.org/wiki/Warmshowers-RESTful-Services-for-Mobile-Apps](https://github.com/rfay/Warmshowers.org/wiki/Warmshowers-RESTful-Services-for-Mobile-Apps)

Installation
------------

1. Copy the WSAPIClient/ directory into your XCode project. 
2. Include AFNetworking (v 1.3.2) and SSKeychain (v 1.2.0) in your project.
3. Import the *WSAPI.h* file wherever you want to use the Wrapper, or in the .pch file to use it throughout your project.

AFNetworking can be downloaded from 
[https://github.com/AFNetworking/AFNetworking/tree/1.3.2](https://github.com/AFNetworking/AFNetworking/tree/1.3.2). 

The installation instructions can be found at 
[https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking)

SSKeychain and the installation instructions are available at [https://github.com/soffes/sskeychain/tree/v1.2.0](https://github.com/soffes/sskeychain/tree/v1.2.0)

Configuration
------------

To configure the endpoint used by the wrapper, the *BASE_URL* constant in the *WSAPIClient.h* file needs to changed:

	#define BASE_URL @"http://warmshowers.dev"

You can also configure the maximum number of results returned by the *searchForUsersInLocation:completionHandler:* methods by changing the *MAX_USER_RESULTS* constant:

	#define MAX_USER_RESULTS 50

Contributing
------------

The project requires [CocoaPods](http://cocoapods.org) to be installed. Once installed you need to clone the repo and run a *pod install*. Once the pods have been installed the project can only be built from the generated workspace file.
