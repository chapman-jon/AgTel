# Consultant app — field ride-along UX notes (April 2026)

*Product team — K. Ibarra. Raw observations from 6 ride-alongs (IA x2, NE, MN, SK, ON).*

Not a formal study. Themes below, anonymized.

## What we saw

1. **Connectivity is worse than our personas assume.** Two consultants worked
   most of the day with zero bars. Everything they rely on is either printed the
   night before or memorized. Offline-first isn't a nice-to-have (this is the
   fourth doc saying this, but now with photos).
2. **Paper maps annotated by hand, every truck.** Field boundaries from the
   systems are treated as "roughly right." One consultant: "the acres in the
   system are for billing, my sprayer knows the real acres."
3. **Nobody types during a farm visit.** Voice memos and photos, transcribed in
   the evening. If observation capture requires typing in the cab, it will not
   be used. Big push for photo + geotag + short voice note as the atomic unit.
4. **Trust anecdotes, unprompted, at 5 of 6 visits.** Consultants keep private
   spreadsheets because "the system loses things" (their words — usually it's a
   record they can see in one system but not the one they're standing in front
   of). This is the adoption risk the parity work is meant to quantify; the
   ride-alongs put faces on it but don't change the plan.
5. **Two consultants asked for trial plot visibility** (they host research group
   trials). Noted for the badge question in the requirements draft; architecture
   pushback stands.

## Immediate product implications

- MVP observation capture: photo + geotag + voice note, transcription async.
- Show data source and last-updated on every entity screen. Consultants respond
  well to honesty about staleness ("if the app admits it, I trust it more").
- Boundary editing stays out of scope; annotation layer post-MVP.

Next round of ride-alongs targeted for post-harvest (Oct/Nov).
