create user promscale with password 'promscale';
create database promscale owner  promscale ;
grant all privileges on database n9e to promscale;


create user n9e with password 'n9e';
create database n9e owner  n9e ;
grant all privileges on database n9e to n9e;


create user ibex with password 'ibex';
create database ibex owner  ibex ;
grant all privileges on database ibex to ibex;


create user kong with password 'kong';
create database kong owner  kong ;
grant all privileges on database kong to kong;