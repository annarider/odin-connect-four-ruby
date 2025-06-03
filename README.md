# odin-connect-four-ruby
The Odin Project's Connect Four project using TDD


Let's plan and outline the project before writing code.
We're doing this TDD!

# main.rb 
Purpose: Entry point and game-loop management
- Creates a new Game
- Sets up game loop and repeat play if player chooses y
- Handles high-level exceptions  
Instance variables: None
Instance method: 
- play

# Game class
Purpose: Controller. Active orchestrator for game flow
Instance variables: 
Instance methods: 

# Board class
Purpose: 
- State of the game (data about game grid)
- Contains the rules in the game, e.g. checks
for game over, full board, winner
- Move validation
- Move execution (store result of move)
Instance variables: 
Instance methods: 
- full?
- winner?
- game_over?
- valid_move?
- drop_piece

# Player class
Purpose: Creates a new player and symbol
Instance variables: 
- @name
- @symbol
Instance methods:
- Sets the player name
- Sets the player symbol 

# IO class
Purpose: Controls IO for players
Instance variables: None
Instance methods: 
- Request player name
- Get's player column input
- Displays board after every move
- Displays win & game over announcements
- Validates & cleanses inputs
