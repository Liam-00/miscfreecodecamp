#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RAND=$(($RANDOM % 1000 + 1))
GAME_COUNT=0
#

function welcomeuser() {
  USERDATA=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username = '$1'")
  echo $USERDATA | while IFS='|' read username games_played best_game
    do
      echo "Welcome back, $username! You have played $games_played games, and your best game took $best_game guesses."
  done
}

function newuser() {
  USERADD=$($PSQL "INSERT INTO users (username, games_played, best_game) values ('$1', 0, 0)")
}

function gamelog() {
  HIGH_SCORE=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
  if [[ $GAME_COUNT < $HIGH_SCORE || $HIGH_SCORE == 0 ]]
    then
      WRITE=$($PSQL "UPDATE users SET games_played = ($GAMES_PLAYED + 1), best_game = $GAME_COUNT WHERE username = '$USERNAME'")
    else
      WRITE=$($PSQL "UPDATE users SET games_played = ($GAMES_PLAYED + 1) WHERE username = '$USERNAME'")
  fi
}

function game() {
  #game challenge

  #game logic for looping through input checks
  if [[ -z $GUESS_INPUT ]]
      then
        echo "Guess the secret number between 1 and 1000:"
        read GUESS_INPUT
        GAME_COUNT=$(($GAME_COUNT + 1))
        game
  elif [[ $GUESS_INPUT =~ ^[0-9]+$ ]]
      then    
          if [[ $GUESS_INPUT > $RAND ]]
            then 
              echo "It's lower than that, guess again:"
              read GUESS_INPUT
              GAME_COUNT=$(($GAME_COUNT + 1))
              game
          elif [[ $GUESS_INPUT < $RAND ]]
            then 
              echo "It's higher than that, guess again:"
              read GUESS_INPUT
              GAME_COUNT=$(($GAME_COUNT + 1))
              game
          elif [[ $GUESS_INPUT == $RAND ]]
            then 
              echo "You guessed it in $GAME_COUNT tries. The secret number was $RAND. Nice job!"
              gamelog
          fi
  else
    echo "That is not an integer, guess again:"
    read GUESS_INPUT
    game
  fi
}


#get username
echo -e "Enter your username:"
read USERNAME

#if username exists in db
USER_EXIST=$($PSQL "SELECT * FROM users WHERE username = '$USERNAME'")

if [[ -z $USER_EXIST ]]
  then
    #welcome message
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    newuser $USERNAME
    #playgame
    game
  else
    #welcome back message
    echo $(welcomeuser $USERNAME)
    #playgame
    game
fi
