
/*
 * 使用sys.database_files資料表
 * 用途: 針對儲存在資料庫本身的資料庫的每個檔案，各包含一個資料列。 這是每個資料庫檢視。
 * https://learn.microsoft.com/zh-tw/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql?view=sql-server-ver16
*/

--使用下列查詢可傳回已配置的資料庫檔案空間數量，以及已配置未使用的空間量。 查詢結果以 MB 為單位。
--USE database_name;
--GO  
SELECT file_id, type_desc,
       CAST(FILEPROPERTY(name, 'SpaceUsed') AS decimal(19,4)) * 8 / 1024. AS space_used_mb,
       CAST(size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS decimal(19,4)) AS space_unused_mb,
       CAST(size AS decimal(19,4)) * 8 / 1024. AS space_allocated_mb,
       CAST(max_size AS decimal(19,4)) * 8 / 1024. AS max_size_mb
FROM sys.database_files;

--下列語句會傳回每個資料庫檔案的名稱、檔案大小和空白空間量。
--USE database_name;
--GO  
SELECT name AS '檔案名稱'
,size/128.0 AS '檔案大小_mb'
,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS '空白空間量_mb'
FROM sys.database_files;
-- size欄位說明:
-- 檔案的目前大小，以 8 KB 頁為單位。
-- 針對 FILESTREAM 檔案群組容器，size 會反映容器目前使用的大小。




/*
 * 使用sys.dm_db_log_space_usage資料表
 * 用途: 傳回交易記錄的空間使用量資訊。
 * https://learn.microsoft.com/zh-tw/sql/relational-databases/system-dynamic-management-views/sys-dm-db-log-space-usage-transact-sql?view=sql-server-ver16
*/
--會傳回目前使用之記錄空間量的相關資訊，並指出交易記錄需要截斷的時機。
--USE database_name;
--GO  
select 
	database_id AS '資料庫識別碼'
	,(total_log_size_in_bytes)*1.0/1024/1024 AS '記錄的大小_mb'
	,(used_log_space_in_bytes)*1.0/1024/1024 AS '記錄的已佔用大小_mb'
	,used_log_space_in_percent AS '記錄的已佔用大小，以總記錄大小的百分比表示'
	,(log_space_in_bytes_since_last_backup)*1.0/1024/1024 AS '上次記錄備份後所使用的空間量_mb'
from sys.dm_db_log_space_usage


--會傳回可用的總記錄空間 (以 MB 表示)。
--USE database_name;
GO  
SELECT 
(total_log_size_in_bytes - used_log_space_in_bytes)*1.0/1024/1024 AS '可用的總記錄空間_mb' 
FROM sys.dm_db_log_space_usage;  
