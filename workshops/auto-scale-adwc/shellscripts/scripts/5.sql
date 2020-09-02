SELECT count(*) from 
(
SELECT
dwdate_hier.member_name as year,
part_hier.member_name as part,
customer_hier.c_region,
customer_hier.member_name as customer,
lo_quantity,
lo_revenue
FROM ssb.ssb_av
HIERARCHIES (
dwdate_hier,
part_hier,
customer_hier)
WHERE
dwdate_hier.d_year = '1998'
AND dwdate_hier.level_name = 'MONTH'
AND part_hier.level_name = 'MANUFACTURER'
AND customer_hier.c_region = 'AMERICA'
AND customer_hier.level_name = 'NATION'
ORDER BY
dwdate_hier.hier_order,
part_hier.hier_order,
customer_hier.hier_order
);
