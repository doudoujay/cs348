select distinct student.snum, student.sname, student.deptid
from student
inner join Enrolled on Enrolled.snum = student.snum
where enrolled.grade != 'A';

select distinct fname
from
(select faculty.fname, count(faculty.fid) as cnt
from faculty
inner join class on class.fid = faculty.fid
group by faculty.fname)
where cnt >= 2;

select snum
from student
where deptid not in(
select deptid
from faculty, class
where class.fid = faculty.fid);
