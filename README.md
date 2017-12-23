# README

Simple Web App that takes a query-string, sends a GET-request to a third-party
geocoding service (currently supports google and osm), parses the result and
renders the long/lat JSON result. Only searches in germany.

* Usage

 - /search_locations/<QUERY> or /search_locations?query=<QUERY> for a simple
rendered lat/long JSON-result
- uses google or osm geocoding (set via env var)

* TODO

- more documentation (e.g. design choices)
- deploy to heroku for live-showcase
- Fix: random failing tests (test order and HTTP mocks)

* NOTE

- implemented outside of normal dev-environment with Win10 64 build-in
ubuntu app

* Possible extensions

- include name of used third-party geocoding service in result
- cache geocoding results per uniq query-string e.g. (per geocode-gem)
- more robust error handling and/or config vars (e.g. on api url changes)
