Select onum, odate
from orders

where cnum = ( select cnum from cust where cname = 'Cisnerous')

Select snum,sum(amt)
from orders
group by snum
having sum(amt) > ( select max(amt)
           from orders);
Select cname
from cust a, orders b
where a.cnum = b.cnum and
            odate = '03-10-1994';

Select sname, snum
from salespeople
where snum in ( select snum from cust group by snum having count(snum) > 1 );

Select onum, a.cnum, a.snum, b.snum
from orders a, cust b
where a.cnum = b.cnum and
            a.snum != b.snum;

select onum, cnum, amt
from orders a
where amt > (  select avg(amt)
from orders b
where a.cnum = b.cnum
group by cnum);

Select odate, sum(amt)
from orders a
group by odate
having sum(amt) > ( select max(amt)
                                  from orders b
                                  where a.odate = b.odate
                                  group by odate);
Select a.cnum, a.cname
from cust a
where a.rating = (  select max(rating)
         from cust b
                     where a.city = b.city);
Select distinct cname
from cust a, salespeople b
where a.city = b.city and
           a.snum != b.snum;

Select cname
from cust
where cname in ( select cname
     from cust a, salespeople b
     where a.city = b.city and a.snum != b.snum );

Select * from cust
where 2 < (select count(*)
           from cust
           where city = 'San Jose');
Select snum
from cust
group by snum
having count(*) > 1;

Select snum, sname, city
from salespeople
where snum in ( select snum
                             from cust
                             group by snum
                             having count(*) > 1);

Select snum
from cust
group by snum
having count(*) = 1;

Select snum, count(snum)
from orders
group by snum
having count(snum) > 1;

Select a.snum
from salespeople a
where exists ( select b.snum
                         from cust b
                         where b.rating = 300 and
                                    a.snum = b.snum)

Select a.snum
from salespeople a, cust b
where b.rating = 300 and
            a.snum = b.snum;

Select snum, sname
from salespeople
where exists ( select cnum from cust where salespeople.city = cust.city and salespeople.snum != cust.snum);


Select sname
from salespeople
where snum in ( select snum from cust where salespeople.city = cust.city and salespeople.snum = cust.snum);

Select sname
from salespeople
where snum = any ( select snum from cust where salespeople.city = cust.city and salespeople.snum = cust.snum);

Select sname
from salespeople
where sname < any ( select cname from cust where salespeople.snum = cust.snum);

Select sname
from salespeople
where exists ( select cname from cust where salespeople.snum = cust.snum and salespeople.sname < cust.cname);

Select a.cname
from cust a
where city = 'Rome' and
           rating > ( select max(rating)
                           from cust
                           where city != 'Rome')
Select onum, amt
from orders
where odate != '06-oct-94' and
                  amt > ( select min(amt)
                                           from orders
                                     where odate = '06-oct-94');

Select onum, amt
from orders
where amt < any ( select amt
                  from orders, cust
                  where city = 'San Jose' and
                        orders.cnum = cust.cnum);




Select onum, amt
from orders
where amt < ( select max(amt)
                  from orders, cust
                  where city = 'San Jose' and
                        orders.cnum = cust.cnum);

Select * from cust
 where rating > any (select rating from cust
                     where city = 'Paris');

Select *
from cust a
where not exists ( select b.rating from cust b
                          where b.city != 'Paris' and
                                b.rating > a.rating);

Select cname, sname
from cust, salespeople
where rating >= any ( select rating from cust where snum = (select snum from salespeople where sname = 'Serres'))
            and sname != 'Serres'
and salespeople . snum = cust.snum;

Select sname
from salespeople
where snum in ( select snum
                            from cust
                           where salespeople.city != cust.city and
                                      salespeople.snum = cust.snum);

Select sname
from salespeople
where snum = any ( select snum
                                 from cust
                                       where salespeople.city != cust.city and
                                                           salespeople.snum = cust.snum);

Select onum, amt
from orders


where amt > any ( select amt
                                from orders, cust
                                where city = 'London' and
                                            orders.cnum = cust.cnum);

Select sname, cname
 from cust, salespeople
 where cust.city = 'London' and
       salespeople.city = 'London' and
       cust.snum = salespeople.snum;
Select snum, city, 'Customer Present'
from salespeople a
where exists ( select snum from cust
               where a.snum = cust.snum and
                     a.city = cust.city)
UNION
select snum, city, 'Customer Not Present'
from salespeople a
where exists ( select snum from cust c
               where a.snum = c.snum and
                     a.city != c.city and
                     c.snum not in ( select snum
                                         from cust
                                                 where a.snum = cust.snum and
                                             a.city = cust.city));

Select cname, city, rating, 'Higher Rating'
from cust
where rating >= 200
UNION


Select cname, city, rating, 'Lower Rating'
from cust
where rating < 200;



Select snum, sname
from salespeople
where snum in ( select snum  from cust where cust.snum = salespeople.snum and cust.city = 'London') and city = 'London';



Select sname, cname
from cust, salespeople
where cust.snum = salespeople.snum;


Select sname, cname
from cust, salespeople
where cust.snum = salespeople.snum
UNION
select distinct sname, 'No Customer'
from cust, salespeople
where 0 = (select count(*) from cust


     where cust.snum = salespeople.snum);

