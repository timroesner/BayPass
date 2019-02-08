# Bay Pass - A mobile transit solution
<img width="100" alt="screen shot 2019-02-07 at 6 48 06 pm" src="https://user-images.githubusercontent.com/13894518/52456509-e947af00-2b09-11e9-829d-f90d47ece779.png">  

[![Build Status](https://travis-ci.com/timroesner/BayPass.svg?token=WiAQGuCxgiespq3vmWc1&branch=master)](https://travis-ci.com/timroesner/BayPass)   [![codecov](https://codecov.io/gh/timroesner/BayPass/branch/master/graph/badge.svg?token=hasFyKFOq8)](https://codecov.io/gh/timroesner/BayPass)

## Summary
Metropolitan areas, like the Bay Area, are prone to traffic congestion due to a high number of cars during peak periods and space limitations. Some improvement have been made in recent years through ride sharing apps, however these apps also attract people how would previously have taken public transit, as those services are easier to use and operate door-to-door.
The goal of this project is to make public transit simple to use and thus improve the congestion in the Bay Area.  
We are solving the first mile issue through integration of electric kick scooter services that help riders to get from and to stations. We will also make trip planning easier with integration of all agencies across the Bay Area and live updates about arrival times, station closures, and cancellations. Additionally we will also be integrating ride sharing to bridge gaps in the system maps.  Lastly we will make ticketing easier and offer a mobile solution to purchase these. We will leverage the NFC capabilities of today’s smartphones to act as the mobile ticket, reducing cost for agencies. But also improving usability for riders as matching tickets can be automatically detected when the phone is near the reader, without need to unlock the phone. Additionally passes and transit cards can be removed remotely from the device in case of theft or loss.
The ticketing feature and integration of the scooter services will set us apart from similar apps available in the Bay Area today.  
  

## Team Members
- [Ayesha Khan](https://github.com/ayesha1)
- [Zhe (Dennis) Li](https://github.com/DennisLee)
- [Tim Roesner](https://github.com/timroesner)
- [Hua (Tina) Tong](https://github.com/thualing)

  
## How we work
We are an agile team and have 1 and 2 week sprints that you can find under [projects](https://github.com/timroesner/BayPass/projects). We estimate each task's complexity and review each others code before merging. Additionally we use the following tools for better collaboration:  
- [Xcode](https://developer.apple.com/xcode/)
- [CocoaPods](cocoapods.org)
- [fastlane](http://fastlane.tools/)
- [Sketch](https://sketchapp.com)
- [Slack](slack.com)
- [Google Drive](drive.google.com)
- [Zeplin](zeplin.io)

  
## Architecture
We practice MVVM for our code strcuture, and use [Travis](https://travis-ci.org) for our CI enviorment, which builds each PR and runs tests to see if the branch is passing. We also use coverage reports from codecov.io to see the test coverage of the diff in a PR and the overall test coverage. 


## Setup
After cloning this repository you will first need to run `pod install` to download all the necessary pods, which are not stored as part of this repo. Also you will need to add your own API keys to a shell script named `env-vars.sh` which looks as follows:
```
export BIRD_TOKEN = YOUR_TOKEN
export BART_TOKEN = YOUR_TOKEN
```

## UI 
<img width="225" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/52455989-bd2b2e80-2b07-11e9-8f9f-733204af8554.png"><img width="225" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/52455990-be5c5b80-2b07-11e9-8735-1984ca2e1565.png"><img width="225" alt="screen shot 2019-02-07 at 6 41 51 pm" src="https://user-images.githubusercontent.com/13894518/52456086-185d2100-2b08-11e9-93bb-8f32c7474a87.png"><img width="225" alt="screen shot 2019-02-07 at 6 51 33 pm" src="https://user-images.githubusercontent.com/13894518/52456393-66beef80-2b09-11e9-9f78-4b501ff08c4b.png"><img width="225" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/52456137-4b9fb000-2b08-11e9-96c6-352993a63d79.png"><img width="225" alt="screen shot 2019-02-07 at 6 44 29 pm" src="https://user-images.githubusercontent.com/13894518/52456167-696d1500-2b08-11e9-8300-22dd3279ad26.png"><img width="225" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/52456177-712cb980-2b08-11e9-9c40-b0934753df72.png"><img width="225" alt="screen shot 2019-02-07 at 6 45 17 pm" src="https://user-images.githubusercontent.com/13894518/52456195-8570b680-2b08-11e9-8fca-d312b1ca6563.png"><img width="225" alt="screen shot 2019-02-07 at 6 45 49 pm" src="https://user-images.githubusercontent.com/13894518/52456210-98838680-2b08-11e9-9d12-837ee5ebd778.png"><img width="225" alt="screen shot 2019-02-07 at 6 46 24 pm" src="https://user-images.githubusercontent.com/13894518/52456231-ad601a00-2b08-11e9-8aee-90e41309dda2.png"><img width="225" alt="screen shot 2019-02-07 at 6 46 53 pm" src="https://user-images.githubusercontent.com/13894518/52456259-bea92680-2b08-11e9-97eb-1e51e649cced.png"><img width="225" alt="screen shot 2019-02-07 at 6 48 06 pm" src="https://user-images.githubusercontent.com/13894518/52456310-ea2c1100-2b08-11e9-9549-db4bdfd7e717.png">

