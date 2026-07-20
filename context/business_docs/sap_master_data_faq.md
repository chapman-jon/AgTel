# SAP Ag Master Data — Frequently Asked Questions

*Owner: SAP CoE, Master Data team (M. Villanueva)*
*Audience: anyone consuming the ZAGT_* extracts or reporting on ag master data.*

This FAQ collects the questions we answer most often about the custom ag master data tables (`ZAGT_PARTNER`, `ZAGT_FARM`, `ZAGT_PLOT`). If your question isn't answered here, post in `#sap-coe`.

---

**Q: What do the ZZSTAT status codes mean?**

A: `ZZSTAT` is the lifecycle status used on all three ZAGT tables:

- `01` — Created. The record has been entered but is not yet operational (e.g. partner onboarding not finished, farm/plot awaiting confirmation from the field team).
- `02` — Active. The record is operational. This is the status the business means when they say a partner/farm/plot is "active."
- `03` — Deactivated. The record has been closed out and is retained for reporting history.

**Q: A record has ZZSTAT = '02' but LOEVM = 'X'. Is it active?**

A: No. `LOEVM` is the standard SAP deletion flag and it takes precedence over `ZZSTAT`. When a record is flagged for deletion (`LOEVM = 'X'`), it is excluded from operational use regardless of its lifecycle status. The combination you're describing usually means the deletion was flagged after the status was last maintained — the archiving job will eventually clean these up. Treat any record with `LOEVM = 'X'` as not active.

**Q: What is the difference between PARTNER_TYPE 'C' and 'P'?**

A: `C` = Customer, `P` = Prospect. Prospects are potential customers entered by the sales organization for pipeline tracking — they are leads, not operating relationships. A prospect's farm/plot data, where it exists at all, is typically sparse and unverified (sales reps sometimes sketch in a farm or a couple of plots during pursuit). Prospects are converted to `C` if the relationship is won.

**Q: Which countries are in SAP?**

A: The ag master data covers the **US**, **Canada**, and **Brazil** (`LAND1` = `US`, `CA`, `BR`). Brazil came in with the 2021 ERP consolidation of the South America business. Note that Brazil operations run entirely on SAP — the Brazilian business does not use BST or any AgDigital systems.

**Q: Why are plot areas in hectares when BST uses acres?**

A: SAP follows the corporate standard (metric). BST predates that standard. Convert as needed (1 ha ≈ 2.4711 acres); there is no plan to re-unit either system.

**Q: What is ZZEID?**

A: The Enterprise ID of the record, populated by the central Enterprise Data Management assignment process. See the EDM team's Enterprise IDs overview page for details — the short version is that it's a cross-system GUID identifying the real-world entity, and it is null on records that haven't been through assignment yet. The SAP team does not maintain this column manually. (Per SAP character-field convention the value is stored uppercase, like everything else in the ZAGT tables.)

**Q: I found two plots with the same ZZEID. Which one is wrong?**

A: Probably neither. When a farm is reorganized or a plot is re-surveyed, the field team's process is to create a new plot record rather than edit the old one in place (the old record often has open document flows against it, so it stays active until year-end closing archives it). Both records describe the same physical plot of land, and EDM's assignment process links both to the same enterprise entity — which is exactly what ZZEID is supposed to mean. So a duplicated ZZEID is not a data error; it's two active records for one real-world plot. Reporting that counts physical plots should count distinct ZZEIDs, not rows — the reporting team was bitten by this in the acreage summary last year.

**Q: Can I get an extract refreshed?**

A: Extracts of the ZAGT tables are published weekly to the reporting share. Ad-hoc refreshes require a ticket to the SAP CoE with director approval.
