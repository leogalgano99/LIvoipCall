#!/bin/bash

password="lawful2023"
# Mostra un menu con due opzioni
PS3="Select an option: "
options=("VoIP" "Files")
# Set the input variables (ad esempio, 1 o 2)
input_var="1"

# Imposta automaticamente l'opzione in base a input_var
case "$input_var" in
    "1")
        choice="VoIP"
        ;;
    "2")
        choice="Files"
        ;;
    *)
        echo "Invalid input_var"
        exit 1
        ;;
esac

case $choice in
    "VoIP")
        ./VoIP/IRI.sh <<< "$password"
        ;;
    "Files")
        ./Files/IRI.sh <<< "$password"
        ;;
    "Exit")
        echo "Exiting..."
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
