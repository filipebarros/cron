# Cron

## Run the project

I used the example provided for testing:

```sh
bundle exec bin/cron parse '*/15' '0' '1,15' '*' '1-5' '/usr/bin/find'
```

The quotes on each parameter is to prevent special characters to be globbed.

## Run the specs

```sh
bundle exec rspec
```
