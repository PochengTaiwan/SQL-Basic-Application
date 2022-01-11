IF OBJECT_ID('dbo.usp_AppFun_ElapsedDays') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_AppFun_ElapsedDays]
GO

CREATE PROCEDURE [dbo].[usp_AppFun_ElapsedDays]
(
	@_InBox_FinallyDateTime				datetime		,	-- 要換算出的內容
	@_OutBox_ReturnValues				nvarchar(200)	output
)
AS
		-- ========================= 新增與維護注意事項(必須遵守規定) =============================
		-- 1. 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
		-- 2. 相關新增與修改請務必註明 新增/維護 的相關人等資訊，以利後續資料表與 ERWIN 更新動作
		-- 3. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
		-- 4. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
		-- 5. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
		-- 6. 儘量不要使用 Cursor 
		-- 7. 前後要加 SET NOCOUNT ON; SET NOCOUNT OFF;
		-- ==========================================================================
		-- 專案項目　：[應用功能] - 以開始時間與結束時間換算出 天時分秒
		-- 專案用途　：EWS 應用
		-- 專案資料庫：Hex_EWS
		-- 專案資料表：
		-- 專案人員　：POCHENG
		-- 專案日期　：2021/11/01
		-- 專案說明　：
		-- 
		-- =========================================================================

		--===========================
		-- 程序使用--宣告系統預設變數
		--===========================
		DECLARE
				@_InBox_Inside_ProgID								nvarchar(60)		=	'usp_AppFun_ElapsedDays'			,	--[預設值] 預存程序名稱
				@_InBox_Inside_ProgVersion							nvarchar(60)		=	'1.0'								,	--[預設值] 此程序執行版本號
				@_InBox_Inside_ProgAction							nvarchar(60)		=	'Inquire'							,	--[預設值] 執行的動作為何
				@_InBox_Inside_ActionGUID							uniqueidentifier	=	newid()								,	--[預設值] 提供此程序的執行代碼
				@_InBox_Inside_isError								bit					=	0									,	--[預設值] 是否有指定錯誤
				@_InBox_Inside_isErrorMessage						nvarchar(Max)		=	''									,	--[預設值] 存入錯誤的訊息
				@_InBox_Inside_NowDateTime							datetime			=	getdate()							,	--[預設值] 現在的日期時間
				@_InBox_iPageCount									int					=	0									,	--[預設值] 筆數
		--===========================
		-- 取得要查詢的條件
		--===========================
				@_TimeMinute										int					= DATEDIFF(MINUTE, @_InBox_FinallyDateTime , GETDATE())	,
				@_ElapsedDateTimeDay								nvarchar(200)		,
				@_CURSORFOR_Startdate								datetime			=CONVERT(datetime,GETDATE(),120)		,
				@_NowDateTime										nvarchar(100)		=CONVERT(varchar(10),CONVERT(datetime,GETDATE(),111),111)+' '+Convert(varchar(8),GETDATE(),108),
				@_CURSORFOR_enddate									datetime			=@_InBox_FinallyDateTime		,
				@_CURSORFOR_SS										int			,
				@_NEXTDateTime_ss									int			,
				@_NEXTDateTime_mm									int			,
				@_NEXTDateTime_mmm									int			,
				@_NEXTDateTime_hh									int			,
				@_NEXTDateTime_date									int
		
		--CONVERT(varchar(10),CONVERT(datetime,@_CURSORFOR_DevConn_FinallyDateTime,111),111)+' '+Convert(varchar(8),@_CURSORFOR_DevConn_FinallyDateTime,108)
		
		SET @_CURSORFOR_Startdate=CONVERT(datetime ,@_NowDateTime)

		SET @_CURSORFOR_SS=DATEDIFF(SS, @_CURSORFOR_enddate,@_CURSORFOR_Startdate)

		SET	@_NEXTDateTime_date=@_CURSORFOR_SS/60/60/24
		SET	@_NEXTDateTime_hh=@_CURSORFOR_SS/60/60%24		
		SET	@_NEXTDateTime_ss=@_CURSORFOR_SS%60 
		SET @_NEXTDateTime_mm=@_CURSORFOR_SS/60%60
		
		Begin Try  
			SET @_NEXTDateTime_mmm=DATEDIFF(ms, @_CURSORFOR_enddate,@_CURSORFOR_Startdate)
		End Try  
		Begin Catch
			SET @_NEXTDateTime_mmm=100;
		End Catch

		
		SET	@_ElapsedDateTimeDay = CONVERT(nvarchar(20),@_NEXTDateTime_date) +' 天,'
		SET	@_ElapsedDateTimeDay +=CONVERT(nvarchar(20),@_NEXTDateTime_hh)	 +' 小時,'
		SET	@_ElapsedDateTimeDay +=CONVERT(nvarchar(20),@_NEXTDateTime_mm)	 +' 分,'
		SET	@_ElapsedDateTimeDay +=CONVERT(nvarchar(20),@_NEXTDateTime_ss)	 +' 秒,'
		SET	@_ElapsedDateTimeDay +=CONVERT(nvarchar(20),@_NEXTDateTime_mmm)	 +' 亳秒'

		SET	@_OutBox_ReturnValues=@_ElapsedDateTimeDay

		RETURN 