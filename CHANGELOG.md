# Changelog

## Development

## 2.2.1

- Automatically populate `properties/license_id` from https://datenregister.berlin.de/licenses/berlin-od-portal.json.
- Wrap everything in a Makefile.

## 2.2

- Fix license code and title for DL-DE-Zero-2.0.
- Add license code and title for DL-DE-BY-2.0.
- Remove GeoNutzV and GeoNutzVBerlin.

## 2.1

- `apps` property has been removed from the schema. It has never been used for any dataset, does not show up in the Datenregister form and is not shown in the Datenportal. If something like this is needed in the future, Apps should be added as a new type of package with a link to datasets used.

## 2.0

- Versioning and changelog introduced.
- To enable building selection lists from the schema, the enums for some properties
  have had human-readable `labels` added to them. In particular: `license_id` and
  `groups`. This is non-standard JSON-Schema.
- `group` (categories) values which cannot be mapped to DCAT-AP.de have been removed. These are:
  - `geo`
  - `protokolle`
  - `sonstiges`
  - All of these have in common that they do not denote a topic (like all other groups), but instead
    something orthogonal relating to the format (`geo` and `protokolle`) or simply meaning 
    "non of the above" (`sonstiges`).
- `Hausnummer` and `GPS-Koordinaten` have been added to `geographical_granularity`.

## 1.x

- unversioned schema before changes triggered by DCAT-AP.de, validation, etc.