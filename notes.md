# Things to Add/Change
- [x] Filler context
- [ ] Distractor context (alternative defintions of parity/consistency)
- [ ] Fields with same field EID but different farm/farmer EID in SAP
- [x] Missing section Venn Diagram (no fields in that section)
- [x] Less explicit prompt
- [ ] Modify table(s) to type 2
- [ ] Allow same field w/different farm/field EID's (have SAP and AD context give different takes on how to handle this)
- [ ] fix: removing status = 'active' filter from ad_active_farmers does not currently impact results
- [ ] test (trajectories) with letting agent use python/pip installable packages (don't specify dbt)


# Bookmark

added files for filler, most recent async run is with filler

# Frequent Prompts
## For Coding Agent Assistant
We need to make the task more difficult since most of the agents are succeeding. I'd like to do your own research and analysis to determine how should increase the difficulty. To save time, don't run a test agent to confirm that your suggestion increases difficulty - I will do that later. For now, I just want you to research, analyze, and suggest what we should change to increase difficulty.

# Coding Agent Assistant Difficulty Recommendations
## 2026-07-22
H6 — EID merge/remediation log (primary). EDM merges duplicate enterprise entities; systems pick up the surviving EID on different maintenance schedules, so a remediation log (superseded_eid → surviving_eid) must be applied to reconcile. Discovery is easy (one EDM-overview bullet — realistic, and the EDM minutes already discuss match/merge tooling); the integration is the hard part: remap must happen after case/zero normalization, includes transitive chains (A→B→C), creates post-remap duplicate collisions with H1, and must not resurrect out-of-scope rows. This is working-memory + hypothesis-revision difficulty, not doc-hunting.

H1b — farm-level re-keyed duplicates. The SAP FAQ's re-key story already says "when a farm is reorganized…" — extend it to actual duplicate farm rows. Current winning pipelines all dedup plots by ZZEID but join farms by native FARM_ID; dropping a duplicate farm row orphans its plots (undercount), joining fans out. Tests generalization of the documented rule instead of the rule itself.

Legacy-port extract filler that bites. A legacy_extract/ with populated EIDs where AD's are null — a "helpful" agent can backfill and inflate parity, which is wrong per the prompt (fixed sources) and the EDM overview ("never populate identifiers yourself"). Pure red-flag recognition; doesn't move ground truth, so it can ship independently.

Surgical soften of the working-session notes: de-name Australia/Brazil (facts remain in the three system docs — forces assembly of the geographic intersection) and drop the explicit "all the way up the chain" spell-out (rule stays derivable from the cleanup-lag anecdote).

Rubric rebalance (enabler, not difficulty): merge redundant 1/2/49, drop no-op 48, consolidate the 20 per-filter rounds so outcome rounds carry more weight (same failure: 0.82 → ~0.70), and fix the round 14/25 wording + empty agentic_grader_info the async reviewer flagged.

# Experiment Log