select [AddressLine1] from [Person].[Address] where [AddressID]=999 --叢集索引搜尋
select * from [Person].[Address] where [AddressID]=999 --叢集索引搜尋
select * from [Person].[Address] where [AddressID]=999 AND City='Fullerton' --叢集索引搜尋
select * from [Person].[Address] where City='Fullerton' AND [AddressID]=999 --叢集索引搜尋
--1.因為WHERE條件皆有叢集索引鍵中的第一個欄位，所以會採取 Seek 搜尋方式
--2.若不是使用叢集索引鍵中的第一個欄位，則會使用【索引掃描】。
--3.叢集索引鍵 = PK
--4.複合索引的第一個欄位選擇非常重要，因為它是唯一一個會經過排序的欄位
-----
--[rowguid]:NonClustered Index
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' AND [AddressID]=12 --叢集索引搜尋(因為包含[AddressID])
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' AND [AddressID]=12 AND City='Fullerton' --叢集索引搜尋(因為包含[AddressID])
---
select [AddressID],[rowguid] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80' --索引搜尋
select [AddressID],[rowguid],[City] from [Person].[Address] where [rowguid]='2ED694B4-9069-4DAF-95EB-AB1C7B969A80'--索引搜尋+索引鍵查閱
---
---[AddressLine1][AddressLine2][City][StateProvinceID][PostalCode]:NonClustered Index
select * from [Person].[Address] where [AddressLine1]='8713 Yosemite Ct.' --索引搜尋+索引鍵查閱(第一個欄位)
select * from [Person].[Address] where [StateProvinceID]=79 --叢集索引掃描(遺漏索引)
select * from [Person].[Address] where [AddressLine1]='8713 Yosemite Ct.' and [AddressLine2] is null and [City]='Bothell' and [StateProvinceID]=79 and [PostalCode]=98011  --索引搜尋+索引鍵查閱
---
select * from [Person].[Address] where [City]='Bothell' --索引掃描(遺漏索引)
--
select * from [Person].[Address] where [ModifiedDate]>'2012-05-30 00:00:00.000'--叢集索引掃描(遺漏索引)
select [city] from [Person].[Address] where [ModifiedDate]>'2012-05-30 00:00:00.000'--叢集索引掃描(遺漏索引)