create view gold.calendar AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/Adevnture_works_calendar/',
    format='parquet'
) as query1
GO

create view gold.Product_Categories AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdventureWorks_Product_Categories/',
    format='parquet'
) as query1
GO

create view gold.Customers AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdevntureWorks_Customers/',
    format='parquet'
) as query1
GO

create view gold.[Returns] AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdevntureWorks_Returns/',
    format='parquet'
) as query1
GO

create view gold.Subcategories AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdevntureWorks_Subcategories/',
    format='parquet'
) as query1
GO

create view gold.Product_Sales AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdventureWorks_Product_Sales/',
    format='parquet'
) as query1
GO

create view gold.Territories AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdventureWorks_Territories/',
    format='parquet'
) as query1
GO
create view gold.Products AS
select * from OPENROWSET(
    bulk 'https://awtoragedatalake.dfs.core.windows.net/silver/AdevntureWorks_Products/',
    format='parquet'
) as query1
GO
