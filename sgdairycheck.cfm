select * from(select sum(qty) as qty,b.bth_qin,a.itemno,a.location,a.batchcode from ictran as a left join (select bth_qin,location,batchcode,itemno from lobthob)as b on a.itemno=b.itemno and a.batchcode=b.batchcode and a.location=b.location

where type in ('TRIN','OAI','CN','RC') and toinv='' and (void='' or void is null) group by a.itemno,a.batchcode,a.location) as aa where aa.qty<>aa.bth_qin