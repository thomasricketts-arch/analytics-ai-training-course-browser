# Analysis Notes: Monthly Active Customers by Vertical

## What the Query Does

Counts distinct active customers per business vertical for each of the last 6 months. A customer is "active" if they had at least one completed job in that month. The query uses a date spine to ensure all months appear in the output even if a vertical had zero activity, and calculates month-over-month growth using a LAG window function.

## What the Output Shows

As of March 2026, HVAC is the largest vertical by active customers (4,821), followed by Plumbing (3,994) and Electrical (2,108). Most verticals are growing modestly in the low single digits. Electrical is the only vertical declining in the most recent month (-4.8%).

Landscaping is the significant outlier: it has grown from 312 active customers in October 2025 to 1,847 in March 2026 — nearly 6x in six months — with MoM growth rates consistently between 33% and 57%.

## One Thing to Investigate Further

**Why is Landscaping growing so fast?** Before surfacing this in any report, I'd want to verify:
- Is this seasonal? (Spring ramp-up is plausible, but 6x growth is extreme even for a seasonal vertical)
- Was there a backfill, acquisition, or definition change that inflated the numbers?
- Does the absolute customer count match what the business team expects?

The Landscaping numbers are either a genuine growth story worth highlighting, or a data quality issue worth catching before it reaches a stakeholder.

## Open Questions

- **Why is Electrical declining while every other vertical grows?** It's the only vertical down MoM in March (-4.8%) and was also negative in December (-1.7%). Is this a market trend, a seasonality pattern, or a sign of churn worth investigating?
- **What was Landscaping's baseline before October 2025?** The 6-month window starts at 312 — if the prior months were even lower, the growth story is real. If they were similar to HVAC or Plumbing, something changed in the data.
- **Is "active customer" the right metric for all verticals equally?** A Landscaping customer might book seasonally by nature, while an HVAC customer might book year-round. Counting distinct customers per month may systematically undercount Landscaping in winter and overcount it in spring — making the growth look more dramatic than it is.
