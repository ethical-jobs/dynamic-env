#!/usr/bin/env bash

BASE_DIR="${BASE_DIR:-.}"

while true
do
    read -p "Name of variable: " VAR_NAME

    if [[ ! -z ${VAR_NAME} ]]
    then
        break;
    fi
done

read -p "Default value for variable '${VAR_NAME}': " VAR_DEFAULT_VALUE

echo "Would you like to base64 encode the value?"
select ENCODE in Yes No;
do
    case ${ENCODE} in
        "Yes")
        VAR_DEFAULT_VALUE="base64:`echo ${VAR_DEFAULT_VALUE} | base64`"
        break
        ;;
        "No")
        break
        ;;
    esac
done

echo "Should value be quoted?"
select VAR_TYPE in Yes No;
do
    case ${VAR_TYPE} in
        "Yes")
        VAR_DEFAULT_VALUE="\"${VAR_DEFAULT_VALUE}\""
        break
        ;;
        "No")
        break
        ;;
    esac
done

echo ${VAR_NAME}=${VAR_DEFAULT_VALUE} |tee -a ${BASE_DIR}/.env.example
