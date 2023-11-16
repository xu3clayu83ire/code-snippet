
/*
 * �ϥ�sys.database_files��ƪ�
 * �γ~: �w���x�s�b��Ʈw��������Ʈw���C���ɮסA�U�]�t�@�Ӹ�ƦC�C �o�O�C�Ӹ�Ʈw�˵��C
 * https://learn.microsoft.com/zh-tw/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql?view=sql-server-ver16
*/

--�ϥΤU�C�d�ߥi�Ǧ^�w�t�m����Ʈw�ɮתŶ��ƶq�A�H�Τw�t�m���ϥΪ��Ŷ��q�C �d�ߵ��G�H MB �����C
--USE database_name;
--GO  
SELECT file_id, type_desc,
       CAST(FILEPROPERTY(name, 'SpaceUsed') AS decimal(19,4)) * 8 / 1024. AS space_used_mb,
       CAST(size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS decimal(19,4)) AS space_unused_mb,
       CAST(size AS decimal(19,4)) * 8 / 1024. AS space_allocated_mb,
       CAST(max_size AS decimal(19,4)) * 8 / 1024. AS max_size_mb
FROM sys.database_files;

--�U�C�y�y�|�Ǧ^�C�Ӹ�Ʈw�ɮת��W�١B�ɮפj�p�M�ťժŶ��q�C
--USE database_name;
--GO  
SELECT name AS '�ɮצW��'
,size/128.0 AS '�ɮפj�p_mb'
,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS '�ťժŶ��q_mb'
FROM sys.database_files;
-- size��컡��:
-- �ɮת��ثe�j�p�A�H 8 KB �������C
-- �w�� FILESTREAM �ɮ׸s�ծe���Asize �|�ϬM�e���ثe�ϥΪ��j�p�C




/*
 * �ϥ�sys.dm_db_log_space_usage��ƪ�
 * �γ~: �Ǧ^����O�����Ŷ��ϥζq��T�C
 * https://learn.microsoft.com/zh-tw/sql/relational-databases/system-dynamic-management-views/sys-dm-db-log-space-usage-transact-sql?view=sql-server-ver16
*/
--�|�Ǧ^�ثe�ϥΤ��O���Ŷ��q��������T�A�ë��X����O���ݭn�I�_���ɾ��C
--USE database_name;
--GO  
select 
	database_id AS '��Ʈw�ѧO�X'
	,(total_log_size_in_bytes)*1.0/1024/1024 AS '�O�����j�p_mb'
	,(used_log_space_in_bytes)*1.0/1024/1024 AS '�O�����w���Τj�p_mb'
	,used_log_space_in_percent AS '�O�����w���Τj�p�A�H�`�O���j�p���ʤ�����'
	,(log_space_in_bytes_since_last_backup)*1.0/1024/1024 AS '�W���O���ƥ���ҨϥΪ��Ŷ��q_mb'
from sys.dm_db_log_space_usage


--�|�Ǧ^�i�Ϊ��`�O���Ŷ� (�H MB ���)�C
--USE database_name;
GO  
SELECT 
(total_log_size_in_bytes - used_log_space_in_bytes)*1.0/1024/1024 AS '�i�Ϊ��`�O���Ŷ�_mb' 
FROM sys.dm_db_log_space_usage;  
