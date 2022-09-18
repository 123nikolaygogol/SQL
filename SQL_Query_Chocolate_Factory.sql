CREATE DATABASE Manufacturer;
USE Manufacturer;

CREATE SCHEMA product;

CREATE SCHEMA supplier;

CREATE SCHEMA component;

CREATE TABLE product.product(
prod_id INT PRIMARY KEY NOT NULL,
prod_name varchar(50),
quantity INT,
);

CREATE TABLE supplier.supplier(
supp_id INT PRIMARY KEY NOT NULL,
supp_name varchar(50),
supp_location varchar(50),
supp_country varchar(50),
is_active bit
);

CREATE TABLE component.component(
comp_id INT PRIMARY KEY NOT NULL,
comp_name varchar(50),
description varchar(50),
quantity_comp INT,
);


CREATE TABLE product.prod_comp(
[prod_id] INT NOT NULL,
[comp_id] INT NOT NULL,
PRIMARY KEY ([prod_id], [comp_id]),
quantity_comp INT,
);

CREATE TABLE component.comp_supp(
[supp_id] INT NOT NULL,
[comp_id] INT NOT NULL,
PRIMARY KEY ([supp_id], [comp_id]),
order_date date,
quantity INT,
);


ALTER TABLE product.prod_comp ADD CONSTRAINT FK1 FOREIGN KEY (prod_id) REFERENCES product.product (prod_id)

ALTER TABLE product.prod_comp ADD CONSTRAINT FK2 FOREIGN KEY (comp_id) REFERENCES component.component (comp_id)

ALTER TABLE component.comp_supp ADD CONSTRAINT FK1 FOREIGN KEY (supp_id) REFERENCES supplier.supplier (supp_id)

ALTER TABLE component.comp_supp ADD CONSTRAINT FK2 FOREIGN KEY (comp_id) REFERENCES component.component (comp_id)

