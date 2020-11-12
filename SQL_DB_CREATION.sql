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
    Order_ID         int not null,
    Food_Item_ID 	 int not null,
    Amount                int null,
    primary key (Order_ID, Food_Item_ID),
    constraint fk_Order_has_Food_Item
        foreign key (Food_Item_ID) references Food_Item (ID),
    constraint fk_Order_has_Food_Item2
        foreign key (Order_ID) references `Order` (ID)
);
