# Berlin Open Data JSON Schema

2013 - 2019, Knud Möller

Schema to describe and validate dataset descriptions for the Berlin Open Data Portal at https://daten.berlin.de. Using JSON Schema v4 (https://json-schema.org). The base schema is the CKAN dataset schema. Its interpretation and the extras are similar to the OGD (Open Government Deutschland) schema defined here: https://github.com/fraunhoferfokus/ogd-metadata.

This repository holds the schema source and code to derive an HTML representation as well as code snippets to be used in applications relating to the schema.

The current official schema is found at https://datenregister.berlin.de/schema.

## Make Targets

The [Makefile](Makefile) orchestrates generation of the schema and matching HTML documentation.
Three relevant targets are:

- `documentation`: Create HTML documentation and schema (via dependencies). Output is in `web`.
- `imperia-selection-lists`: Extract value lists from the schema and build HTML selection lists from them. Output is in `options`.
- `clean`: Remove all temporary or derived files.

## Requirements

* Ruby - tested with 2.4.1, but may well work with earlier versions.
* `thor` gem - tested with 0.20.0


## License

This code is released under the MIT License (see `LICENSE`).

