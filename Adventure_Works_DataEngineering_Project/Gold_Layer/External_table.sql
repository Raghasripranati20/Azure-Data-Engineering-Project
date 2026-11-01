CREATE DATABASE SCOPED CREDENTIAL cred_ragha
WITH IDENTITY = 'Managed Identity'

CREATE EXTERNAL DATA SOURCE source_silver
WITH
  (  LOCATION = 'https://awtoragedatalake.dfs.core.windows.net/silver', 
     credential=cred_ragha
    
  )
CREATE EXTERNAL DATA SOURCE source_gold
WITH
  (  LOCATION = 'https://awtoragedatalake.dfs.core.windows.net/gold' ,
     credential=cred_ragha
    
  )
 create external file format format_parquet
 with(
    format_type=parquet,
    data_compression='org.apache.hadoop.io.compress.SnappyCodec'
 )

----create external table for external sales---
 create external table gold.extsales
 with(
    location='extsales',
    data_source=source_gold,
    file_format=format_parquet
 ) as 
 select * from gold.Product_Sales




