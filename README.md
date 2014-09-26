# Plexts

Ingress Intel Map API Caller

## Description

* all, faction, alerts message to console
* get the information of the portals in Json format
* get the information of the artifacts in Json format

## Setup

```
cp .env.sample .env
```

write .env

## Using CLI


```
$ rake build
plexts 0.0.1 built to pkg/plexts-0.0.1.gem.
$ gem install pkg/plexts-0.0.1.gem
Successfully installed plexts-0.0.1
Parsing documentation for plexts-0.0.1
Done installing documentation for plexts after 0 seconds
1 gem installed
$ rbenb rehash # If necessary
$ plexts -h
Usage: plexts [options]
    -c, --console                    show all or faction, aleart messages
    -e, --entity                     show portals infomation of JSON format
        --lat VALUE                  portal Latitude
        --lng VALUE                  portal Longitude
    -z VALUE                         map zoom level 1-20
    -a, --artifacts                  artifacts infomation of JSON format
```

## Caution

This application should be used at your own risk.
When you use it, there is a possibility that the account is stopped.

## Licence

Released under the [WTFPL license](http://www.wtfpl.net/).
