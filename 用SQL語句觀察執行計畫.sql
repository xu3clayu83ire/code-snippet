select [AddressLine1] from [Person].[Address] where [AddressID]=999 --�O�����޷j�M
select * from [Person].[Address] where [AddressID]=999 --�O�����޷j�M
select * from [Person].[Address] where [AddressID]=999 AND City='Fullerton' --�O�����޷j�M
select * from [Person].[Address] where City='Fullerton' AND [AddressID]=999 --�O�����޷j�M
--1.�]��WHERE����Ҧ��O�������䤤���Ĥ@�����A�ҥH�|�Ĩ� Seek �j�M�覡
--2.�Y���O�ϥ��O�������䤤���Ĥ@�����A�h�|�ϥΡi���ޱ��y�j�C
--3.�O�������� = PK
--4.�ƦX���ު��Ĥ@������ܫD�`���n�A�]�����O�ߤ@�@�ӷ|�g�L�ƧǪ����
-----
--[rowguid]:NonClustered Index
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' AND [AddressID]=12 --�O�����޷j�M(�]���]�t[AddressID])
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' AND [AddressID]=12 AND City='Fullerton' --�O�����޷j�M(�]���]�t[AddressID])
---
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' --���޷j�M
select [AddressID],[rowguid],[City] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80'--���޷j�M+������d�\
---
---[AddressLine1][AddressLine2][City][StateProvinceID][PostalCode]:NonClustered Index
select * from [Person].[Address] where [AddressLine1]='8713 Yosemite Ct.' --���޷j�M+������d�\(�Ĥ@�����)
select * from [Person].[Address] where [StateProvinceID]=79 --�O�����ޱ��y(��|����)
select * from [Person].[Address] where [AddressLine1]='8713 Yosemite Ct.' and [AddressLine2] is null and [City]='Bothell' and [StateProvinceID]=79 and [PostalCode]=98011  --���޷j�M+������d�\
---
select * from [Person].[Address] where [City]='Bothell' --���ޱ��y(��|����)
--
select * from [Person].[Address] where [ModifiedDate]>'2012-05-30 00:00:00.000'--�O�����ޱ��y(��|����)
select [city] from [Person].[Address] where [ModifiedDate]>'2012-05-30 00:00:00.000'--�O�����ޱ��y(��|����)