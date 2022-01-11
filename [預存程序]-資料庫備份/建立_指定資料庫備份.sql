IF OBJECT_ID('dbo.資料庫備份-快速執行資料庫備份') IS NOT NULL
    DROP PROCEDURE [dbo].[資料庫備份-快速執行資料庫備份]
GO

CREATE PROCEDURE [dbo].[資料庫備份-快速執行資料庫備份]
(
	@_InBox_JSON_Source					nvarchar(Max)		--資料來源
)
AS
        -- 這同步在 https://ithelp.ithome.com.tw/articles/10210387 發佈中
		-- 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
		-- ==========================================================================
		-- 用		途：資料庫備份-完整備份
		-- 製   作  人：
		-- 年   月  日：
		-- 說		明：這部份是給 API 應用
		
		-- 1. 專業人員沒有寫註解不叫專業
		-- 2. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
		-- 3. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
		-- 4. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
		-- ==========================================================================
		-- ========宣告系統要用的資訊 - 開始 ================
		DECLARE @_InBox_DataBaseName									nvarchar(100)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name')
		DECLARE @_InBox_BackName       									nvarchar(100)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_BackupFileName')
		DECLARE @_InBox_BackMemo       									nvarchar(100)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_BackupMemo')
		DECLARE @_InBox_BackupMethod       								nvarchar(100)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_BackupMethod')

		DECLARE @_InBox_BackDate										nvarchar(100)		=REPLACE(CONVERT(nvarchar(30),GETDATE(),112),':','');
		DECLARE @_InBox_BackTime										nvarchar(100)		=REPLACE(CONVERT(nvarchar(30),GETDATE(),8),':','');
		DECLARE @_InBox_BackServiceName									nvarchar(100)		=@_InBox_BackName+@_InBox_BackTime
        DECLARE @_InBox_DISK_DB_Path       								nvarchar(500)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory')+@_InBox_BackName+'_'+ @_InBox_BackupMethod +'_'+'DB_'		+@_InBox_BackDate +'_'+@_InBox_BackTime+'.Bak'
		DECLARE @_InBox_DISK_Log_Path									nvarchar(500)		=JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory')+@_InBox_BackName+'_'+ @_InBox_BackupMethod +'_'+'Log_'	+@_InBox_BackDate +'_'+@_InBox_BackTime+'.Bak'
		
		

		--回傳執行上的可能錯誤
		DECLARE @_SystemInfoLog											Table
		(
			DBName														nvarchar(1000),			--資料庫名稱
			DBPathInfo													nvarchar(1000),			--儲存備份路徑
			DBErrorMessage												nvarchar(Max),			--錯誤說明
			Sysinfo_isError												nvarchar(2)	,			--記錄錯誤的訊息
			SysInfo_MainCode											nvarchar(200) ,
			SysInfo_MinorCode											nvarchar(200)
		)
		
		-- ========宣告系統要用的資訊 - 結束 ================
		
		

		if(LEN(@_InBox_DataBaseName)!=0 AND LEN(@_InBox_BackupMethod)!=0)
			Begin
				
				if(@_InBox_BackupMethod='完整')
					Begin
					
					--執行 Try 
					BEGIN TRY  
						--下達完整備份
						BACKUP	DATABASE @_InBox_DataBaseName 
							--========備份磁碟實際上的位置==========
							-- 儲存檔案的位置
							--==========================
							TO DISK = @_InBox_DISK_DB_Path
							--========備份方式==========
							--完整備份 >> WITH NOFORMAT
							--差異備份 >> WITH DIFFERENTIAL
							WITH NOFORMAT, 
							--========壓縮方式==========
							--檔案壓縮 >> COMPRESSION
							--檔案壓縮 >> NO_COMPRESSION 檔案不壓縮
							--==========================
							COMPRESSION ,
							--========備份作業覆寫========
							--備份覆寫 >> INIT
							--附加媒體 >> NOINIT
							--==========================
							NOINIT,
							--========預設資料庫備份或還原的I/O=========
							--預設為 >> 10
							--==============================
							BUFFERCOUNT = 1024,  
							--========此備份資料庫的名稱與說明 255 字以內=========
							--預設為 >> 10
							--==============================
							NAME = @_InBox_BackMemo,
							--========檢查媒體備份到期日====
							--必須要檢查 >> NOSKIP	先檢查媒體中所有備份組的到期日
							--不須要檢查 >> SKIP	則略過檢查動作
							--==============================
							SKIP,
							--=====備份硬體-磁帶備份設定====
							--釋放和倒轉磁帶 >> REWIND		將釋放和倒轉磁帶
							--釋放和倒轉磁帶 >> NOREWIND	不釋放和倒轉磁帶
							--==============================
							NOREWIND, 
							--=====備份硬體-自動倒轉和卸載磁帶====
							--釋放和倒轉磁帶 >> UNLOAD		自動倒轉和卸載磁帶
							--釋放和倒轉磁帶 >> NOUNLOAD	磁帶機上保持載入
							--==============================
							NOUNLOAD,
							--=====完成多少百分比時，回報一則訊息====
							--預設為 >> 10
							--==============================
							STATS = 10

						--填入記錄
						INSERT INTO @_SystemInfoLog VAlues(
							JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name')+'-'+@_InBox_BackupMethod,
							JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory'),
							'執行正常',
							REPLACE(ERROR_STATE(),NULL,'0'),
							'完整備份-成功',
							'資料庫己確定完整備份了 ['+ JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name') +']'
						)
					END TRY  
					BEGIN CATCH  
						
						--填入記錄
						INSERT INTO @_SystemInfoLog VAlues(
							JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name')+'-'+@_InBox_BackupMethod,
							JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory'),
							ERROR_MESSAGE(),
							REPLACE(ERROR_STATE(),NULL,'0'),
							'完整備份-失敗',
							'無法執行資料庫備份 ['+ JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name') +']'
						)

					END CATCH;  


					End
				else if(@_InBox_BackupMethod='差異')
					Begin
						
						--執行 Try 
						BEGIN TRY  

						--下達查異性備份
						BACKUP	DATABASE @_InBox_DataBaseName 
								--========備份磁碟實際上的位置==========
								-- 儲存檔案的位置
								--==========================
								TO DISK = @_InBox_DISK_DB_Path
								--========備份方式==========
								--完整備份 >> WITH NOFORMAT
								--差異備份 >> WITH DIFFERENTIAL
								WITH DIFFERENTIAL, 
								--========壓縮方式==========
								--檔案壓縮 >> COMPRESSION
								--檔案壓縮 >> NO_COMPRESSION    檔案不壓縮
								--==========================
								NO_COMPRESSION ,
								--========備份作業覆寫========
								--備份覆寫 >> INIT
								--附加媒體 >> NOINIT
								--==========================
								NOINIT,
								--========預設資料庫備份或還原的I/O=========
								--預設為 >> 10
								--==============================
								BUFFERCOUNT = 1024,  
								--========此備份資料庫的名稱與說明 255 字以內=========
								--預設為 >> 10
								--==============================
								NAME = @_InBox_BackMemo,
								--========檢查媒體備份到期日====
								--必須要檢查 >> NOSKIP	先檢查媒體中所有備份組的到期日
								--不須要檢查 >> SKIP	則略過檢查動作
								--==============================
								SKIP,
								--=====備份硬體-磁帶備份設定====
								--釋放和倒轉磁帶 >> REWIND		將釋放和倒轉磁帶
								--釋放和倒轉磁帶 >> NOREWIND	不釋放和倒轉磁帶
								--==============================
								NOREWIND, 
								--=====備份硬體-自動倒轉和卸載磁帶====
								--釋放和倒轉磁帶 >> UNLOAD		自動倒轉和卸載磁帶
								--釋放和倒轉磁帶 >> NOUNLOAD	磁帶機上保持載入
								--==============================
								NOUNLOAD,
								--=====完成多少百分比時，回報一則訊息====
								--預設為 >> 10
								--==============================
								STATS = 10
					
							--填入記錄
							INSERT INTO @_SystemInfoLog VAlues(
								JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name')+'-'+@_InBox_BackupMethod,
								JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory'),
								'執行正常',
								REPLACE(ERROR_STATE(),NULL,'0'),
								'差異備份-成功',
								'資料庫己確定差異備份了 ['+ JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name') +']'
							)
						END TRY  
						BEGIN CATCH  
						
							--填入記錄
							INSERT INTO @_SystemInfoLog VAlues(
								JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name')+'-'+@_InBox_BackupMethod,
								JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory'),
								ERROR_MESSAGE(),
								REPLACE(ERROR_STATE(),NULL,'0'),
								'差異備份-失敗',
								'無法執行資料庫差異備份 ['+ JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name') +']'
							)

						END CATCH;  

					End
			End
		else
			Begin
			
				--填入指定的錯誤代碼
				INSERT INTO @_SystemInfoLog VAlues(
					JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Name'),
					JSON_VALUE(@_InBox_JSON_Source,'$[0].DB_Directory'),
					'下達的命令與語法錯誤',
					'0',
					'0',
					'0'
				)
			
			End 

		--轉出整個執行的內容
		SELECT		*
		FROM		@_SystemInfoLog
