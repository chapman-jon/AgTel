# Enterprise IDs (EIDs) — Overview

| | |
|---|---|
| **Owner** | Dana Whitfield, Enterprise Data Management |
| **Status** | Active / Ongoing initiative |
| **Audience** | All AgTel employees |
| **Related** | Master Data Management program, AgDigital data platform |

## Purpose of this page

Many of you have started to see references to "Enterprise IDs" (EIDs) in system documentation, data extracts, and project plans. This page explains what Enterprise IDs are, why we are investing in them, and what you should (and should not) expect from them today.

## Background

As a result of AgTel's growth through acquisitions, we operate several systems of record that describe the same real-world entities — the same farmer, the same farm, the same field — in different places, with different identifiers, and often with slightly different data. Historically there has been no reliable way to say "this record in one system is the same farmer as that record in another system."

The Enterprise ID initiative is our ongoing effort to fix that. The goal is simple to state: **every real-world entity should be identifiable consistently across all AgTel systems by a single, shared identifier.**

## What is an Enterprise ID?

An Enterprise ID is a globally unique identifier (GUID) assigned to a real-world entity, independent of any particular system. Enterprise IDs currently cover the following entity types, with more planned as the initiative progresses:

- Farmers
- Farms
- Fields
- Products
- Suppliers
- Equipment
- Retail locations

Each system continues to use its own native primary keys internally — we are not asking any system to change how it identifies its own records. Instead, the Enterprise ID is stored *alongside* the native key, as an additional attribute on the record. You can think of the native key as "how the system knows the record" and the Enterprise ID as "how AgTel knows the entity."

### Example

The same physical field, as it appears in three of our systems:

| System | Native primary key | Enterprise ID |
|---|---|---|
| BST | 118203 | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |
| SAP | 0004512378 | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |
| AD | ad-fld-000871 | `8f4c2a1e-7d3b-4e9a-b6f0-2c5d8e91a374` |

Three different native keys, three different formats, one Enterprise ID. Any process that needs to reconcile data across systems can join on the Enterprise ID rather than attempting fragile matching on names, addresses, or other attributes.

## Current state and known limitations

Please read this section carefully — it is the most common source of confusion.

**Enterprise ID assignment is an ongoing effort, not a finished one.** Assignment and backfill are being rolled out system by system and region by region. As of today:

- A record may have a **populated** Enterprise ID, meaning the record has been through the assignment process and linked to an enterprise entity.
- A record may have a **null / missing** Enterprise ID, meaning the record has not yet been through assignment, or could not be confidently linked at the time it was processed.

A missing Enterprise ID does **not** mean the entity doesn't exist in other systems. It only means we have not yet established the link. Likewise, teams consuming data should never invent, guess, or manually populate Enterprise IDs — assignment is owned centrally by Enterprise Data Management, and ad-hoc values would undermine the guarantee that a given EID means the same entity everywhere.

## Guidance for teams

- **If you are reconciling or comparing data across systems**, the Enterprise ID is the supported mechanism. Use it in preference to any name- or attribute-based matching.
- **If you find records you believe refer to the same entity but that carry different (or missing) Enterprise IDs**, do not "fix" the data yourself. Raise it with Enterprise Data Management so it can go through the assignment process.
- **If you are building a new system or dataset**, plan to carry the Enterprise ID as a first-class column for every covered entity type.

## Questions

Reach out in the `#enterprise-data-mgmt` channel, or contact Dana Whitfield directly. We are happy to walk teams through how Enterprise IDs apply to their specific use case.
