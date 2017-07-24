# Hotel room scheduling prototype

## Summary:

This is a prototype application to define a process for scheduling rooms at a fictional hotel.  The requirement for this project are that it exposes several end points via a RESTful API.  Ruby on Rails is the best tool for that job.  

## Setup:

Install Ruby 2.4.0
Install Rails 5.1.2

I used Homebrew on a Mac OS X Sierra here is a url to a install process https://gorails.com/setup/osx/10.12-sierra

After installing Ruby on Rails, populate the database then bundle the app and it should be good to go.

## Usage:

I used Postman for API testing.

### Endpoints:

* localhost:3000/rooms/list - to get a list of all rooms and their current status.
```json
{
    "status": "ok",
    "rooms": [
        {
            "id": 1,
            "guests": 0,
            "max_guests": 2,
            "status": 2,
            "created_at": "2017-07-23T18:33:24.840Z",
            "updated_at": "2017-07-24T00:22:04.005Z",
            "max_storage": 1,
            "storage": 0
        },
        {
            "id": 2,
            "guests": 0,
            "max_guests": 2,
            "status": 0,
            "created_at": "2017-07-23T18:34:31.577Z",
            "updated_at": "2017-07-24T10:57:03.404Z",
            "max_storage": null,
            "storage": null
        },
        {
            "id": 3,
            "guests": 0,
            "max_guests": 1,
            "status": 2,
            "created_at": "2017-07-23T18:35:03.618Z",
            "updated_at": "2017-07-24T10:57:15.715Z",
            "max_storage": 2,
            "storage": 0
        },
        {
            "id": 4,
            "guests": 0,
            "max_guests": 1,
            "status": 0,
            "created_at": "2017-07-23T18:35:23.113Z",
            "updated_at": "2017-07-24T10:57:24.667Z",
            "max_storage": null,
            "storage": null
        }
    ]
}
```

* localhost:3000/rooms/list_available - to get a list of rooms available to rent.
```json
{
    "status": "ok",
    "rooms": [
        {
            "id": 2,
            "guests": 0,
            "max_guests": 2,
            "status": 0,
            "created_at": "2017-07-23T18:34:31.577Z",
            "updated_at": "2017-07-24T10:57:03.404Z"
        },
        {
            "id": 4,
            "guests": 0,
            "max_guests": 1,
            "status": 0,
            "created_at": "2017-07-23T18:35:23.113Z",
            "updated_at": "2017-07-24T10:57:24.667Z"
        }
    ]
}
```

* localhost:3000/rooms/cleaning_schedule - will give an estimated time in minutes to clean all the dirty rooms.
```json
{
    "status": "ok",
    "time_to_clean": 120
}
```

* localhost:3000/rooms/book?guests=1 - to book a guest with no bags.
```json
{
    "status": "ok",
    "guests": "1",
    "bags": null,
    "rooms": {
        "id": 2,
        "guests": 0,
        "max_guests": 2,
        "status": 0,
        "created_at": "2017-07-23T18:34:31.577Z",
        "updated_at": "2017-07-24T10:57:03.404Z"
    },
    "cost": null
}
```
* localhost:3000/rooms/book?guests=1&bags=1 - to book a guest with 1 bag.
```json
{
    "status": "ok",
    "guests": "1",
    "bags": "1",
    "rooms": {
        "id": 1,
        "guests": 1,
        "max_guests": 2,
        "status": 0,
        "created_at": "2017-07-23T18:33:24.840Z",
        "updated_at": "2017-07-24T11:54:39.880Z"
    },
    "cost": "1"
}
```

# How it works

A guest requests a room.

The desk clerk runs the book endpoint and specifies the number of guests and bags in the party.  The API finds an available room and returns the room number and returns back the requested attributes.  If no rooms are available a message is returned.

The desk clerk can also find out the status of all rooms or just the available rooms.

Additional the cleaning_schedule endpoint will indicate how long it will take the current cleaning staff to clean all the dirty rooms.

# Not in this version

The room number is the primary key for simplicity, I would prefer a more real world number such as 203 or 23B.

The cost calculations are not yet implemented.

The status of a room is just a number 0 = available, 1 = occupied, 2 = dirty it would be nice to tie those together so a human readable value is presented.

Currently only guests with bags are placed in rooms with storage and guests without are placed in rooms without storage, it is possible to take advantages of empty beds.

We don't have a way for the cleaning folks to reset a room to clean after they are finished.


# Extendability

I designed this for expansion, currently we have the Rooms controller that handles all the rooms.  Adding additional rooms at the same hotel is pretty easy and clearly within the capabilities of this app.  

The next logical progression would be if there is more than one building either as part of the same hotel or a different hotel.  Simply creating a Hotel object with a one to many relationship to rooms solves that problem.

Additionally Hotels could be grouped into a chain, region or country just as easily.

Once the Rooms controller is expanded to more than one business entity we have the possibility that things like pricing, staff calculations and rules for assignment of rooms could change for different hotels.  Even change seasonally within the same organizaion.  I have abstracted the room handling functions such as find_available_rooms into shared private methods.  At this time I kept those scoped to the Room class, I would probably leave them there but make them protected so that if we needed to use or replace them with child implementations we easily could.

I also chose to put the calculations at the application level, these would probably be the most diverse in an expanded environment.  On a hotel by hotel basis they could either use the provided calculations or extend those calculations and replace the appropriate logic.

For the cleaning staff count and some of the other business logic numbers are abstracted to constants that can either be updated or replaced as needed.
I would probably create a configuration Object to store the configuration on a hotel by hotel basis instead of keeping them status.

# Testing

I create basic unit tests for each of the 4 main end points Book, List, List_Available and Cleaning Schedule.  I would absolutely expand these test to include use cases and edge cases.

I would want to use a Factory instead of creating actual API calls.
