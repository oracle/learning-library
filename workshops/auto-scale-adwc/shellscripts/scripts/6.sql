with q1 as
(select d_year, s_city, p_brand1, sum(lo_revenue - lo_supplycost) as profit
from ssb.dwdate, ssb.customer, ssb.supplier, ssb.part, ssb.lineorder
where lo_custkey = c_custkey
and lo_suppkey = s_suppkey
and lo_partkey = p_partkey
and lo_orderdate = d_datekey
--and c_region = 'AMERICA'
and c_region = 'AMERICA'
and c_region != 'ASIA'
and c_region != 'AFRICA'
and c_region != 'EUROPE'
and c_region != 'MIDDLE EAST'
and ssb.customer.c_mktsegment !='HOUSEHOLD'
group by d_year, s_city, p_brand1 order by d_year, s_city, p_brand1)
select * from q1;
with q1 as
(select d_year, s_city, p_brand1, sum(lo_revenue - lo_supplycost) as profit
from ssb.dwdate, ssb.customer, ssb.supplier, ssb.part, ssb.lineorder
where lo_custkey = c_custkey
and lo_suppkey = s_suppkey
and lo_partkey = p_partkey
and lo_orderdate = d_datekey
--and c_region = 'AMERICA'
and c_region = 'AMERICA'
and c_region != 'ASIA'
and c_region != 'AFRICA'
and c_region != 'EUROPE'
and c_region != 'MIDDLE EAST'
and ssb.customer.c_mktsegment !='HOUSEHOLD'
group by d_year, s_city, p_brand1 order by d_year, s_city, p_brand1)
select * from q1;
