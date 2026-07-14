# BST Administrator Guide — Record Statuses & Data Conventions (excerpt)

*Maintained by: BST System Administration (R. Okafor)*
*Last reviewed: this guide is reviewed annually. Sections below are excerpted from the full admin guide for circulation to analysts.*

## 1. Scope of BST

BST is the primary system used by AgTel consultants for grower planning and record keeping. BST holds grower, farm, and field master data for our **United States** and **Canada** operations. Following the integration of the Kalgoorlie AgServices acquisition (completed 2018), BST also carries our **Australia** operations — note that Australia exists *only* in BST; the Australian business has never been represented in AgTel's other systems.

## 2. Record status codes (`stat_cd`)

Growers, farms, and fields all carry a status code in the `stat_cd` column. The same code set is used on all three record types:

| Code | Meaning | Notes |
|---|---|---|
| `A` | Active | Record is live and in normal use. |
| `I` | Inactive | Record has been retired by a consultant or by the annual cleanup job. Kept for history; not in operational use. |
| `P` | Pending | Record setup was started but never completed (missing required attributes, awaiting approval, etc.). Pending records are **not** live and must not be treated as active. Most pending records are eventually completed (becoming `A`) or abandoned (becoming `I`). |

Support note: do not hard-delete records. Deletion requests are handled by setting `stat_cd = 'I'`.

## 3. Field use codes (`field_use_cd`)

Fields carry a use code distinguishing production fields from trial plots:

| Code | Meaning |
|---|---|
| `PROD` | Production field — an actual grower field that receives products and consulting services. |
| `TRIAL` | Trial plot — a plot used by the agronomy research group for product trials and demos. |

Trial plots are an internal BST convention used by the research group. They are frequently subdivided from production fields or staked out on cooperator land for a season, and they are managed entirely within BST — they are not grower fields in the usual sense and are not set up in any other AgTel system.

## 4. Housekeeping jobs

- Nightly: index maintenance, extract publication to the reporting layer (this is the source of the CSV extracts analysts receive).
- Annually (January): grower cleanup job — growers with no activity for 36 months are set to `I`, along with their farms and fields.

## 5. Support

For access requests or data corrections, open a ticket with the BST support queue (`BST-SUPPORT` in the service portal). Do not make manual edits to statuses without a ticket reference.
