-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

drop view if exists names_types;
create view names_types as
select products.name as prod, catalogs.name as typeof from products
	join catalogs
    on products.catalog_id = catalogs.id;

select * from names_types;