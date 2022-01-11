IF OBJECT_ID('dbo.usp_System_TableCheckIndexisOK') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_System_TableCheckIndexisOK]
GO

CREATE PROCEDURE [dbo].[usp_System_TableCheckIndexisOK]
--(
--	@_Import_Values					nvarchar(Max)			,	--宣告要載入的資料內容
--	@_Import_SpliteWhere			nvarchar(1)					--要拆解的符號
	
--)
AS
BEGIN
		
		-- ========================= 新增與維護注意事項(必須遵守規定) =============================
		-- 1. 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
		-- 2. 相關新增與修改請務必註明 新增/維護 的相關人等資訊，以利後續資料表與 ERWIN 更新動作
		-- 3. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
		-- 4. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
		-- 5. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
		-- 6. 儘量不要使用 Cursor 
		-- 7. 前後要加 SET NOCOUNT ON; SET NOCOUNT OFF;
		-- ==========================================================================
		-- 專案項目　：[應用功能] - 查詢 "資料表索引" 有那些資料表索引建議重建的
		-- 專案用途　：系統應用
		-- 專案資料庫：
		-- 專案資料表：
		-- 專案人員　：POCHENG
		-- 專案日期　：2021/11/15
		-- 專案說明　：
		-- 
		-- ==========================================================================
		
		SELECT 'ALTER INDEX [' + ix.name + '] ON [' + s.name + '].[' + t.name + '] ' +
		   CASE
				  WHEN ps.avg_fragmentation_in_percent > 15
				  THEN 'REBUILD'
				  ELSE 'REORGANIZE'
		   END +
		   CASE
				  WHEN pc.partition_count > 1
				  THEN ' PARTITION = ' + CAST(ps.partition_number AS nvarchar(MAX))
				  ELSE ''
		   END AS TSQL_ALTERINDEX,
				avg_fragmentation_in_percent AS AlterIndexFraction
		FROM   sys.indexes AS ix
				INNER JOIN sys.tables t
				ON     t.object_id = ix.object_id
				INNER JOIN sys.schemas s
				ON     t.schema_id = s.schema_id
				INNER JOIN
						(SELECT object_id                   ,
								index_id                    ,
								avg_fragmentation_in_percent,
								partition_number
						FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL)
						) ps
				ON     t.object_id = ps.object_id
					AND ix.index_id = ps.index_id
				INNER JOIN
						(SELECT  object_id,
								index_id ,
								COUNT(DISTINCT partition_number) AS partition_count
						FROM     sys.partitions
						GROUP BY object_id,
								index_id
						) pc
				ON     t.object_id              = pc.object_id
					AND ix.index_id              = pc.index_id
		WHERE  ps.avg_fragmentation_in_percent > 10
			AND ix.name IS NOT NULL
END
