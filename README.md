# Hotel room scheduling prototype

## Summary:

This is a prototype application to define a process for scheduling rooms at a fictional hotel.  The requirement for this project are that it exposes everal end points via a RESTful API.  Ruby on Rails is the best tool for that job.  

## Setup:

Install Ruby 2.4.0
Install Rails 5.1.2

I used Homebrew on a Mac OS X Sierra here is a url to a install process https://gorails.com/setup/osx/10.12-sierra

After installing Ruby on Rails, populate the database then bundle the app and it should be good to go.

## Usage:

I used Postman for API testing.

###Endpoints:

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
