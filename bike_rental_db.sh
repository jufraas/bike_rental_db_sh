#!/bin/bash
PSQL="psql -d bike_rental -U postgres -c "
echo -e "\n~~~~~ Bike Rental Shop ~~~~~"

MAIN_MENU(){
if [[ $1 ]]
then
  echo -e "\n$1"
fi

echo "What table do you want to insert info?"

echo -e "\n1. bike\n2. client\n3. rental\n4. Exit"
read MAIN_MENU_SELECTION

case $MAIN_MENU_SELECTION in
  1) ALTER_BIKE ;;
  2) ALTER_CLIENT ;;
  3) ALTER_RENTAL ;;
  4) EXIT ;;
  *) MAIN_MENU "Please enter a valid option." ;;
esac

}

ALTER_BIKE(){
  ALTER_TABLE "bike"
}
ALTER_CLIENT(){
  ALTER_TABLE "client"
}
ALTER_RENTAL(){
  ALTER_TABLE "rental"
}

ALTER_TABLE(){
    TABLE_NAME=$1

    ADD_COLUMN(){
      echo -e '\nEnter the name of new column'
      read NAME_COL
      echo -e "\nEnter the type of $NAME_COL column"
      read TYPE_COL
      CREATE_COLUMN=$($PSQL "ALTER TABLE $TABLE_NAME ADD COLUMN $NAME_COL $TYPE_COL;")
      echo -e '\nChanges saved'
    }

    ALTER_COLUMN(){

      CHANGE_TYPE(){
        echo -e '\nEnter the name of new column'
        read NAME_COL
        echo -e '\nWhat is the new type you want?'
        read NEW_TYPE_VALUE
        CHANGE_COLUMN_TYPE=$($PSQL "ALTER TABLE $TABLE_NAME ALTER COLUMN $NAME_COL TYPE $NEW_TYPE_VALUE;")
        echo -e '\nChanges saved'
      }

      RENAME_COLUMN(){
        echo -e '\nEnter the name of new column'
        read NAME_COL
        echo -e '\nEnter the new name of new column'
        read NEW_NAME_COL
        CHANGE_COLUMN_NAME=$($PSQL "ALTER TABLE $TABLE_NAME RENAME COLUMN $NAME_COL TO $NEW_NAME_COL;")
      }

      echo -e "\nWhat do you want to do?"
      echo -e "\n1- Change data type\n2. Rename a Column"
      case $MAIN_MENU_SELECTION in
        1) CHANGE_TYPE ;;
        2) RENAME_COLUMN ;;
        *) MAIN_MENU "Please enter a valid option." ;;
      esac
    }

    INSERT_DATA(){

      if [ $TABLE_NAME == "bike" ]; then
        echo -e "\nIn this table you have de following data: "
        echo -e "\nbike_id, type, size, available"
        echo -e "\nbike_id and available have a default value"

        echo -e "\nWhat is the type of the bike?"
        read TYPE_BIKE
        echo -e "\nWhat is the size of the bike?"
        read SIZE_BIKE
        echo -e "\nwhat is the price of the hour?"
        read HOURLY_PRICE_BIKE

        INSERT_BIKE_DATA=$($PSQL "INSERT INTO $TABLE_NAME(type, size, hourly_price ) VALUES ('$TYPE_BIKE', $SIZE_BIKE, '$HOULY_PRICE_BIKE')")

      elif [ $TABLE_NAME == "client" ]; then
        echo -e "\nIn this table you have de following data: "
        echo -e "\nclient_id, name_client, cellphone, email"
        echo -e "\nclient_id have a default value"

        echo -e "\nWhat is the name of the client?"
        read NAME_CLIENT
        echo -e "\nWhat is the phone of the client?"
        read PHONE_CLIENT 
        echo -e "\nwhat is the client's gmail?"
        read EMAIL_CLIENT
        
        INSERT_BIKE_DATA=$($PSQL "INSERT INTO $TABLE_NAME(name_client, cellphone, email) VALUES ('$NAME_CLIENT_CLIENT', '$CELLPHONE_CLIENT', '$EMAIL_CLIENT')")

      elif [ $TABLE_NAME == "rental" ]; then
        echo -e "\nIn this table you have de following data: "
        echo -e "\nrental_id, customer_id, bike_id, date_rented, date_returned"
        echo -e "\nrental_id and date_rented have a default value"

        echo -e "\nWhat is the id of the customer?"
        read CUSTOMER_ID
        echo -e "\nWhat is the id of the bike?"
        read BIKE_ID
        echo -e "\nWhat is the date returned? (YYYY-MM-DD)"
        read DATE_RETURNED
        
        INSERT_BIKE_DATA=$($PSQL "INSERT INTO $TABLE_NAME(client_id, bike_id, date_returned) VALUES ($CUSTOMER_ID, $BIKE_ID, '$DATE_RETURNED')")
      fi
      
    }

    echo -e "\nYou select alter bike table"
    echo -e "\nWhat do you want to do?"
    echo -e "\n1. Add column \n2. Alter column\n3. Insert data"
    read TABLE_ACTION
    case "$TABLE_ACTION" in
    1) ADD_COLUMN;;
    2) ALTER_COLUMN;;
    3) INSERT_DATA ;;
    
    *) ALTER_TABLE "Please enter a valid option.";;
    esac
}

EXIT(){
    echo -e "\nYou select exit"
}

MAIN_MENU