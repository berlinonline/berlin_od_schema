# Changelog

## Development

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