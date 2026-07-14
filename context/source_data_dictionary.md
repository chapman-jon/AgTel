# Source Data Extracts — Data Dictionary

| | |
|---|---|
| **Owner** | AgDigital Data Platform |
| **Status** | Current |
| **Audience** | AgDigital analysts and engineers working with the source system extracts |

## About these extracts

To support analysis work in AgDigital, we pull periodic flat-file extracts of farmer, farm, and field data from the three systems of record: **BST**, **SAP**, and **AD** (AgDigital's port of legacy data). Each system contributes three tables, giving nine CSV files in total. The extracts are full snapshots (not incremental) taken from each system's reporting layer.

Note that each source system has its own history, conventions, and terminology, and the extracts intentionally preserve the source columns as-is rather than renaming them to a common standard. This page documents what each column is; for business definitions and rules of interpretation, refer to the documentation and notes maintained by the respective system teams.

The nine files:

| System | File | Entity |
|---|---|---|
| BST | `bst_growers.csv` | Farmers (BST calls them "growers") |
| BST | `bst_farms.csv` | Farms |
| BST | `bst_fields.csv` | Fields |
| SAP | `ZAGT_PARTNER.csv` | Farmers (SAP models them as business partners) |
| SAP | `ZAGT_FARM.csv` | Farms |
| SAP | `ZAGT_PLOT.csv` | Fields (SAP calls them "plots") |
| AD | `ad_farmers.csv` | Farmers |
| AD | `ad_farms.csv` | Farms |
| AD | `ad_fields.csv` | Fields |

---

## BST

BST came to AgTel through acquisition and is the primary system used by consultants in the field today. It is an older platform and uses abbreviated legacy column names. BST refers to farmers as **growers**.

### `bst_growers.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `grower_id` | integer | no | BST native primary key for the grower. | `20481` |
| `grower_nm` | text | no | Grower name. | `Hartley Family Farms Inc` |
| `stat_cd` | text | no | Record status code. Values observed: `A`, `I`, `P`. | `A` |
| `country` | text | no | Country, stored as full name. | `United States` |
| `state_prov` | text | yes | State or province. | `Iowa` |
| `entrpr_guid` | text (GUID) | yes | Enterprise ID of the grower. Populated when the record has been through enterprise assignment. | `c91b6a02-42fd-4e77-a8b3-91d0f2e6c554` |
| `crt_dt` | date | no | Date the record was created in BST. | `2014-03-19` |
| `upd_dt` | date | yes | Date the record was last updated. | `2025-11-02` |

### `bst_farms.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `farm_id` | integer | no | BST native primary key for the farm. | `55210` |
| `grower_id` | integer | no | BST grower that the farm belongs to. References `bst_growers.grower_id`. | `20481` |
| `farm_nm` | text | no | Farm name. | `Hartley North Farm` |
| `stat_cd` | text | no | Record status code. Values observed: `A`, `I`, `P`. | `A` |
| `country` | text | no | Country, stored as full name. | `United States` |
| `state_prov` | text | yes | State or province. | `Iowa` |
| `entrpr_guid` | text (GUID) | yes | Enterprise ID of the farm. | `77b3c6d8-8e10-49a4-9f2b-3f4a1c9d20e6` |
| `crt_dt` | date | no | Date the record was created in BST. | `2014-03-19` |
| `upd_dt` | date | yes | Date the record was last updated. | `2024-08-14` |

### `bst_fields.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `field_id` | integer | no | BST native primary key for the field. | `118203` |
| `farm_id` | integer | no | BST farm that the field belongs to. References `bst_farms.farm_id`. | `55210` |
| `field_nm` | text | no | Field name as entered by the consultant or grower. | `North 80` |
| `stat_cd` | text | no | Record status code. Values observed: `A`, `I`, `P`. | `A` |
| `field_use_cd` | text | no | Field use code. Values observed: `PROD`, `TRIAL`. | `PROD` |
| `acres` | numeric | yes | Field area in acres. | `78.3` |
| `country` | text | no | Country, stored as full name. | `United States` |
| `entrpr_guid` | text (GUID) | yes | Enterprise ID of the field. | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |
| `crt_dt` | date | no | Date the record was created in BST. | `2015-05-02` |
| `upd_dt` | date | yes | Date the record was last updated. | `2026-01-27` |

---

## SAP

SAP is AgTel's ERP. Farmer, farm, and field master data is held in custom Z-tables (`ZAGT_*`), and the extract files are named after the tables they come from. SAP models farmers as **business partners** and fields as **plots**. Column names follow SAP conventions (uppercase, abbreviated; several standard SAP fields are reused in the custom tables).

### `ZAGT_PARTNER.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `PARTNER_ID` | text, 10-digit zero-padded | no | SAP native key for the business partner. | `0001004523` |
| `NAME1` | text | no | Partner name. | `HARTLEY FAMILY FARMS INC` |
| `PARTNER_TYPE` | text | no | Partner type code. Values observed: `C`, `P`. | `C` |
| `LAND1` | text | no | Country, ISO 3166-1 alpha-2 code. | `US` |
| `REGIO` | text | yes | Region code (state/province) within the country. | `IA` |
| `ZZSTAT` | text | no | Partner lifecycle status code. Values observed: `01`, `02`, `03`. | `02` |
| `LOEVM` | text | yes | Deletion flag. `X` if the record is flagged for deletion, blank otherwise. | |
| `ZZEID` | text (GUID) | yes | Enterprise ID of the partner. | `c91b6a02-42fd-4e77-a8b3-91d0f2e6c554` |
| `ERDAT` | date | no | Date the record was created in SAP. | `2011-06-30` |

### `ZAGT_FARM.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `FARM_ID` | text, 10-digit zero-padded | no | SAP native key for the farm. | `0002001987` |
| `PARTNER_ID` | text, 10-digit zero-padded | no | Business partner that the farm belongs to. References `ZAGT_PARTNER.PARTNER_ID`. | `0001004523` |
| `FARM_DESC` | text | no | Farm description. | `HARTLEY NORTH FARM` |
| `LAND1` | text | no | Country, ISO 3166-1 alpha-2 code. | `US` |
| `REGIO` | text | yes | Region code within the country. | `IA` |
| `ZZSTAT` | text | no | Farm lifecycle status code. Values observed: `01`, `02`, `03`. | `02` |
| `LOEVM` | text | yes | Deletion flag. `X` if the record is flagged for deletion, blank otherwise. | |
| `ZZEID` | text (GUID) | yes | Enterprise ID of the farm. | `77b3c6d8-8e10-49a4-9f2b-3f4a1c9d20e6` |
| `ERDAT` | date | no | Date the record was created in SAP. | `2012-02-11` |

### `ZAGT_PLOT.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `PLOT_ID` | text, 10-digit zero-padded | no | SAP native key for the plot. | `0004512378` |
| `FARM_ID` | text, 10-digit zero-padded | no | Farm that the plot belongs to. References `ZAGT_FARM.FARM_ID`. | `0002001987` |
| `PLOT_DESC` | text | no | Plot description. | `NORTH 80` |
| `AREA_HA` | numeric | yes | Plot area in hectares. | `31.7` |
| `LAND1` | text | no | Country, ISO 3166-1 alpha-2 code. | `US` |
| `ZZSTAT` | text | no | Plot lifecycle status code. Values observed: `01`, `02`, `03`. | `02` |
| `LOEVM` | text | yes | Deletion flag. `X` if the record is flagged for deletion, blank otherwise. | |
| `ZZEID` | text (GUID) | yes | Enterprise ID of the plot. | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |
| `ERDAT` | date | no | Date the record was created in SAP. | `2013-09-04` |

---

## AD

AD is AgDigital's port of data from a legacy system, restructured into a modern schema. Native keys are prefixed strings (`ad-fmr-`, `ad-frm-`, `ad-fld-`).

### `ad_farmers.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `farmer_id` | text | no | AD native primary key for the farmer. | `ad-fmr-000412` |
| `farmer_name` | text | no | Farmer name. | `Hartley Family Farms Inc` |
| `status` | text | no | Record status. Values observed: `active`, `inactive`, `archived`. | `active` |
| `is_test` | boolean | no | `true` if the record was created for testing purposes during the port. | `false` |
| `country_code` | text | no | Country, ISO 3166-1 alpha-3 code. | `USA` |
| `enterprise_id` | text (GUID) | yes | Enterprise ID of the farmer. | `c91b6a02-42fd-4e77-a8b3-91d0f2e6c554` |
| `created_at` | timestamp | no | Timestamp the record was created in AD. | `2024-10-05T14:22:31Z` |
| `updated_at` | timestamp | yes | Timestamp the record was last updated. | `2026-02-18T09:03:12Z` |

### `ad_farms.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `farm_id` | text | no | AD native primary key for the farm. | `ad-frm-001206` |
| `farmer_id` | text | no | Farmer that the farm belongs to. References `ad_farmers.farmer_id`. | `ad-fmr-000412` |
| `farm_name` | text | no | Farm name. | `Hartley North Farm` |
| `status` | text | no | Record status. Values observed: `active`, `inactive`, `archived`. | `active` |
| `is_test` | boolean | no | `true` if the record was created for testing purposes during the port. | `false` |
| `country_code` | text | no | Country, ISO 3166-1 alpha-3 code. | `USA` |
| `enterprise_id` | text (GUID) | yes | Enterprise ID of the farm. | `77b3c6d8-8e10-49a4-9f2b-3f4a1c9d20e6` |
| `created_at` | timestamp | no | Timestamp the record was created in AD. | `2024-10-05T14:22:31Z` |
| `updated_at` | timestamp | yes | Timestamp the record was last updated. | `2025-12-01T16:44:09Z` |

### `ad_fields.csv`

| Column | Type | Nullable | Description | Example |
|---|---|---|---|---|
| `field_id` | text | no | AD native primary key for the field. | `ad-fld-000871` |
| `farm_id` | text | no | Farm that the field belongs to. References `ad_farms.farm_id`. | `ad-frm-001206` |
| `field_name` | text | no | Field name. | `North 80` |
| `status` | text | no | Record status. Values observed: `active`, `inactive`, `archived`. | `active` |
| `is_test` | boolean | no | `true` if the record was created for testing purposes during the port. | `false` |
| `area_ha` | numeric | yes | Field area in hectares. | `31.7` |
| `enterprise_id` | text (GUID) | yes | Enterprise ID of the field. | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |
| `created_at` | timestamp | no | Timestamp the record was created in AD. | `2024-10-06T08:15:47Z` |
| `updated_at` | timestamp | yes | Timestamp the record was last updated. | `2026-03-22T11:30:55Z` |

---

## General notes

- **Enterprise IDs.** Every table carries the Enterprise ID for its entity, under system-specific column names (`entrpr_guid` in BST, `ZZEID` in SAP, `enterprise_id` in AD). Enterprise ID assignment is an ongoing central initiative and these columns are nullable in all systems; see the Enterprise IDs overview page for background.
- **Status and code columns.** Code values are documented here as observed in the extracts. For what the codes mean and how each system team uses them, refer to that system's documentation and notes.
- **Units and formats are not harmonized.** For example, BST stores area in acres while SAP and AD use hectares, and each system stores country in a different format. Consumers are responsible for any conversions or mappings their use case requires.
