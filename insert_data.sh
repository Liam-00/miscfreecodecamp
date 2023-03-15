#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"
#$( "$PSQL TRUNCATE teams games")


$PSQL 'TRUNCATE teams, games'

teamlist=()
gameinserts=()
gamewinner=()
gameopponent=()
while IFS=','  read year round winner opponent winner_goals opponent_goals
do
  #echo  $($PSQL "SELECT * FROM teams WHERE name = \"$winner\"")
  
  if [[ ! " ${teamlist[*]} " =~ " $winner " ]] && [[ "$winner" != "winner" ]]
  	then
  		teamlist+=("$winner")	
  fi

  if [[ ! " ${teamlist[*]} " =~ " $opponent " ]] && [[ "$opponent" != "opponent" ]]
  	then
  		teamlist+=("$opponent")
  fi

  if [[ "$winner" != 'winner' ]]
    then 
      gamewinner+=("$winner")
      gameopponent+=("$opponent")
      gameinserts+=("INSERT INTO games (year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES ($year, '$round', $winner_goals, $opponent_goals,")
  fi
done < games.csv



#insert teams into db
for i in "${!teamlist[@]}" 
	do
		$PSQL "INSERT INTO teams(name) VALUES ('${teamlist[$i]}')"
done

#insert games into db
for i in "${!gameinserts[@]}"
  do
    query="${gameinserts[$i]}"
    query+=" $($PSQL "SELECT team_id FROM teams WHERE name='${gamewinner[$i]}'"),"
    query+=" $($PSQL "SELECT team_id FROM teams WHERE name='${gameopponent[$i]}'"))"
    $PSQL "$query"
done

