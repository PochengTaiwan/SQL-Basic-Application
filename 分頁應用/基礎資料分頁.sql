

-- ========================= 新增與維護注意事項(必須遵守規定) =============================
-- 1. 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
-- 2. 相關新增與修改請務必註明 新增/維護 的相關人等資訊，以利後續資料表與 ERWIN 更新動作
-- 3. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
-- 4. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
-- 5. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
-- 6. 儘量不要使用 Cursor 
-- 7. 前後要加 SET NOCOUNT ON; SET NOCOUNT OFF;
-- ==========================================================================
-- 專案項目　：分頁的查詢-範例
-- 專案用途　：
-- 專案資料庫：
-- 專案資料表：
-- 專案人員　：POCHENG
-- 專案日期　：2021/11/01
-- 專案說明　：
-- 
-- =========================================================================

DECLARE @_InBox_SearchWhere									nvarchar(Max)		=	'[{
	"UID":"CC1B92A33B704E8DBAF64E18AAC66752",
	"service":"EWS",
	"query":"AllSchool",
	"data":{"city":"新北市",
		"area":"板橋區"},
	"pagesite":{
		"number":10,
		"index":0
	}
}]'

--===========================
-- 程序使用--宣告系統預設變數
--===========================
DECLARE
		@_InBox_Inside_ProgID								nvarchar(60)		=	'usp_Hex_InternalProgram_School',	--[預設值] 預存程序名稱
		@_InBox_Inside_ProgVersion							nvarchar(60)		=	'1.0'								,	--[預設值] 此程序執行版本號
		@_InBox_Inside_ProgAction							nvarchar(60)		=	'Inquire'							,	--[預設值] 執行的動作為何
		@_InBox_Inside_NowDateTime							datetime			=	getdate()							,	--[預設值] 現在的執行時間
		@_InBox_Inside_ActionGUID							uniqueidentifier	=	newid()								,	--[預設值] 提供此程序的執行代碼
		@_InBox_Inside_isError								bit					=	0									,	--[預設值] 是否有指定錯誤
		@_InBox_Inside_isErrorMessage						nvarchar(Max)		=	''									,	--[預設值] 存入錯誤的訊息
		@_InBox_Inside_ReturnMessage						nvarchar(Max)		=	''									,	--[預設值] 要導出的資料
		@_InBox_iPageCount									int					=	0									,	--[預設值] 筆數
--===========================
-- 取得要查詢的條件
--===========================
		@_InBox_QueryWhere_service							nvarchar(100)		=	JSON_VALUE(@_InBox_SearchWhere,'$[0].service')		,	--[查詢值] - 要查詢的項目
		@_InBox_QueryWhere_City								nvarchar(100)		=	JSON_VALUE(@_InBox_SearchWhere,'$[0].data.city')	,	--[查詢值] - 縣市名稱
		@_InBox_QueryWhere_Area								nvarchar(100)		=	JSON_VALUE(@_InBox_SearchWhere,'$[0].data.area')	,	--[查詢值] - 區域名稱
		@_InBox_QueryWhere_Query							nvarchar(100)		=	''													,	--[查詢值] - 組合查詢語法
--===========================
-- 指定處理分頁的設計
--===========================
		@_Search_TotalPage									int					= 0										,	--總頁數
		@_Search_Total										int					= 0										,	--總筆數 
		@_Search_PageSize									int					= 10									,	--每頁筆數
		@_Search_PageIndex									int					= 1										,	--目前頁數，第一頁的PageIndex為0

		@_OutBox_Total										int					= 0										,
		@_OutBox_TotalPage									int					= 0										,
		@_OutBox_PageSize									int					= 0										,
		@_OutBox_PageIndex									int					= 0										,
		@_OutBox_ReturnJSON									nvarchar(Max)		= ''									,
		@_OutBox_RunActionMsg								nvarchar(Max)		= ''									,


--===========================
-- 回傳用參數
--===========================
		@_OutBox_RecordsValues								nvarchar(1000)		=	null								,	--[回傳值] 取得記錄回傳內容
		@_OutBox_Return_Default								nvarchar(150)		=	'{"success":"{0}","message":"{1}"}'	,	--[預設值] 指定要回傳的結果
		@_OutBox_Return_JSON								nvarchar(Max)		=	''									,	--[回傳值] 回傳 JSON 資料
		@_OutBox_Return_Query								nvarchar(1000)		=	',{"QueryInfo":{"service":"{0}","data":"{1}","count":"{2}","RunTime":"{3}"}}'	,	--[回傳值] 回傳 JSON 資料
		@_OutBox_Return_WrongReason							nvarchar(2000)		=	''									,	--[回傳值] 取得錯誤的資訊
		@_OutBox_Return_isOK								bit					=	0										--[回傳值] 指定回傳是否正確								
		
--===================記錄此次執行的資訊====================================
SET @_InBox_Inside_isErrorMessage='[內部程序] - 進入了 '+ @_InBox_Inside_ProgID +' 指定要查詢的項目資料為：'+ @_InBox_SearchWhere
Execute [usp_sys_Records]  @_InBox_Inside_ActionGUID,@_InBox_Inside_ProgID,@_InBox_Inside_ProgAction,@_InBox_Inside_isErrorMessage
--==========================================================================

--==========置換特定名稱============
IF(@_InBox_QueryWhere_City IS NOT NULL)
	Begin
		SET @_InBox_QueryWhere_City=REPLACE(@_InBox_QueryWhere_City,'台北縣','新北市');
		SET @_InBox_QueryWhere_City=REPLACE(@_InBox_QueryWhere_City,'台北','臺北');
		SET @_InBox_QueryWhere_City=REPLACE(@_InBox_QueryWhere_City,'台南','臺南');
		SET @_InBox_QueryWhere_City=REPLACE(@_InBox_QueryWhere_City,'台中','臺中');
		SET @_InBox_QueryWhere_City=REPLACE(@_InBox_QueryWhere_City,'台東','臺東');
	End

--===========================
--組合最後的查詢條件
--===========================
SET	@_Search_PageSize		=CONVERT(int,JSON_VALUE(@_InBox_SearchWhere,'$[0].pagesite.number'))	--取得顯示筆數
SET	@_Search_PageIndex		=CONVERT(int,JSON_VALUE(@_InBox_SearchWhere,'$[0].pagesite.index'))		--要從第幾頁顯示

SET @_OutBox_Return_Query	=REPLACE(@_OutBox_Return_Query,'{0}',ISNULL(@_InBox_QueryWhere_service,'NULL'));
SET @_OutBox_Return_Query	=REPLACE(@_OutBox_Return_Query,'{1}',ISNULL(@_InBox_QueryWhere_City,'NULL')+ISNULL(@_InBox_QueryWhere_Area,''));

if(LEN(@_InBox_QueryWhere_Area)!=0 OR @_InBox_QueryWhere_Area IS NOT NULL)
	Begin
		SET @_InBox_QueryWhere_Query=''+ @_InBox_QueryWhere_City+@_InBox_QueryWhere_Area +'%'
	End
else
	Begin
		SET @_InBox_QueryWhere_Query=''+ @_InBox_QueryWhere_City +'%'
	End


--==========================
-- 查詢內容
--==========================

if(@_Search_PageSize is null)	set @_Search_PageSize=10
if(@_Search_PageIndex is null)	set @_Search_PageIndex=0

--這裡先取得最終的筆數
SET @_Search_Total=( SELECT COUNT([Scas_ID]) FROM [Hex_AllSchools] WITH(NOLOCK) WHERE [Scas_Address] like @_InBox_QueryWhere_Query and [Scas_DELLock]=0 )
SET @_Search_TotalPage = (@_Search_Total / @_Search_PageSize)
		
IF @_Search_PageSize	< 1 SET @_Search_PageSize	= 1			--若每頁筆數小於1筆，則設定為每頁1筆
IF @_Search_PageIndex	< 0 SET @_Search_PageIndex	= 0			--若嘗試取得的頁數小於第1頁，則重設為第1頁
IF @_Search_PageIndex	> @_Search_TotalPage SET @_Search_PageIndex = @_Search_TotalPage --若嘗試取得的頁數超過總頁數，則回傳最後一頁

--取得查詢的內容
;WITH OutBox_ForJSONPATH
AS 
(
	SELECT 
		ROW_NUMBER() OVER (ORDER BY [Scas_ID])	AS [rownumber]		,	-- 顯示筆數
		'Taiwan'								AS [country_en]		,	-- 國家-英文
		'台灣'									AS [country_zh]		,	-- 國家-名稱
		[Scas_ID]								AS [id]				,	-- 學校代碼
		[Scas_CNAME]							AS [name]			,	-- 學校名稱
		[Scas_City]								AS [city]			,	-- 所屬縣市
		[Scas_EduAreaID]						AS [areaid]			,	-- 所屬區域代碼
		(
			SELECT	TOP 1 
					[sysArea_AreaNAME]
			FROM	[Hex_sys_TaiwanArea]
			WHERE	LEFT([sysArea_AreaID], 3)=[Scas_EduAreaID]
		) 										AS [areaname]		,	-- 所屬區域名稱
		CONVERT(nvarchar(20),Scas_longitude) 	AS [lon]			,	-- 經緯度-經度
		CONVERT(nvarchar(20),Scas_latitude) 	AS [lat]			,	-- 經緯度-緯度
		[Scas_Address]							AS [address]		,	-- 學校位置
		[Scas_Tel]								as [tel]			,	-- 學校電話
		[Scas_Fax]								as [fax]			,	-- 學校傳真
		[Scas_NowDateTime]						as [nowdatetime]	,	-- 新增日期
		[Scas_UPDDateTime]						as [upddatetime]		-- 最後日期

	FROM
				
		[Hex_AllSchools] WITH(NOLOCK)

	WHERE 
		[Scas_Address]							like @_InBox_QueryWhere_Query	and 
		[Scas_DELLock]							=0				
)

-- 將查詢的結果產生 JSON 並取得特定的筆數
SELECT 
		@_OutBox_Total				=@_Search_Total,
		@_OutBox_TotalPage			=@_Search_TotalPage,
		@_OutBox_PageSize			=@_Search_PageSize,
		@_OutBox_PageIndex			=@_Search_PageIndex,
		@_OutBox_ReturnJSON		=(
			SELECT	*
			FROM	OutBox_ForJSONPATH WITH(NOLOCK)
			WHERE	[rownumber] BETWEEN (@_Search_PageSize * @_Search_PageIndex +1 )  AND (@_Search_PageSize * (@_Search_PageIndex + 1))
			FOR JSON PATH, INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
		)

--寫入執行時間
EXECUTE [usp_AppFun_ElapsedDays_HHmmss]		@_InBox_Inside_NowDateTime	,	@_OutBox_Return_WrongReason OUTPUT
		
SET @_OutBox_RunActionMsg=@_OutBox_Return_WrongReason