# Server Side Events Demo

A demo for using server side events with Rails.

## Installation

Clone the project, `cd` it and `bundle install`.

## Usage

`[RAILS_CACHE_CLASSES=true] rails s`

Set `RAILS_CACHE_CLASSES` to `true`/any other value in order to enable/disable Rails classes caching in development environment. Rails classes caching enabling allows to reload the code at page refresh, but using it together with server side events does not allow to serve more than one request at time.

## TODO

### Lato client

#### Gestione stati disconnessione/riconnessione

Quando cade la linea e il client va giù per così tanto tempo da andare offline dovrebbe tentare di riconnettersi.
