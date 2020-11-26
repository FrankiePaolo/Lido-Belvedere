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
    Time              enum ('Morning', 'Afternoon', 'Entire day') not null,
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

# Customers, the password is always the email without @ and following characters e.g. email: test1@test.it, password: test1
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (1,'TestName1','TestLastName1','test1@test.it','1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014','Customer');
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (2,'TestName2','TestLastName2','test2@test.it','60303ae22b998861bce3b28f33eec1be758a213c86c93c076dbe9f558c11c752','Customer');
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (3,'TestName3','TestLastName3','test3@test.it','fd61a03af4f77d870fc21e05e7e80678095c92d808cfb3b5c279ee04c74aca13','Customer');
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (4,'TestName4','TestLastName4','test4@test.it','a4e624d686e03ed2767c0abd85c14426b0b1157d2ce81d27bb4fe4f6f01d688a','Customer');
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES
(5,'TestName5','TestLastName5','test5@test.it','a140c0c1eda2def2b830363ba362aa4d7d255c262960544821f556e16661b6ff','Customer');
 
# Cashier
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (6,'TestNameCashier','TestLastNameCashier','testCashier@test.it','d6dabe26df5441d331ec7d68b6f03bdea17ad32f30e557c9464d062890218526','Cashier');

# Lifeguard
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (7,'TestNameLifeguard','TestLastNameLifeguard','testLifeguard@test.it','testLifeguard','Lifeguard');

# Chef
INSERT INTO lido_test.User (ID,FirstName,LastName,Email,Password,Role) VALUES (8,'TestNameChef','TestLastNameChef','testChef@test.it','bf89346577b93ee2fb9e2b89d9bcad4b6707283fc06721796ce7e103b982e67a','Chef');

# Populate menu
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (1,'Pasta bolognese',12,'Delicious pasta with fresh bolognese sauce','Pasta');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (2,'Pasta carbonara',15,'Pasta made with egg, hard cheese, cured pork, and black pepper','Pasta');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (3,'Pasta con pesto',8,'Pasta made with fresh homemade pesto','Pasta');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (4,'Chicken breasts',8,'Baked chicken breasts','Chicken');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (5,'Chicken wings',10,'Fried chicken wings with BBC sauce','Chicken');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (6,'Fresh lettuce',5,'Fresh lettuce from our trusted farms','Vegetables');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (7,'Tequila Sunrise',15,'Made with tequila, orange juice, and grenadine syrup','Cocktails');
INSERT INTO lido_test.Food_Item(ID,Name,Price,Description,Category) VALUES (8,'Gin lemon',15,'Made with gin, fresh lemon tonic, and ice','Cocktails');

# Populate beach with 9 chairs
INSERT INTO lido_test.Chair(ID) VALUES(1);
INSERT INTO lido_test.Chair(ID) VALUES(2);
INSERT INTO lido_test.Chair(ID) VALUES(3);
INSERT INTO lido_test.Chair(ID) VALUES(4);
INSERT INTO lido_test.Chair(ID) VALUES(5);
INSERT INTO lido_test.Chair(ID) VALUES(6);
INSERT INTO lido_test.Chair(ID) VALUES(7);
INSERT INTO lido_test.Chair(ID) VALUES(8);
INSERT INTO lido_test.Chair(ID) VALUES(9);

# Add some bookings
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Morning',1,1,1);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Morning',2,2,2);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Morning',3,3,3);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Morning',4,4,4);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Afternoon',5,5,5);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Afternoon',6,6,1);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Afternoon',7,7,2);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Afternoon',8,8,3);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Entire day',9,9,4);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-20','Entire day',1,10,5);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Entire day',2,11,1);
INSERT INTO lido_test.Booking(Date,Time,Chair_ID,ID,User_ID) VALUES('2021-01-15','Entire day',3,12,2);

# Add some orders
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(1,1,'delivered','2021-01-01 13:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(2,2,'delivered','2021-01-02 14:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(3,3,'delivered','2021-01-03 15:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(4,4,'delivered','2021-01-04 16:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(5,5,'ready','2021-01-20 15:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(6,6,'ready','2021-01-20 16:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(7,7,'waiting','2021-01-20 16:15:17');
INSERT INTO lido_test.Order(ID,User_ID,State,Date) VALUES(8,8,'waiting','2021-01-20 15:15:17');

# Specify the necessary order details
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(1,1,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(2,2,2);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(3,3,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(4,4,2);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(5,5,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(5,6,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(6,7,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(6,8,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(7,1,1);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(7,4,2);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(8,2,2);
INSERT INTO lido_test.Order_has_Food_Item(Order_ID,Food_Item_ID,Amount) VALUES(8,6,2);
