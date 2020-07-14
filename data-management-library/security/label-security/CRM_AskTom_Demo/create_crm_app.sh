#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


sqlplus -s / as sysdba <<EOF

alter session set container=pdb1;

prompt create user crm identified by Oracle123;;
prompt grant connect, resource, unlimited tablespace to crm;;
prompt 
prompt create table crm.customers(
prompt 	customer_id VARCHAR(50),
prompt 	firstname VARCHAR(50),
prompt 	lastname VARCHAR(50),
prompt 	email VARCHAR(50),
prompt 	gender VARCHAR(50),
prompt 	country VARCHAR(50),
prompt 	active VARCHAR(50)
prompt
prompt create customer_id sequence...
prompt
prompt insert 50 rows into CRM.CUSTOMERS...
prompt

create user crm identified by Oracle123;
grant connect, resource, unlimited tablespace to crm;

alter session set current_schema=crm;
SET FEEDBACK OFF
SET ECHO OFF
SET FEED OFF
SET VERIFY OFF
SET HEADING OFF
--drop table crm.customers;
create table crm.customers(
	customer_id VARCHAR(50),
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	email VARCHAR(50),
	gender VARCHAR(50),
	country VARCHAR(50),
	active VARCHAR(50)
);

--drop sequence crm.customer_id_seq;
create sequence crm.customer_id_seq start with 100 increment by 1 nocache nomaxvalue;
delete from crm.customers;

insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Elisabetta', 'Pauls', null, 'Female', 'United States', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Wendie', 'Kochs', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Johnette', 'Joncic', null, 'Female', 'United States', 'Y');

insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Joline', 'Cornelissen', null, 'Female', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Frants', 'Linbohm', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Wolfgang', 'Klainer', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Miran', 'Castiblanco', null, 'Female', 'Japan', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Zed', 'Balogh', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Veronike', 'Summersby', null, 'Female', 'England', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Claudine', 'Peskin', null, 'Female', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Drusy', 'Powles', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Rodi', 'Wandrey', null, 'Female', 'Japan', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Worthy', 'Scandred', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Cherise', 'Sember', null, 'Female', 'Japan', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'De witt', 'Allsworth', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Kahlil', 'Leipnik', null, 'Male', 'United States', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Salaidh', 'Sneddon', null, 'Female', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Xymenes', 'Raatz', null, 'Male', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Christy', 'Quarton', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Davie', 'Maybey', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Willard', 'Runge', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Adolphe', 'Raittie', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Idell', 'Myers', null, 'Female', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Hilton', 'Craxford', null, 'Male', 'Japan', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Eliot', 'Kohrs', null, 'Male', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Suzie', 'Marguerite', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Lemmie', 'Abrahamovitz', null, 'Male', 'England', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Marcille', 'Silley', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Nanine', 'Crossfeld', null, 'Female', 'England', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Edvard', 'Scrowby', null, 'Male', 'United States', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Josee', 'Putson', null, 'Female', 'England', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Claresta', 'Braywood', null, 'Female', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Archambault', 'Tomsu', null, 'Male', 'Japan', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Theresina', 'Beaver', null, 'Female', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Lenee', 'Sanchis', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Markus', 'Curado', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Tiffy', 'Pizzey', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Valdemar', 'Ends', null, 'Male', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Donovan', 'Sheering', null, 'Male', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Rodolph', 'Orto', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Yvor', 'Poleye', null, 'Male', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Murdoch', 'Gobel', null, 'Male', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Boy', 'Paladini', null, 'Male', 'England', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Dalenna', 'Rean', null, 'Female', 'France', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Darice', 'Addams', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Sheelah', 'Sayer', null, 'Female', 'France', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Sharai', 'Hooban', null, 'Female', 'United States', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Pip', 'Gabbett', null, 'Male', 'Japan', 'N');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Dierdre', 'Iskowitz', null, 'Female', 'United States', 'Y');
insert into CUSTOMERS (customer_id, firstname, lastname, email, gender, country, active) values (customer_id_seq.nextval, 'Quinta', 'De Hoogh', null, 'Female', 'United States', 'Y');

update CUSTOMERS set email = firstname||'.'||lastname||'@example.com' where email is null;

set feedback on;
set echo on;
set feed on;
set verify on;
set heading on;

prompt select count(*) from crm.customers;;
select count(*) from crm.customers;
--
EOF
