CREATE USER 'sagar'@'localhost' IDENTIFIED BY 'sagar';
GRANT ALL PRIVILEGES ON *.* TO 'sagar'@'localhost';

DROP SCHEMA IF EXISTS WebAppWithJPA;
CREATE SCHEMA WebAppWithJPA;
USE WebAppWithJPA;

CREATE TABLE Address (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  street VARCHAR(45) NOT NULL,
  city    VARCHAR(45) NOT NULL,
  country VARCHAR(45) NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
)

CREATE TABLE Product (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  price FLOAT NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
)

CREATE TABLE ListItems (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  product_id  INTEGER UNSIGNED NOT NULL,
  quantity INTEGER NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  price FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT `fk_lineitem_product` FOREIGN KEY (product_id) REFERENCES Product (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE Customers (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  address_id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT `fk_customer_address` FOREIGN KEY (address_id) REFERENCES Address (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE Cart (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  lineitem_id  INTEGER UNSIGNED NOT NULL,
  customer_id  INTEGER UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT `fk_cart_line_item` FOREIGN KEY (lineitem_id) REFERENCES ListItems (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (customer_id) REFERENCES Customers (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE Orders (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  date  DATETIME NOT NULL,
  customer_id INTEGER UNSIGNED NOT NULL,
  line_item_id  INTEGER UNSIGNED NOT NULL,
  billing_address_id  INTEGER UNSIGNED NOT NULL,
  shipping_address_id INTEGER UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT `fk_orders_billing_address` FOREIGN KEY (billing_address_id) REFERENCES Address (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shipping_address` FOREIGN KEY (shipping_address_id) REFERENCES Address (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_line_item` FOREIGN KEY (line_item_id) REFERENCES ListItems (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (customer_id) REFERENCES Customers (id) ON DELETE RESTRICT ON UPDATE CASCADE
)



