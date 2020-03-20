README 

This application was created in Xcode 11.3 for ios 12 deployment. It supports both portrait and lanscape mode. It was created without using any pods to reduce dependcies. 

To get application running please open Webservices.swift in there are two values in the fetchApiData function 

let apiKey = "INSERT KEY HERE"
let privateKey = "INSERT KEY HERE"

Please update the keys here and remove the warnings. 

There are also two values in MarvelDemoTests.swift in the testWebserviceresponse function. 

You will see 2 warnings for both of the missing set of keys. Update them then remove the warnings. 

There are two tests one is for the UI the other is for the Webservices. You can run both tests from their folders. MarvelDemoTests runs the Webservices test while the MarvelUITests runs the UI testing. 



