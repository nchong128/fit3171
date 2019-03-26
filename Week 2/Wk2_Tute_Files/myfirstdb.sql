set echo on

create table myfirstDB (
  column1 number(8) not null,
  column2 varchar(50) not null,
  column3 varchar(50) not null,
  constraint pk_myfirstdb primary key (column1));

-- Adding data to the table


insert into myfirstdb values (1,'a','aa');
insert into myfirstdb values (2,'b','bb');
insert into myfirstdb values (3,'c','bb');
insert into myfirstdb values (4,'d','dd');

COMMIT;

set echo off

