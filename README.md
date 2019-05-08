# Bay Pass - A mobile transit solution
<img width="100" alt="screen shot 2019-02-07 at 6 48 06 pm" src="https://user-images.githubusercontent.com/13894518/52456509-e947af00-2b09-11e9-829d-f90d47ece779.png">  

[![Build Status](https://travis-ci.com/timroesner/BayPass.svg?token=WiAQGuCxgiespq3vmWc1&branch=master)](https://travis-ci.com/timroesner/BayPass)   [![codecov](https://codecov.io/gh/timroesner/BayPass/branch/master/graph/badge.svg?token=hasFyKFOq8)](https://codecov.io/gh/timroesner/BayPass)

## Summary
This repo contains all the code to our senior project, which was completed in the spring semester of 2019. We decided to build an iOS App in Swift that solves some of the issues transit riders in the Bay Area have been experiencing. For example getting to and from transit stations, purchasing tickets on their phone, reloading Clipper cash and adding passes, and integrating electric scooters with transit options.  
  

## Team Members
- [Ayesha Khan](https://github.com/ayesha1)
- [Zhe (Dennis) Li](https://github.com/DennisLee)
- [Tim Roesner](https://github.com/timroesner)
- [Hua (Tina) Tong](https://github.com/thualing)

  
## How we work
We are an agile team and have 1 and 2 week sprints that you can find under [projects](https://github.com/timroesner/BayPass/projects). We estimate each task's complexity and review each others code before merging. Additionally we use the following tools for better collaboration:  
- [Xcode](https://developer.apple.com/xcode/)
- [CocoaPods](https://cocoapods.org)
- [fastlane](http://fastlane.tools/)
- [Sketch](https://sketchapp.com)
- [Slack](https://slack.com)
- [Google Drive](https://drive.google.com)
- [Zeplin](https://zeplin.io)

  
## Architecture
We practice MVVM for our code strcuture, and use [Travis](https://travis-ci.org) for our CI enviorment, which builds each PR and runs tests to see if the branch is passing. We also use coverage reports from [codecov.io](https://codecov.io) to see the test coverage of the diff in a PR and the overall test coverage. 


## Setup
After cloning this repository you will first need to run `pod install` to download all the necessary pods, which are not stored as part of this repo. Also you will need to add your own API keys to a shell script named `env-vars.sh` which looks as follows:
```
export BIRD_TOKEN=YOUR_TOKEN
export BART_TOKEN=YOUR_TOKEN
export GOOGLE_DIRECTIONS=YOUR_GOOGLE_API_KEY
export HEREAPPID=YOUR_HERE_ID
export HEREAPPCODE=YOUR_HERE_APP_CODE
export MULTICYCLES=YOUR_TOKEN
export MERCHANT_ID=YOUR_APPLE_MERCHANT_ID
export STRIPE_KEY=YOUR_STRIPE_KEY
```

## UI 
### Map
<img width="217" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/57338422-2bb96180-70e2-11e9-8c20-1f9efc86f8e4.PNG"><img width="217" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/57338425-2cea8e80-70e2-11e9-92ae-e68c6c308aa3.PNG"><img width="217" alt="screen shot 2019-02-07 at 6 41 51 pm" src="https://user-images.githubusercontent.com/13894518/57338667-21e42e00-70e3-11e9-8fe6-c97ee6bc4cf7.jpeg"><img width="217" alt="screen shot 2019-02-07 at 6 51 33 pm" src="https://user-images.githubusercontent.com/13894518/57338671-23155b00-70e3-11e9-8d14-1ef9de5ecb12.jpeg">
### Tickets
<img width="217" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/57338435-32e06f80-70e2-11e9-8890-0af423ae7f93.jpeg"><img width="217" alt="screen shot 2019-02-07 at 6 44 29 pm" src="https://user-images.githubusercontent.com/13894518/57338427-2e1bbb80-70e2-11e9-8a2e-0e22f2027cfb.PNG"><img width="217" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/57347653-e3149f00-7107-11e9-88e7-08c38ed1dac8.jpg"><img width="217" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/57338429-2f4ce880-70e2-11e9-81b2-d2c4eeb1deea.PNG">
### Clipper
<img width="217" alt="screen shot 2019-02-07 at 6 45 49 pm" src="https://user-images.githubusercontent.com/13894518/52456210-98838680-2b08-11e9-9d12-837ee5ebd778.png"><img width="217" alt="screen shot 2019-02-07 at 6 46 24 pm" src="https://user-images.githubusercontent.com/13894518/57338433-31af4280-70e2-11e9-8bac-cd889193a170.PNG"><img width="217" alt="screen shot 2019-02-07 at 6 46 53 pm" src="https://user-images.githubusercontent.com/13894518/57338431-307e1580-70e2-11e9-9a91-aaffbe78564f.PNG"><img width="217" alt="screen shot 2019-02-07 at 6 48 06 pm" src="https://user-images.githubusercontent.com/13894518/52456310-ea2c1100-2b08-11e9-9549-db4bdfd7e717.png">

