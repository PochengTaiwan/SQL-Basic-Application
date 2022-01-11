IF OBJECT_ID('dbo.usp_DBLink_SQLConnection') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_DBLink_SQLConnection]
GO

CREATE PROCEDURE [dbo].[usp_DBLink_SQLConnection]
(
	@_InBox_InqWhereMain								nvarchar(40)			,	-- 指定項目
	@_InBox_InqWhereMinor								nvarchar(40)			,	-- 連線還是關閉
	@_OutBox_isError									bit				OUTPUT	,	-- 是否執行上有錯誤
	@_OutBox_DBlinkNAME									nvarchar(2000)	OUTPUT		-- 回傳 DBLink 名稱
)
AS
		-- ========================= 新增與維護注意事項(必須遵守規定) =============================
		-- 1. 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
		-- 2. 相關新增與修改請務必註明 新增/維護 的相關人等資訊，以利後續資料表與 ERWIN 更新動作
		-- 3. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
		-- 4. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
		-- 5. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
		-- ==========================================================================
		-- 用		途：執行預設的跨資料庫查詢的連線動作
		-- 指定資料庫 ：
		-- 製   作  人：
		-- 年   月  日：2020/12/31
		-- 說		明：執行此跨資料查詢要注意，跨太多層查詢會導至效能下降

		-- =========================================================================
		DECLARE 
				@_CommandNAME										nvarchar(100)							,	--指定要連線的咨稱
				@_DBlink_NAME										nvarchar(100)							,
                --以下這帳密是必須在 [指定資料庫] 可以連線
				@_SQLLoginID										nvarchar(20)	='LoginUserNAME'		,	--[預設]-登入帳號
				@_SQLLoginPW										nvarchar(20)	='LoginPWD'				    --[預設]-登入密碼

		if(@_InBox_InqWhereMain='跨資料庫')
			Begin

				if(@_InBox_InqWhereMinor='連線')
					Begin
                        --以下的設定都要自行手動建好
						BEGIN TRY
							--============ 連線說明 ==============
							--資料庫位置：192.168.1.110
							--資料庫名稱：
							--資料庫用途：
							--指定的名稱：DBLink_DBName
							--==================================

							--指定 DBLink 名稱
							SET	@_CommandNAME='DBLink_DB'
							--查詢現在的 DB Link 是否己經有啟動了，如果沒有就要進行啟動的動作
							SELECT
									@_DBlink_NAME			=	[name]				
							From	sys.servers
							WHERE	1=1
									AND	[is_linked]			=	1					--只查詢是 DB Link
									AND [name]				=	@_CommandNAME		--指定為某個己定議好的名稱		

		
							--是否沒有啟用連線
							IF(@_DBlink_NAME is NULL)			
								Begin

									--進行連線的動作

									--建立 linkServer
									exec sp_addlinkedserver		@_CommandNAME,'','SQLOLEDB','連線內部 IP'
									--登陸linkServer
									exec sp_addlinkedsrvlogin	@_CommandNAME,'false',null,@_SQLLoginID,@_SQLLoginPW
                                    --導出連線查詢方式
									SET @_OutBox_DBlinkNAME='[DBLink_DB].[資料庫名稱].[DBO].[資料表名稱] WITH(NOLOCK)'

								End
					

							SET @_OutBox_isError=0;

						END TRY
						BEGIN CATCH

							--DB查詢用
							SELECT ERROR_NUMBER() AS ErrorNumber,
								   ERROR_MESSAGE() AS ErrorMessage,
								   ERROR_LINE() AS ErrorLine,
								   ERROR_PROCEDURE() AS ErrorProcedure,
								   ERROR_SEVERITY() AS ErrorSeverity,
								   ERROR_STATE() AS ErrorState

							--系統拋回訊息用
							DECLARE @ErrorMessage	As NVARCHAR(1000) = CHAR(10)+'錯誤代碼：' +CAST(ERROR_NUMBER() AS NVARCHAR)
																	+CHAR(10)+'錯誤訊息：'+	ERROR_MESSAGE()
																	+CHAR(10)+'錯誤行號：'+	CAST(ERROR_LINE() AS NVARCHAR)
																	+CHAR(10)+'錯誤程序名稱：'+	ISNULL(ERROR_PROCEDURE(),'')

							DECLARE @ErrorSeverity	As Numeric = ERROR_SEVERITY()
							DECLARE @ErrorState		As Numeric = ERROR_STATE()
							
							--指定錯誤訊息回傳
							SET @_OutBox_DBlinkNAME=@ErrorMessage+','+@ErrorSeverity+','+@ErrorState
							SET @_OutBox_isError=1
						
						END CATCH


						if(@_OutBox_DBlinkNAME is null)
							Begin
								SET @_OutBox_DBlinkNAME='[DBLink_HBBailee].[HB_Bailee].[DBO].[YouTable]  WITH(NOLOCK)'
							End

					End
				else if(@_InBox_InqWhereMinor='關閉')
					Begin

						--============ 連線說明 ==============
						--資料庫位置：
						--資料庫名稱：
						--資料庫用途：
						--指定的名稱：DBLink_DB
						--==================================

						--指定 DBLink 名稱
						SET	@_CommandNAME='DBLink_DB'

						--查詢現在的 DB Link 是否己經有啟動了，如果沒有就要進行啟動的動作
						SELECT
								@_DBlink_NAME			=	[name]				
						From	sys.servers
						WHERE	1=1
								AND	[is_linked]			=	1					--只查詢是 DB Link
								AND [name]				=	@_CommandNAME		--指定為某個己定議好的名稱		

						if(@_DBlink_NAME is not null)
							Begin
								exec sp_dropserver @_CommandNAME, 'droplogins'
							End

						SET @_OutBox_DBlinkNAME='相關預設的 DBLink SQL 己關閉'

					End

			End

		