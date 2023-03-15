PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#function for getting data from db
#GetData [atomic_number|symbol|name] <value>
function GetData () {
	#set base of command to fetch data
	BASECOMMAND="SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius \
				FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id)"
	
	#choose WHERE parameter based on input type
	if [[ $1 == atomic_number ]]
		then
			COMMANDWHERE="WHERE atomic_number = $2"
	elif [[ $1 == symbol ]]
		then
			COMMANDWHERE="WHERE symbol = '$2'"
	elif [[ $1 == name ]]
		then 
			COMMANDWHERE="WHERE name = '$2'"
	fi

	#echo result of calling entire command as PSQL query
	echo $($PSQL "$BASECOMMAND $COMMANDWHERE")
}

function ProcessData () {
	#split data into individual parts and apply them to output statement
	echo $1 | while IFS='|' read atomic_number name symbol etype mass melt boil
				do
					echo "The element with atomic number $atomic_number is $name ($symbol). It's a $etype, with a mass of $mass amu. $name has a melting point of $melt celsius and a boiling point of $boil celsius."
				done
}

#check for parameter
if [[ -z $1 ]]
	then
		#if no parameter print error
		echo -e "Please provide an element as an argument."
	else
		#if input is atomic number
		if [[ $1 =~ ^[0-9]+$ ]]
			then 
				#retrieve data using functions and process for echoing
				DATA=$(GetData atomic_number $1)
				echo $(ProcessData $DATA)
		
		#if input is symbol
		elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
			then
				#retrieve data using functions and process for echoing
				DATA=$(GetData symbol $1)
				echo $(ProcessData $DATA)

		#if input is name
		elif [[ $1 =~ ^[A-Z][a-z]{2,}$ ]]
			then
				#retrieve data using functions and process for echoing
				DATA=$(GetData name $1)
				echo $(ProcessData $DATA)
		
		else
			echo "I could not find that element in the database."
			
		fi
fi
