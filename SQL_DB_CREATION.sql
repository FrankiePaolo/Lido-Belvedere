create database if not exists lido_test collate latin1_swedish_ci;

use lido_test;

create table Chair
(
    ID int auto_increment
        primary key
);

create table Food_Item
(
    ID int auto_increment
        primary key,
    Name        varchar(45)  not null,
    Price       float        not null,
    Description varchar(128) not null,
    Category    varchar(45)  not null
);

create table User
(
    ID   int auto_increment
        primary key,
    FirstName     varchar(45)               not null,
    LastName  varchar(45)                   not null,
    Email     varchar(45)                   null,
    Password varchar(64)                    not null,
    Role     varchar(45) default 'Customer' not null,
    unique (Email)
);

create table Booking
(
    Date              date                          not null,
    Time              enum ('AM', 'PM', 'Full day') not null,
    Chair_ID int                          	      not null,
    ID         int auto_increment
        primary key,
    User_ID       int                               not null,
    constraint fk_Booking_Chair
        foreign key (Chair_ID) references Chair (ID),
    constraint fk_Booking_User
        foreign key (User_ID) references User (ID)
);


create table `Order`
(
    ID     int auto_increment
        primary key,
    User_ID int                                                              not null,
    State       enum ('waiting', 'ready', 'delivered') default 'waiting'         null,
    Date        datetime                               default CURRENT_TIMESTAMP null,
    constraint fk_Order_User
        foreign key (User_ID) references User (ID)
);

create table Order_has_Food_Item
(
    Order_ID         	 int not null,
    Food_Item_ID 	 int not null,
    Amount              int null,
    primary key (Order_ID, Food_Item_ID),
    constraint fk_Order_has_Food_Item
        foreign key (Food_Item_ID) references Food_Item (ID),
    constraint fk_Order_has_Food_Item2
        foreign key (Order_ID) references `Order` (ID)
);


# Populate tables

# Populate User table

# Customers
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestName1','TestLastName1','test1@test.it','test1','Customer');
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestName2','TestLastName2','test2@test.it','test2','Customer');
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestName3','TestLastName3','test3@test.it','test3','Customer');
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestName4','TestLastName4','test4@test.it','test4','Customer');
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES
 ('TestName5','TestLastName5','test5@test.it','test5','Customer');
 
# Cashier
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestNameCashier','TestLastNameCashier','testCashier@test.it','testCashier','Cashier');

# Lifeguard
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestNameLifeguard','TestLastNameLifeguard','testLifeguard@test.it','testLifeguard','Lifeguard');

# Chef
INSERT INTO lido_test.User (FirstName,LastName,Email,Password,Role) VALUES ('TestNameChef','TestLastNameChef','testChef@test.it','testChef','Chef');

# Populate menu
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Pasta bolognese',12,'Delicious pasta with fresh bolognese sauce','Pasta');
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Pasta carbonara',15,'Pasta made with egg, hard cheese, cured pork, and black pepper','Pasta');
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Pasta con pesto',8,'Pasta made with fresh homemade pesto','Pasta');
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Chicken breasts',8,'Baked chicken breasts','Chicken');
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Fresh lettuce',5,'Fresh lettuce from our trusted farms','Vegetables');
INSERT INTO lido_test.Food_Item(Name,Price,Description,Category) VALUES ('Tequila Sunrise',15,'Made with tequila, orange juice, and grenadine syrup','Cocktails');

# Populate beach

