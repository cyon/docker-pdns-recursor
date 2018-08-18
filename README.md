# docker-pdns-recursor

## Usage

Note: Default [recursor.conf](../../wiki/Default-recursor.conf) listen on port 5353. The container image passes the following arguments on startup to overwrite the config. `disable-syslog=yes --daemon=no --local-address=0.0.0.0`.
```bash
$ docker run -d
    -p 53:5353 \
    cyon/pdns-recursor:latest
```


## Customize recursor.conf
Environment variables with the prefix `PDNS_RECURSOR_` are transformed to the corresponding config option.

E.g: `PDNS_RECURSOR_LOCAL_PORT=10053` transforms to `local-port=5353`
```bash
$ docker run -d --rm \
    --env PDNS_RECURSOR_WEBSERVER=yes \
    --env PDNS_RECURSOR_WEBSERVER_PORT=8080 \
    --env PDNS_RECURSOR_API_KEY=mysecretkey \
    --env PDNS_RECURSOR_WEBSERVER_ADDRESS=0.0.0.0 \
    --env PDNS_RECURSOR_LOCAL_PORT=10053 \
    -p 53:10053 \
    -p 8090:8080 \
    cyon/pdns-recursor:latest
```
