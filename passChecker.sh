#!/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Variables globales

main_url="https://api.pwnedpasswords.com/range/"
 
# Funciones

function pass_checker(){

  pass_value="$1"
  pass_hashing=$(echo -n "$pass_value" | sha1sum | awk '{print $1}' | tr 'a-f' 'A-F')
  hashing_key=$(echo "$pass_hashing" | awk '{print substr($0, 1, 5)}')
  last_hash=$(echo "$pass_hashing" | awk '{print substr($0, 6)}')
  result=$(curl -s -H "User-Agent: passChecker" "${main_url}${hashing_key}" | grep -i "^$last_hash")

  if [ -z "$result" ]; then
    echo -e "\n${greenColour}[+] La contraseña NO fue encontrada en bases filtradas.${endColour}"
  else
    cantidad=$(echo "$result" | awk -F: '{print $2}' | tr -d '\r\n')
    echo -e "\n${redColour}[-] La contraseña fue encontrada ${cantidad} veces en bases filtradas.${endColour}"
  fi

}


# Panel de ayuda
function helpPanel(){
  echo -e "${blueColour}"
  cat << "EOF"
                            ________              __            
     ____  ____ ___________/ ____/ /_  ___  _____/ /_____  _____
    / __ \/ __ `/ ___/ ___/ /   / __ \/ _ \/ ___/ //_/ _ \/ ___/
   / /_/ / /_/ (__  |__  ) /___/ / / /  __/ /__/ ,< /  __/ /    
  / .___/\__,_/____/____/\____/_/ /_/\___/\___/_/|_|\___/_/     
 /_/                                                             
                                        by c4skd
EOF
  echo -e "${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Uso:${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Ejemplo de uso: ./passChecker.sh -p \"test\" ${endColour}\n"
  echo -e "\t${purpleColour}-p)${endColour} ${grayColour}Contraseña a verificar${endColour}"
  echo -e "\t${purpleColour}-e)${endColour} ${grayColour}Esta opción está en desarrollo ...${endColour}"
  echo -e "\t${purpleColour}-h)${endColour} ${grayColour}Mostrar este panel de ayuda${endColour}\n"
}

# Si no se pasa ningún parámetro, mostrar ayuda
if [ $# -eq 0 ]; then
  helpPanel
  exit 0
fi

# Verificar si el primer argumento no empieza con "-"
if [[ "$1" != -* ]]; then
  echo -e "\n${redColour}[!] Error: Se debe poner un parámetro que empiece con '-'.${endColour}"
  helpPanel
  exit 1
fi

# Procesar opciones
while getopts ":p:eh" arg; do
  case $arg in
    p)
      if [ -z "$OPTARG" ]; then
        echo -e "\n${redColour}[!] Error: La opción -p requiere un valor.${endColour}"
        helpPanel
        exit 1
      fi
      pass_checker "$OPTARG"
      ;;
    e) echo -e "${yellowColour}[!] Opción en desarrollo...${endColour}" ;;
    h) helpPanel ;;
    :)
      echo -e "\n${redColour}[!] Error: La opción -$OPTARG requiere un valor.${endColour}"
      helpPanel
      exit 1 ;;
    *)
      echo -e "\n${redColour}[!] Opción inválida: -$OPTARG${endColour}"
      helpPanel
      exit 1 ;;
  esac
done
