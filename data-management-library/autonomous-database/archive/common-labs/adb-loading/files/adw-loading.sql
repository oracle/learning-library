CREATE TABLE sales (

prod_id NUMBER NOT NULL,

cust_id NUMBER NOT NULL,

time_id DATE NOT NULL,

channel_id NUMBER NOT NULL,

promo_id NUMBER NOT NULL,

quantity_sold NUMBER(10,2) NOT NULL,

amount_sold NUMBER(10,2) NOT NULL);

CREATE TABLE salestemp (

prod_id NUMBER NOT NULL,

cust_id NUMBER NOT NULL,

time_id DATE NOT NULL,

channel_id NUMBER NOT NULL,

promo_id NUMBER NOT NULL,

quantity_sold NUMBER(10,2) NOT NULL,

amount_sold NUMBER(10,2) NOT NULL,

unit_cost NUMBER(10,2) ,

unit_price NUMBER(10,2) );

CREATE TABLE costs (

prod_id NUMBER NOT NULL,

time_id DATE NOT NULL,

promo_id NUMBER NOT NULL,

channel_id NUMBER NOT NULL,

unit_cost NUMBER(10,2) NOT NULL,

unit_price NUMBER(10,2) NOT NULL);

CREATE TABLE times (

time_id DATE NOT NULL,

day_name VARCHAR2(9) NOT NULL,

day_number_in_week NUMBER(1) NOT NULL,

day_number_in_month NUMBER(2) NOT NULL,

calendar_week_number NUMBER(2) NOT NULL,

fiscal_week_number NUMBER(2) NOT NULL,

week_ending_day DATE NOT NULL,

week_ending_day_id NUMBER NOT NULL,

calendar_month_number NUMBER(2) NOT NULL,

fiscal_month_number NUMBER(2) NOT NULL,

calendar_month_desc VARCHAR2(8) NOT NULL,

calendar_month_id NUMBER NOT NULL,

fiscal_month_desc VARCHAR2(8) NOT NULL,

fiscal_month_id NUMBER NOT NULL,

days_in_cal_month NUMBER NOT NULL,

days_in_fis_month NUMBER NOT NULL,

end_of_cal_month DATE NOT NULL,

end_of_fis_month DATE NOT NULL,

calendar_month_name VARCHAR2(9) NOT NULL,

fiscal_month_name VARCHAR2(9) NOT NULL,

calendar_quarter_desc CHAR(7) NOT NULL,

calendar_quarter_id NUMBER NOT NULL,

fiscal_quarter_desc CHAR(7) NOT NULL,

fiscal_quarter_id NUMBER NOT NULL,

days_in_cal_quarter NUMBER NOT NULL,

days_in_fis_quarter NUMBER NOT NULL,

end_of_cal_quarter DATE NOT NULL,

end_of_fis_quarter DATE NOT NULL,

calendar_quarter_number NUMBER(1) NOT NULL,

fiscal_quarter_number NUMBER(1) NOT NULL,

calendar_year NUMBER(4) NOT NULL,

calendar_year_id NUMBER NOT NULL,

fiscal_year NUMBER(4) NOT NULL,

fiscal_year_id NUMBER NOT NULL,

days_in_cal_year NUMBER NOT NULL,

days_in_fis_year NUMBER NOT NULL,

end_of_cal_year DATE NOT NULL,

end_of_fis_year DATE NOT NULL );

CREATE TABLE products (

prod_id NUMBER(6) NOT NULL,

prod_name VARCHAR2(50) NOT NULL,

prod_desc VARCHAR2(4000) NOT NULL,

prod_subcategory VARCHAR2(50) NOT NULL,

prod_subcategory_id NUMBER NOT NULL,

prod_subcategory_desc VARCHAR2(2000) NOT NULL,

prod_category VARCHAR2(50) NOT NULL,

prod_category_id NUMBER NOT NULL,

prod_category_desc VARCHAR2(2000) NOT NULL,

prod_weight_class NUMBER(3) NOT NULL,

prod_unit_of_measure VARCHAR2(20) ,

prod_pack_size VARCHAR2(30) NOT NULL,

supplier_id NUMBER(6) NOT NULL,

prod_status VARCHAR2(20) NOT NULL,

prod_list_price NUMBER(8,2) NOT NULL,

prod_min_price NUMBER(8,2) NOT NULL,

prod_total VARCHAR2(13) NOT NULL,

prod_total_id NUMBER NOT NULL,

prod_src_id NUMBER ,

prod_eff_from DATE ,

prod_eff_to DATE ,

prod_valid VARCHAR2(1) );

CREATE TABLE channels (

channel_id NUMBER NOT NULL,

channel_desc VARCHAR2(20) NOT NULL,

channel_class VARCHAR2(20) NOT NULL,

channel_class_id NUMBER NOT NULL,

channel_total VARCHAR2(13) NOT NULL,

channel_total_id NUMBER NOT NULL);

CREATE TABLE promotions (

promo_id NUMBER(6) NOT NULL,

promo_name VARCHAR2(30) NOT NULL,

promo_subcategory VARCHAR2(30) NOT NULL,

promo_subcategory_id NUMBER NOT NULL,

promo_category VARCHAR2(30) NOT NULL,

promo_category_id NUMBER NOT NULL,

promo_cost NUMBER(10,2) NOT NULL,

promo_begin_date DATE NOT NULL,

promo_end_date DATE NOT NULL,

promo_total VARCHAR2(15) NOT NULL,

promo_total_id NUMBER NOT NULL);

CREATE TABLE customers (

cust_id NUMBER NOT NULL,

cust_first_name VARCHAR2(20) NOT NULL,

cust_last_name VARCHAR2(40) NOT NULL,

cust_gender CHAR(1) NOT NULL,

cust_year_of_birth NUMBER(4) NOT NULL,

cust_marital_status VARCHAR2(20) ,

cust_street_address VARCHAR2(40) NOT NULL,

cust_postal_code VARCHAR2(10) NOT NULL,

cust_city VARCHAR2(30) NOT NULL,

cust_city_id NUMBER NOT NULL,

cust_state_province VARCHAR2(40) NOT NULL,

cust_state_province_id NUMBER NOT NULL,

country_id NUMBER NOT NULL,

cust_main_phone_number VARCHAR2(25) NOT NULL,

cust_income_level VARCHAR2(30) ,

cust_credit_limit NUMBER ,

cust_email VARCHAR2(50) ,

cust_total VARCHAR2(14) NOT NULL,

cust_total_id NUMBER NOT NULL,

cust_src_id NUMBER ,

cust_eff_from DATE ,

cust_eff_to DATE ,

cust_valid VARCHAR2(1) );

CREATE TABLE countries (

country_id NUMBER NOT NULL,

country_iso_code CHAR(2) NOT NULL,

country_name VARCHAR2(40) NOT NULL,

country_subregion VARCHAR2(30) NOT NULL,

country_subregion_id NUMBER NOT NULL,

country_region VARCHAR2(20) NOT NULL,

country_region_id NUMBER NOT NULL,

country_total VARCHAR2(11) NOT NULL,

country_total_id NUMBER NOT NULL,

country_name_hist VARCHAR2(40));

CREATE TABLE supplementary_demographics

( CUST_ID NUMBER not null,

EDUCATION VARCHAR2(21),

OCCUPATION VARCHAR2(21),

HOUSEHOLD_SIZE VARCHAR2(21),

YRS_RESIDENCE NUMBER,

AFFINITY_CARD NUMBER(10),

bulk_pack_diskettes NUMBER(10),

flat_panel_monitor NUMBER(10),

home_theater_package NUMBER(10),

bookkeeping_application NUMBER(10),

printer_supplies NUMBER(10),

y_box_games NUMBER(10),

os_doc_set_kanji NUMBER(10),

COMMENTS VARCHAR2(4000));

ALTER TABLE promotions

ADD CONSTRAINT promo_pk

PRIMARY KEY (promo_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE sales

ADD CONSTRAINT sales_promo_fk

FOREIGN KEY (promo_id) REFERENCES promotions (promo_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE costs

ADD CONSTRAINT costs_promo_fk

FOREIGN KEY (promo_id) REFERENCES promotions (promo_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE customers

ADD CONSTRAINT customers_pk

PRIMARY KEY (cust_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE sales

ADD CONSTRAINT sales_customer_fk

FOREIGN KEY (cust_id) REFERENCES customers (cust_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE products

ADD CONSTRAINT products_pk

PRIMARY KEY (prod_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE sales

ADD CONSTRAINT sales_product_fk

FOREIGN KEY (prod_id) REFERENCES products (prod_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE costs

ADD CONSTRAINT costs_product_fk

FOREIGN KEY (prod_id) REFERENCES products (prod_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE times

ADD CONSTRAINT times_pk

PRIMARY KEY (time_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE sales

ADD CONSTRAINT sales_time_fk

FOREIGN KEY (time_id) REFERENCES times (time_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE costs

ADD CONSTRAINT costs_time_fk

FOREIGN KEY (time_id) REFERENCES times (time_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE channels

ADD CONSTRAINT channels_pk

PRIMARY KEY (channel_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE sales

ADD CONSTRAINT sales_channel_fk

FOREIGN KEY (channel_id) REFERENCES channels (channel_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE costs

ADD CONSTRAINT costs_channel_fk

FOREIGN KEY (channel_id) REFERENCES channels (channel_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE countries

ADD CONSTRAINT countries_pk

PRIMARY KEY (country_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE customers

ADD CONSTRAINT customers_country_fk

FOREIGN KEY (country_id) REFERENCES countries (country_id)

RELY DISABLE NOVALIDATE;

ALTER TABLE supplementary_demographics

ADD CONSTRAINT supp_demo_pk

PRIMARY KEY (cust_id)

RELY DISABLE NOVALIDATE;