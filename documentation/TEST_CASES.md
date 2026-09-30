# Testing Plan

| Test Case ID | Module | Input | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| TC01 | Patient | Valid patient data | Patient created with ID | Run locally | Pending |
| TC02 | Patient | Existing patient ID | Patient details returned | Run locally | Pending |
| TC03 | Appointment | Valid patient/doctor/date/time | Appointment created | Run locally | Pending |
| TC04 | Appointment | Same doctor/date/time again | HTTP 409 conflict | Run locally | Pending |
| TC05 | Billing | Existing patient | Bill created with zero initial total | Run locally | Pending |
| TC06 | Billing | Service + quantity 2 | Item amount = price × 2; trigger recalculates tax/total | Run locally | Pending |
| TC07 | Payment | Amount <= balance | Payment recorded and status updated | Run locally | Pending |
| TC08 | Payment | Amount > balance | HTTP 400 rejection | Run locally | Pending |
| TC09 | Reports | Revenue endpoint | Aggregated payment revenue returned | Run locally | Pending |
| TC10 | Reports | Patient history ID | Stored procedure returns appointment history | Run locally | Pending |
