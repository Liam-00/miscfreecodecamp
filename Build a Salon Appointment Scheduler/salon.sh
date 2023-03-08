#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon  -t -c" 

#get service query
SERVICE_STRING=$($PSQL "SELECT * FROM services")


#main program
SERVICE() {
	echo -e "\n__________-SERVICES"
	
	#generate list of services
	echo "$SERVICE_STRING" | while read SERVICE_ID BAR SERVICE_NAME
		do
			echo -e "\n$SERVICE_ID) $SERVICE_NAME"
	done
	echo -e "\n"

	#select service
	read SERVICE_ID_SELECTED
	SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
	#check input
	if [[ -z $SERVICE_ID && ! $SERVICE_ID_SELECTION =~ ^[0-9]+$ ]]
		then
			#if invalid restart menu
			SERVICE
		else
			#gather info
			echo -e "\nEnter Phone number:"
			read CUSTOMER_PHONE

			#check if customer exists
			CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
			if [[ -z $CUSTOMER_ID ]] 
				then
					#if they don't, add them to db
					echo -e "\nEnter Name:"
					read CUSTOMER_NAME
					ADD_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
			fi

			echo -e "\nEnter Time(hh:mm):"
			read SERVICE_TIME

			#create appointment
			CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
			ADD_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ('$CUSTOMER_ID', '$SERVICE_ID', '$SERVICE_TIME')")
			
			APPOINTMENT=$($PSQL "SELECT services.name, time, customers.name FROM appointments INNER JOIN customers USING (customer_id) INNER JOIN services USING (service_id) WHERE phone = '$CUSTOMER_PHONE' AND time = '$SERVICE_TIME' AND service_id = $SERVICE_ID")
			echo "$APPOINTMENT" | while read service bar time bar name
			do
				echo -e "\nI have put you down for a $service at $time, $name."
			done
			
	fi
}

SERVICE
