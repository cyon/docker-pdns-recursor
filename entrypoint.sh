#!/usr/bin/env bash
set -e

# Taken from https://github.com/dol/bash-envtpl/blob/master/envtpl.sh
function envtpl() {
    local PREFIX=$1
    local TARGET=$2
    local KEY_DELIMITER=${3:-_}
    local KEY_DELIMITER_REPLACEMENT=${4:--}
    local VALUE_DELIMITER=${5:-=}

    while IFS= read -r KEY_NAME; do
        KEY=${KEY_NAME#"${PREFIX}"}
        KEY=$(echo "${KEY,,}" | tr "${KEY_DELIMITER}" "${KEY_DELIMITER_REPLACEMENT}")
        echo "${KEY}${VALUE_DELIMITER}${!KEY_NAME}" >> "${TARGET}"
    done < <(compgen -v "${PREFIX}")
}

if [ "${1:0:1}" = '-' ]; then
    shift
    set -- pdns_recursor "$@"
fi

mkdir -p "${PDNS_INCLUDE_DIR}"

envtpl PDNS_RECURSOR_ "${PDNS_INCLUDE_DIR}/recursor.conf"

if [ "$1" = 'pdns_recursor' ]; then
    shift
    if [ "$#" -gt 0 ]; then
        exec /usr/sbin/pdns_recursor "$@" --include-dir="${PDNS_INCLUDE_DIR}"
    else
        exec /usr/sbin/pdns_recursor --help
    fi
fi

exec "$@"
