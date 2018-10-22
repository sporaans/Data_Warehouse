--1
select rajons, pilseta, lietotajs, count (lietot_id) from
	(select a.rajons, a.pilseta,'Pardevēji' as lietotajs, a.lietot_id
	from d_lietotajs a, f_izsole b
	where a.lietot_id = b.pardevejs   
UNION ALL
	select a.rajons, a.pilseta,'Pircēji' as lietotajs, a.lietot_id
	from d_lietotajs a, f_izsole b
	where a.lietot_id = b.pircejs)
group by rajons, pilseta, lietotajs;
--2
select a.marka,a.modelis,a.gads,MAX(b.beigu_cena)
from   d_auto a, f_izsole b
where  a.auto_id=b.auto_id
group by a.marka,a.modelis,a.gads;
--3

--Diena
select to_char(datums,'DAY'),count(*)
from d_izsole_vest
group by to_char(datums,'DAY');
--Nedela
select to_char(datums,'WW'),count(*)
from d_izsole_vest
group by to_char(datums,'WW');
--Menesis
select to_char(datums,'Month'),count(*)
from d_izsole_vest
group by to_char(datums,'Month');

--4
select a.marka,a.modelis,avg(b.beigu_cena-b.sak_cena)
from   d_auto a, f_izsole b
where  a.auto_id=b.auto_id
group by a.marka,a.modelis;

--5
select a.auto_id,a.marka,a.modelis,count(*)
from   d_auto a, f_izsole b, d_izsole_vest c
where  a.auto_id=b.auto_id
and    b.izsole_id=c.izsole_id;