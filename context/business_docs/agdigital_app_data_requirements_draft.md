# AgDigital Consultant App — Data Requirements (DRAFT)

*Author: product team (K. Ibarra) — DRAFT v0.3, circulated for comment*

> This is a working draft of the data requirements for the consultant mobile app. Nothing here is final. Comments to K. Ibarra.

## Overview

The consultant app will be the primary interface for consultants to view their grower relationships, plan applications, and capture field-level observations. The app reads from the AgDigital platform (AD dataset) and will eventually write back to it.

## Data the app needs at launch (MVP)

| Data | Source | Notes |
|---|---|---|
| Farmer profile (name, location) | AD | Read-only at MVP |
| Farm list per farmer | AD | Read-only at MVP |
| Field list per farm, with boundaries/areas | AD | Boundary data incomplete in AD — see open questions |
| Observation capture (photos, notes, geotag) | New — app writes | New collection, not in any current system |
| Product application plans | Deferred | Post-MVP; consultants use BST for this today |

## Post-MVP candidates

- Weather overlays (third-party feed, licensing under review)
- Yield history (source TBD — possibly grower-shared combine data)
- Offline mode for rural connectivity (high consultant demand)
- Farmer-facing companion app (leadership priority, timing TBD)

## Open questions

1. **Data trust / consistency.** Consultants already see the same farmer represented differently in BST vs SAP. If the app shows AD data that disagrees with what they see in BST, adoption is at risk. The parity measurement work currently underway will tell us how big this problem is. App timeline is dependent on that readout. (For our own launch-gate tracking I'd propose something like "% of AD fields that are also found in BST and SAP" as the go/no-go number — TBD, the analytics team owns the actual parity definitions and I hear theirs differs, so defer to whatever they publish.)
2. Boundary data gaps in AD (`area_ha` nulls) — do we show fields without areas, or hide until backfilled?
3. Do we badge trial plots for consultants who cooperate with the research group? (Research group asked; trial plots live only in BST, so this would require the app to read from BST — architecture team pushing back.)
4. Identity: app login for consultants is corporate SSO, but the future farmer-facing version needs external identity — out of scope for MVP.

## Non-goals for MVP

- No editing of master data from the app (all master data changes continue through existing system processes).
- No offline-first sync engine at MVP (see post-MVP).
- The app does not attempt to merge or reconcile records across systems — it presents AD data only. Cross-system reconciliation is a platform/EDM concern, not an app feature.
