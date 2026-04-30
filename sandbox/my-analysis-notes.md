# Analysis Notes: Monthly Active Customers by Vertical

## What the Query Does

The query counts distinct active customers per business vertical for each of the past 6 months. A customer is "active" if they had at least one completed job in that month. It uses a date spine to ensure every month appears in the output even if a vertical had zero activity, and calculates month-over-month growth percentage for each vertical.

## What the Output Shows

Five verticals are tracked: HVAC, Plumbing, Electrical, Landscaping, and Cleaning. HVAC and Plumbing are the largest verticals and show steady, modest growth (2–4% MoM). Electrical dipped slightly in March after several months of growth. Cleaning is small but consistent. Landscaping is the outlier — it grew from 312 active customers in October 2025 to 1,847 in March 2026, with MoM growth rates ranging from 33% to 57%.

## One Thing to Investigate Further

The Landscaping growth numbers warrant scrutiny before being shared with stakeholders. The near-6x increase in 5 months could reflect a real business expansion, a seasonal pattern, a vertical reclassification, or a data issue (e.g., a change in how `completed` status is defined). Next step: check whether job volume grew proportionally, and confirm with the Landscaping vertical owner whether this matches their expectations.
