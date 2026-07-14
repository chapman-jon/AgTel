# Notes — Parity working session (AgDigital)

Attendees: J. Marsh (AgDigital lead), S. Chen (platform), P. Duval (analytics), R. Okafor (BST admin, first 30 min only)
Scribe: P. Duval. Raw notes, lightly cleaned up. Decisions marked **DECISION**.

---

Context: kickoff for the field parity measurement work. Goal today was to agree on scope questions before anyone builds anything, so the numbers don't get relitigated after leadership sees them.

- JM: reiterated why we're doing this — app launch is gated on knowing how bad the disparity is. Wants the Venn + one topline number, refreshable later to show progress.

- Long discussion on what population of records even counts. RO pointed out BST is full of inactive and pending growers going back a decade, plus the research group's trial plots. SC said AD has archived legacy junk and the test records from port validation. Same story in SAP per the CoE FAQ (deactivation, deletion flags, prospects from sales).

- PD: if we include all that, the Venn is mostly noise — e.g. BST-only counts inflated by trial plots and by growers who churned years ago. Nobody disagreed.

- **DECISION: Parity is measured over records that are active in their own system, per that system's own definition of active. Anything not active in its home system is out of scope entirely — it does not appear in the Venn at all, not even as a "only in system X" count.** Each system team's docs define what active means for them (deferred to those — we are not re-defining active here).

- Follow-up q from SC: does "active" apply just to fields, or up the hierarchy? E.g. active field under an inactive farm. RO said in BST that state is rare but exists (cleanup job can lag). **DECISION: active applies at every level — a field is in scope only if the field, its farm, and its farmer are all active in that system. An active field under an inactive farm is effectively not operational, and we don't want it counting toward parity or disparity.**

- Geography. JM raised the Australia thing (BST-only) — comparing those against AD makes no sense, AD will never have them. Same logic for SAP's Brazil business. **DECISION: parity scope is the geographies the systems have in common. Scope by country using each system's country column — mind the different formats.**

- Matching: no debate, Enterprise IDs are the mechanism (EDM's guidance; nobody wants name matching). PD asked about records where EID is null — can't match, so by definition they sit in the "only in this system" bucket. JM confirmed that's the intent: unassigned EIDs are part of the disparity story, not something to work around. Consistent with how EDM says to treat nulls (no link established).

- JM on the hierarchy requirement: leadership's bar for "same field" is the full chain matching — field, farm, farmer EIDs all lining up across the systems in question. Anything less counts as disparity even if the field EID alone matches. (This is in the project brief as well — see the problem statement doc.)

- Deliverables recap (PD to carry into the build): Venn table for the dashboard + single Overall Field Parity metric. Formats per the project brief.

- Parking lot:
  - Increasing parity (EID backfill acceleration, dedupe tooling) — explicitly out of scope for this measurement phase. Revisit after baseline numbers are out.
  - SC asked whether farm-level or farmer-level parity Venns would be wanted later. JM: maybe, not now.
  - Next session: review first-cut numbers once the pipeline exists.
