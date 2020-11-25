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
