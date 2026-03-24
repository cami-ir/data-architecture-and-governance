# State-Aware MERGE Pattern
This sample SQL ensures that if Rule 001 finds an error on "Customer A" today, and it found that same error yesterday, you don't get two rows. You just update the "Last Seen" timestamp on the existing row.
