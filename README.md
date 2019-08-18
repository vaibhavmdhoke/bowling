# README

* Ruby version: ruby-2.3.1

* System dependencies: postgres

* Database creation: rake db:create, rake db:migrate

* Database initialization: none

* Services (job queues, cache servers, search engines, etc.)

Postman Collection: https://www.getpostman.com/collections/3feca57e42565e1c1c37


● A way to start a new bowling game;
POST /games
    
    body 
    {
        "game":{
            "name": "Game 1"
        }
    }
    name: name of the game

● Assign a player to each game
POST /players

    body
    {
	"player":{
		"name": "Player 2, game 2",
		"game_id": 2
        }
    }

    game_id: id when you get after creating a game.
    name: player name

For each game. New Players must be created. System assumes that there are always new players per game.

● A way to input the number of pins knocked down by each ball;
POST /frames
    
    body
    {"frame":{
		"frame_number": 10,
		"player_id": 3,
		"fallen_pins_roll_1":10 
        }
    }
    player_id: Id if the player
    fallen_pins_roll_1: Pins fallen after roll 1
    fallen_pins_roll_2: Pins fallen after roll 2
    fallen_pins_roll_3: Pins fallen after roll 3

    roll denotes number of times a player rolls ball.
    This call is sent after each number knockdown, hence in each call either of the below is sent in API. 
    fallen_pins_roll_1:
    fallen_pins_roll_2:
    fallen_pins_roll_3:

● A way to output the current game score (score for each frame and total score).

GET /games/:id
    
    response body
    {
    "id": 2,
    "name": "Game 1",
    "created_at": "2019-08-18T16:21:02.531Z",
    "updated_at": "2019-08-18T16:21:02.531Z",
    "players": [
        {
            "player_id": 2,
            "name": "Player 1, game 2",
            "total_score": 124,
            "frames": [
                {
                    "frame_number": 1,
                    "rolls": {
                        "fallen_pins_roll_1": 10,
                        "fallen_pins_roll_2": null
                    },
                    "frame_score": 20,
                    "state": "strike"
                },
                {
                    "frame_number": 2,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5
                    },
                    "frame_score": 13,
                    "state": "spare"
                },
                {
                    "frame_number": 3,
                    "rolls": {
                        "fallen_pins_roll_1": 3,
                        "fallen_pins_roll_2": 3
                    },
                    "frame_score": 6,
                    "state": null
                },
                {
                    "frame_number": 4,
                    "rolls": {
                        "fallen_pins_roll_1": 4,
                        "fallen_pins_roll_2": 4
                    },
                    "frame_score": 4,
                    "state": null
                },
                {
                    "frame_number": 5,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5
                    },
                    "frame_score": 14,
                    "state": "spare"
                },
                {
                    "frame_number": 6,
                    "rolls": {
                        "fallen_pins_roll_1": 4,
                        "fallen_pins_roll_2": 4
                    },
                    "frame_score": 8,
                    "state": null
                },
                {
                    "frame_number": 7,
                    "rolls": {
                        "fallen_pins_roll_1": 4,
                        "fallen_pins_roll_2": 6
                    },
                    "frame_score": 18,
                    "state": "spare"
                },
                {
                    "frame_number": 8,
                    "rolls": {
                        "fallen_pins_roll_1": 8,
                        "fallen_pins_roll_2": 2
                    },
                    "frame_score": 12,
                    "state": "spare"
                },
                {
                    "frame_number": 9,
                    "rolls": {
                        "fallen_pins_roll_1": 2,
                        "fallen_pins_roll_2": 7
                    },
                    "frame_score": 9,
                    "state": null
                },
                {
                    "frame_number": 10,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5,
                        "fallen_pins_roll_3": 10
                    },
                    "frame_score": 20,
                    "state": "spare"
                }
            ]
        },
        {
            "player_id": 3,
            "name": "Player 2, game 2",
            "total_score": 140,
            "frames": [
                {
                    "frame_number": 1,
                    "rolls": {
                        "fallen_pins_roll_1": 3,
                        "fallen_pins_roll_2": 3
                    },
                    "frame_score": 6,
                    "state": null
                },
                {
                    "frame_number": 2,
                    "rolls": {
                        "fallen_pins_roll_1": 10,
                        "fallen_pins_roll_2": null
                    },
                    "frame_score": 15,
                    "state": "strike"
                },
                {
                    "frame_number": 3,
                    "rolls": {
                        "fallen_pins_roll_1": 10,
                        "fallen_pins_roll_2": null
                    },
                    "frame_score": 20,
                    "state": "strike"
                },
                {
                    "frame_number": 4,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5
                    },
                    "frame_score": 15,
                    "state": "spare"
                },
                {
                    "frame_number": 5,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5
                    },
                    "frame_score": 15,
                    "state": "spare"
                },
                {
                    "frame_number": 6,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 5
                    },
                    "frame_score": 15,
                    "state": "spare"
                },
                {
                    "frame_number": 7,
                    "rolls": {
                        "fallen_pins_roll_1": 5,
                        "fallen_pins_roll_2": 3
                    },
                    "frame_score": 8,
                    "state": null
                },
                {
                    "frame_number": 8,
                    "rolls": {
                        "fallen_pins_roll_1": 2,
                        "fallen_pins_roll_2": 4
                    },
                    "frame_score": 6,
                    "state": null
                },
                {
                    "frame_number": 9,
                    "rolls": {
                        "fallen_pins_roll_1": 10,
                        "fallen_pins_roll_2": null
                    },
                    "frame_score": 20,
                    "state": "strike"
                },
                {
                    "frame_number": 10,
                    "rolls": {
                        "fallen_pins_roll_1": 10,
                        "fallen_pins_roll_2": 0,
                        "fallen_pins_roll_3": 10
                    },
                    "frame_score": 20,
                    "state": "strike"
                }
            ]
        }
    ],
    "url": "http://localhost:3000/games/2.json"
}
