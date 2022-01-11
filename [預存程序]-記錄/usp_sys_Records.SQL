IF OBJECT_ID('dbo.usp_sys_Records') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_sys_Records]
GO

CREATE PROCEDURE [dbo].[usp_sys_Records]
(
	@_InBox_ActionUNID				uniqueidentifier			, --執行項目任碼
	@_InBox_ProgramID				nvarchar(60)				, --專案項目代碼
	@_InBox_Action					nvarchar(400)				, --專案項目執行動作或是行為
	@_InBox_Msg					nvarchar(Max)				  --專案項目的資料
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
		-- 專案項目　：記錄執行的相關資料 - 這記錄是不重要的
		-- 專案用途　：將可能的執行動作寫到記錄內以備查
		-- 專案資料庫：Hex_EFManageCenter
		-- 專案資料表：sys_ConversionRecored
		-- 專案人員　：Peter
		-- 專案日期　：2021/09/13
		-- 專案說明　：
		-- 範例寫法　：

		--==========================================================================
		-- 記錄
		--Execute [usp_sys_Records] 
		--		'BDAEF2A2-C183-4AAF-A52D-3CD4981D5079'		,
		--		'你的執行程序名稱或是專案名稱',
		--		'要執行的動作，像是 INSERT , UPDATE , 執行的是什麼以表示出執行的動作',
		--		'資料來源是什麼以記錄'
		-- =========================================================================
	
		--===========================
		-- 程序使用
		--===========================
		DECLARE
			@_InBox_Inside_ProgID								nvarchar(60)			=	'usp_sys_Records'			,	--[預設值] 預存程序名稱
			@_InBox_Inside_ProgVersion							nvarchar(60)			=	'1.0'						,	--[預設值] 此程序執行版本號
			@_InBox_Inside_ProgAction							nvarchar(60)			=	'Inquire'					,	--[預設值] 執行的動作為何
			@_InBox_Inside_ActionGUID							uniqueidentifier		=	newid()						,	--[預設值] 提供此程序的執行代碼
			@_InBox_Inside_isError								bit					=	0							,	--[預設值] 是否有指定錯誤
			@_InBox_Inside_isErrorMessage						nvarchar(Max)		=	''							,	--[預設值] 存入錯誤的訊息
			@_InBox_iPageCount									int					=	0							,	--[預設值] 筆數
			--===========================
			-- 回傳用參數
			--===========================
			@_OutBox_ReturnValues								nvarchar(1000)		=	''							,	--[預設值] 要回傳的資料
			@_OutBox_RecoredMaxCount								int					=	100000						,	--[預設值] 筆數最大的限制
			@_OutBox_Return_Default								nvarchar(150)		=	'{"success":"{0}","message":"{1}","Recored":{"QuantCount":"{2}"}}'	,	--[預設值] 指定要回傳的結果
			@_OutBox_Return_JSON									nvarchar(Max)		=	''							,	--[回傳值] 回傳 JSON 資料
			@_OutBox_Return_WrongReason							nvarchar(2000)		=	''							,	--[回傳值] 取得錯誤的資訊
			@_OutBox_Return_isOK									bit					=	0								--[回傳值] 指定回傳是否正確
				

		--===========================
		-- 程序使用 - 記錄執行動作
		--===========================

		SET @_InBox_iPageCount=(SELECT COUNT(sysDPR_SNO) from sys_ConversionRecored) --先取得現在筆數

		if(@_InBox_iPageCount>=95000)
			Begin
				SET @_OutBox_Return_WrongReason					='[記錄筆數快滿 '+ CONVERT(nvarchar(20),@_InBox_iPageCount) +'] - ';
			End
		else
			Begin
				SET	@_OutBox_Return_WrongReason					='[記錄]'
			End
		
		BEGIN TRY
			BEGIN TRAN

				if(@_InBox_iPageCount>=@_OutBox_RecoredMaxCount)
					Begin

						DELETE FROM sys_ConversionRecored
						--這裡是重建索引的自動遞增的編號，重建沒有關係
						DBCC CHECKIDENT(sys_ConversionRecored, RESEED, 0)

					End

				INSERT INTO sys_ConversionRecored
				(
					sysDPR_NowDateTime									,
					sysDPR_ActionUNID									,
					sysDPR_ProgramID										,
					sysDPR_Action										,
					sysDPR_Msg											,
					sysDPR_isDEL
				)
				values
				(
					DATEADD(HH,+8,GETDATE())							,
					@_InBox_ActionUNID									,
					@_InBox_ProgramID									,
					@_InBox_Action										,
					@_OutBox_Return_WrongReason+'-'+@_InBox_Msg			,
					0
				)

				SET @_InBox_iPageCount=(SELECT COUNT(sysDPR_SNO) from sys_ConversionRecored) --先取得現在筆數

				SET	@_OutBox_ReturnValues=@_OutBox_Return_Default;
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{0}','1')
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{1}',@_OutBox_Return_WrongReason + '資料己經寫入')
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{2}',CONVERT(nvarchar(20),@_InBox_iPageCount))

			--ROLLBACK TRAN;
			COMMIT TRAN;

		END TRY
			BEGIN CATCH
				
				SET	@_OutBox_ReturnValues=@_OutBox_Return_Default;
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{0}','0')
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{1}','無法寫入此筆 ['+ CONVERT(nvarchar(40),@_InBox_ActionUNID) +'] 資料，'+@_InBox_Action +'  '+ERROR_MESSAGE())
				SET @_OutBox_ReturnValues=REPLACE(@_OutBox_ReturnValues,'{2}',CONVERT(nvarchar(20),@_InBox_iPageCount))

				ROLLBACK TRAN;
			END CATCH



