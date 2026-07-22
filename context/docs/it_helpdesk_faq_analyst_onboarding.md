# IT Helpdesk — Analyst onboarding FAQ (extract)

*Consulting IT service desk. Last touched: March 2026. Ticket queue: IT-ANALYTICS.*

**Q: How do I get access to the reporting share / extracts?**
A: Request "Analytics - Reporting Share (Read)" in the service portal. Approval
is your manager plus the data platform team. BST, SAP, and AgDigital extracts
all land there on their respective schedules; you do not need system logins to
use the extracts.

**Q: Do I need a BST login? SAP?**
A: Only if you need to *enter or correct* data. Analysts working from extracts
generally don't. BST licenses are managed by Consulting IT; SAP access goes
through the SAP CoE and requires role mapping (allow 2-3 weeks).

**Q: What Python/database tooling is approved on analyst laptops?**
A: The standard analytics image ships with Python 3.12, git, and VS Code.
Anything installable from the corporate PyPI mirror is fine (this includes
duckdb, dbt, pandas, etc.). Local databases are fine for development. Don't
stand up anything that other people connect to — that's what the warehouse is
for; see the platform team's migration notes.

**Q: Where do I put deliverables?**
A: Team schema in the warehouse for data; team SharePoint for docs. Flat files
emailed around will be hunted down and deleted by the platform team (they are
not joking).

**Q: My extract has a column full of GUIDs — what is that?**
A: Almost certainly an Enterprise ID. See the EDM team's "Enterprise IDs —
Overview" page before doing anything clever with it.

**Q: Who supports the AgDigital (AD) datasets?**
A: The AgDigital platform team (#agdigital-platform). They keep their own
runbook notes on the port; read those before filing tickets about "missing"
records — several of the common surprises are documented behavior.

**Q: VPN drops on rural site visits?**
A: Known issue with the carrier handoff; reconnect usually works. If you're
supporting consultants in the field, download what you need beforehand.
