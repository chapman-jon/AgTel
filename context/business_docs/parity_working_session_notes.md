# parity kickoff — raw notes

JM, SC, PD, + RO for the first half hour. Scribe PD, typing while people talked, sorry for the mess. Cleaning this up is on my list but don't wait for it.

goal today: settle the scope questions before anyone builds anything, so the numbers don't get relitigated after leadership sees them.

JM opened w/ the usual context — app launch gated on knowing how bad the disparity actually is. venn + one topline number, rerunnable later to show progress.

then a LONG back and forth about what population of records even counts. RO: BST is full of inactive + pending growers going back a decade, plus the research group's stuff. SC: AD has its own junk, archived legacy things, leftovers from port validation. and the SAP CoE FAQ tells the same story on their side (deactivations, deletion flags, the sales pipeline entries). PD pointed out if all of that goes in, the venn is mostly noise — BST-only bar inflated by growers who churned in like 2016. nobody argued.

where we landed: the measurement is over records that are live/operational in their own home system, going by however that system itself defines that — each team's own docs spell out their definitions and we are NOT re-defining anybody's semantics in this meeting. RO was emphatic about this and honestly it's the only defensible line. if it isn't operational in its home system it just doesn't participate, full stop, it's not a data point in the venn anywhere.

SC follow-up that ate 15 min: what about a live field hanging under a farm that isn't live? RO says this genuinely happens in BST (their cleanup job lags, so a field can still look fine after its grower was retired). group agreed those fields are effectively dead weight — nobody would call that an operational field, and JM does not want them showing up as "disparity" noise either. so whether something participates is a question you have to ask all the way up the chain, not just at the field row. same logic in every system.

geography — JM raised the Australia thing (BST-only) and PD immediately matched it with SAP/Brazil. comparing those against AD makes no sense, AD will never have them, it's structural not a data quality gap. so: measure where the systems actually overlap geographically, and scope it per system using each system's own country column (RO warned the formats differ, don't assume they line up).

matching mechanism: EIDs, no debate. EDM's guidance, and nobody in the room wants to defend name matching (SC has been burned, see her runbook notes).

parking lot:
- actually increasing parity (EID backfill acceleration, dedupe tooling) — out of scope for the measurement phase, revisit after baseline
- SC: farm-level / farmer-level venns later? JM: maybe, not now
- next session once first-cut numbers exist

— pd
