# Hotel room scheduling prototype

##Summary:

This is a prototype application to define a process for scheduling rooms at a fictional hotel.  The requirement for this project are that it exposes everal end points via a RESTful API.  Ruby on Rails is the best tool for that job.  

##Setup:

Install Ruby 2.4.0
Install Rails 5.1.2

I used Homebrew on a Mac OS X Sierra here is a url to a install process https://gorails.com/setup/osx/10.12-sierra

After installing Ruby on Rails, populate the database then bundle the app and it should be good to go.

#Usage:

I used Postman for API testing.

Endpoints:

*localhost:3000/rooms/list - to get a list of all rooms and their current status.

*localhost:3000/rooms/list_available - to get a list of rooms available to rent.

*localhost:3000/rooms/cleaning_schedule - will give an estimated time in minutes to clean all the dirty rooms.

*localhost:3000/rooms/book?guests=1 - to book a guest with no bags.

*localhost:3000/rooms/book?guests=1&bags=1 - to book a guest with 1 bag.
