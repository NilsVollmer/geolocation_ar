# README

Simple Web App that takes a query-string, sends a GET-request to a third-party
geocoding service (currently supports google and osm), parses the result and
renders the long/lat JSON result. Only searches in germany.

## Usage

- /search_locations/<QUERY> or /search_locations?query=<QUERY> for a simple
rendered lat/long JSON-result
- uses google or osm geocoding (set via env var)

## TODO

- deploy to heroku for live-showcase
- Fix: random failing tests (test order and HTTP mocks)

## NOTE

- implemented outside of normal dev-environment with Win10 64 build-in
ubuntu app

## Possible extensions

- include name of used third-party geocoding service in result
- cache geocoding results per uniq query-string e.g. (per geocode-gem)
- more robust error handling and/or config vars (e.g. on api url changes)

## Design choices and explanation

- NetCommunicator encapsulates HTTP request with URI
- GoogleApiCommunicator and OsmApiCommunicator inherit from NetCommunicator and
just add the required additional code (e.g. API url and keys if required)
- Geocoder handles the call to the currently used communicator (set via env
  vars) and the parsing of the result (varies per API)
- the currently used API and the required vars can be set via .env file locally
(see .env.example) or via env-setup e.g. on heroku. This makes switching the
current API easy: just change the var and restart the application.
