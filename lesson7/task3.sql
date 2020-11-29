
create table flights(
   id INT NOT NULL AUTO_INCREMENT,
   _from VARCHAR(42) NOT NULL,
   _to VARCHAR(42) NOT NULL,
   PRIMARY KEY ( id )
);

select * from flights;

insert into flights values
	(1, "moscow", "omsk"),
    (2, "novgorod", "kazan"),
    (3, "irkutsk", "moscow"),
    (4, "omsk", "irkutsk"),
    (5, "moscow", "kazan");

create table cities(
   label VARCHAR(42) NOT NULL,
   name VARCHAR(42) NOT NULL,
   PRIMARY KEY ( label )
);

select * from cities;

insert into cities values
	("moscow", "Москва"),
    ("irkutsk", "Иркутск"),
    ("novgorod", "Новгород"),
    ("kazan", "Казань"),
    ("omsk", "Омск");

SELECT id, l_tran.name, r_tran.name FROM flights
	JOIN
		(SELECT label, name FROM cities) AS l_tran
			ON flights._from = l_tran.label
	JOIN
		(SELECT label, name FROM cities) AS r_tran
			ON flights._to = r_tran.label;
