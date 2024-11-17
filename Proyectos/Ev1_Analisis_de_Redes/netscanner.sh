#!/bin/bash

echo "  _   _      _                          "
echo " | \\ | | ___| |_                        "
echo " |  \\| |/ _ \\ __|                       "
echo " | |\\  |  __/ |_                        "
echo " |_|_\\_|\\___|\\__|                       "
echo " / ___|  ___ __ _ _ __  _ __   ___ _ __ "
echo " \\___ \\ / __/ _\` | '_ \\| '_ \\ / _ \\ '__|"
echo "  ___) | (_| (_| | | | | | | |  __/ |   "
echo " |____/ \\___\\__,_|_| |_|_| |_|\\___|_|   "
echo "                                         "
echo "    by Diego Calles Fernández "


echo -e "\n\n"


mostrar_ayuda() {
    cat << EOF
Uso: sudo bash ./netscanner.sh <rango_ip> [-o archivo_salida]

Opciones:
  <rango_ip>              Rango de IP para escanear (por ejemplo, 192.168.1.0/24).
  -o, --output <archivo>  Especifica el archivo donde guardar la salida.
  -t                      Registra el tiempo que tarda el script en ejecutarse
  -h, --help              Muestra este menú de ayuda.

Descripción:
  Este script escanea un rango de direcciones IP y, opcionalmente, guarda el
  resultado en un archivo si se especifica la opción '-o' o '--output'.

Ejemplo:
  sudo bash ./netscanner.sh 192.168.1.0/24 -o resultado.txt
EOF
    exit 0
}


archivo=""
dir_red=""
registrar_tiempo=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            archivo="$2"
            shift 2
            ;;
        -t)
            registrar_tiempo=true
            shift
            ;;
        -h|--help)
            mostrar_ayuda
            ;;
        *)
            if [[ -z "$dir_red" ]]; then
                dir_red="$1"
            else
                echo "Error: Sólo puedes introducir un rango de IP"
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$dir_red" ]]; then
    echo "Error: Debes de especificar una dirección de red ; (Ejemplo: 192.168.1.0/24)"
    echo -e "\n"
    mostrar_ayuda
fi



# if [[ $# -lt 1 ]]; then
#     echo "Error: Debes de especificar una direccion de red ; (Ejemplo: 192.168.1.0/24)"
#     echo -e "\n"
#     mostrar_ayuda
# fi

# if [[ "$1" == "-h" || "$1" == "--help" ]]; then
#     mostrar_ayuda
# fi


ip=""
mascara=""
puertos=""

ip_valida() {
    ip_completa=$1

    if [[ "$ip_completa" == *"/"* ]];then

        ip=$(echo "$ip_completa" | cut -d "/" -f 1)
        mascara=$(echo "$ip_completa" | cut -d "/" -f 2)

        #Máscara de red valida
        if [[ ! "$mascara" =~ ^(8|16|24)$ ]]; then
            echo "Máscara de subred inválida. Debe ser /8, /16 o /24."
            exit 1
        fi

        octeto1=$(echo "$ip" | cut -d "." -f 1)
        octeto2=$(echo "$ip" | cut -d "." -f 2)
        octeto3=$(echo "$ip" | cut -d "." -f 3)
        octeto4=$(echo "$ip" | cut -d "." -f 4)

        if ((octeto1 >= 0 && octeto1 <= 255)) && ((octeto2 >= 0 && octeto2 <= 255)) && ((octeto3 >= 0 && octeto3 <= 255)) && ((octeto4 >= 0 && octeto4 <= 255)); then
            
            if [[ "$octeto4" -eq 0 ]]; then

            echo ""

            else
                echo "La ip tiene que acabar en 0."
                exit 1
            fi

        else
            echo "Cada octeto no puede superar 255"
            exit 1
        fi

    else
        echo "Formato no válido. Formato: ip/mascara (192.168.1.0/24)"
        exit 1
    fi
}

ip_valida "$dir_red"

echo "Dirección Ip: $ip"
echo "Máscara de subred: $mascara"

echo -e "\n"

declare -A puertos
while read -r linea; do
    if [[ "$linea" == "\"protocol\",\"port\",\"descripcion\"" ]]; then
        continue
    fi
    puerto=$(echo "$linea" | sed 's/"//g' | cut -d ',' -f 2)
    descripcion=$(echo "$linea" | sed 's/"//g' | cut -d ',' -f 3)
    puertos["$puerto"]="$descripcion"
done < tcp.csv



ping_a_ips() {

    echo "Escaneando red! $1"
    case $mascara in
        8)
            for i in {0..255};do
                for j in {0..255};do
                    for k in {0..255};do
                        respuesta=$(ping -c 1 -w 1 "$octeto1.$k.$j.$i" && echo "Ping a $octeto1.$k.$j.$i exitoso")
                        if [[ $? -eq 0 ]]; then
                            ttl=$(echo "$respuesta" | grep -oP 'ttl=\K[0-9]+')
                            if [[ "$ttl" == "64" ]]; then
                                so="Linux"
                            elif [[ "$ttl" == "128" ]]; then
                                so="Windows"
                            else
                                so="Otro/Desconocido"
                            fi
                            linea_servicio=" [+]  $octeto1.$octeto2.$octeto3.$i  ------------------------- TTL= $ttl ----- SO= $so"
                            echo "$linea_servicio"
                            if [[ -n "$archivo" ]]; then
                                echo "$linea_servicio" >> "$archivo"
                            fi
                            for puerto in "${!puertos[@]}"; do
                                {
                                    if nc -z -w 1 "$octeto1.$octeto2.$octeto3.$i" "$puerto" 2>/dev/null; then
                                    linea_servicio=" Puerto: $puerto -------------------------- Servicio: ${puertos[$puerto]}"
                                    echo "$linea_servicio"
                                    if [[ -n "$archivo" ]]; then
                                        echo "$linea_servicio" >> "$archivo"
                                    fi
                                fi
                                } &
                            done
                            wait
                        else
                            echo "Ping fallido!" &> /dev/null
                        fi
                    done
                done
            done
            ;;
        16)
            for i in {0..255};do
                for j in {0..255};do
                    respuesta=$(ping -c 1 -w 1 "$octeto1.$octeto2.$j.$i" && echo "Ping a $octeto1.$octeto2.$j.$i exitoso")
                    if [[ $? -eq 0 ]]; then
                        ttl=$(echo "$respuesta" | grep -oP 'ttl=\K[0-9]+')
                        if [[ "$ttl" == "64" ]]; then
                            so="Linux"
                        elif [[ "$ttl" == "128" ]]; then
                            so="Windows"
                        else
                            so="Otro/Desconocido"
                        fi
                        linea_servicio=" [+]  $octeto1.$octeto2.$j.$i  ------------------------- TTL= $ttl ----- SO= $so"
                        echo "$linea_servicio"
                        if [[ -n "$archivo" ]]; then
                            echo "$linea_servicio" >> "$archivo"
                        fi
                        for puerto in "${!puertos[@]}"; do
                            {
                                if nc -z -w 1 "$octeto1.$octeto2.$j.$i" "$puerto" 2>/dev/null; then
                                    linea_servicio=" Puerto: $puerto -------------------------- Servicio: ${puertos[$puerto]}"
                                    echo "$linea_servicio"
                                    if [[ -n "$archivo" ]]; then
                                        echo "$linea_servicio" >> "$archivo"
                                    fi
                                fi
                            } &
                        done
                        wait
                    else
                        echo "Ping fallido!" &> /dev/null
                    fi
                done
            done
            ;;
        24)
            for i in {1..254}; do
                respuesta=$(ping -c 1 -w 1 "$octeto1.$octeto2.$octeto3.$i" && echo "Ping a $octeto1.$octeto2.$octeto3.$i exitoso")
                if [[ $? -eq 0 ]]; then
                    ttl=$(echo "$respuesta" | grep -oP 'ttl=\K[0-9]+')
                    if [[ "$ttl" == "64" ]]; then
                        so="Linux"
                    elif [[ "$ttl" == "128" ]]; then
                        so="Windows"
                    else
                        so="Otro/Desconocido"
                    fi
                    linea_servicio=" [+]  $octeto1.$octeto2.$octeto3.$i  ------------------------- TTL= $ttl ----- SO= $so"
                    echo "$linea_servicio"
                    if [[ -n "$archivo" ]]; then
                        echo "$linea_servicio" >> "$archivo"
                    fi
                    for puerto in "${!puertos[@]}"; do
                        {
                            if nc -z -w 1 "$octeto1.$octeto2.$octeto3.$i" "$puerto" 2>/dev/null; then
                                linea_servicio=" Puerto: $puerto -------------------------- Servicio: ${puertos[$puerto]}"
                                echo "$linea_servicio"
                                if [[ -n "$archivo" ]]; then
                                    echo "$linea_servicio" >> "$archivo"
                                fi
                            fi
                        } &
                    done
                    wait
                else
                    echo "Ping fallido!" &> /dev/null
                fi
            done
            ;;
    esac
}

echo -e "\n"

if $registrar_tiempo; then
    inicio=$(date +%s)
fi

ping_a_ips "$dir_red"



if $registrar_tiempo; then
    fin=$(date +%s)
    duracion=$((fin - inicio))
    echo "Tiempo de ejecución : $duracion s"

fi

echo "Escaneo completado"

if [[ -n "$archivo" ]]; then
    echo "Tienes el output en $archivo"
fi
