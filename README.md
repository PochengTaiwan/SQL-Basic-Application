# 歡迎您來到 PochengTaiwan 所分享的 ShareSQLBasic 

這裡是針對我所撰寫的 TSQL 語法來進行記錄，這些記錄都是我日常會用的語法與註解說明。
每一段的開頭語法會有以下的註解與說明，這是我個人的習慣!! 最主要的目的是自我要求「就算是寫 TSQL 也應該要有註解說明」並告訴往後要修改的工程師，當你要修改前必須要知道這是誰改的，這 TSQL 是做什麼用的並且要注意修改時要注意什麼。



====新增與維護注意事項(必須遵守規定)====

 1. 相關注解說明請寫在這裡，以免從 Visual Studio 轉至 SQL 說明內容沒有一起上去
 2. 相關新增與修改請務必註明 新增/維護 的相關人等資訊，以利後續資料表與 ERWIN 更新動作
 3. 請儘可能 FROM 後面加 WITH(NOLOCK) 不要鎖定表格
 4. 轉 JSON 格式 FOR JSON PATH, (輸出 Null)INCLUDE_NULL_VALUES, (排除 [] 格式)WITHOUT_ARRAY_WRAPPER
 5. 欄位不分大小寫 COLLATE Chinese_Taiwan_Stroke_CI_AS
 6. 儘量不要使用 Cursor 
 7. 前後要加 SET NOCOUNT ON; SET NOCOUNT OFF

======================================

專案項目　：分頁的查詢-範例

專案用途　：

專案資料庫：

專案資料表：

專案人員　：POCHENG

專案日期　：2021/11/01

專案說明　：

======================================

當然您可以自行略過不需要填寫，這是自我習慣。看過太多人在寫 TSQL 將語法全部都混合在一起，你在我這裡所看到的可能整段都會很長，但整體 TSQL 都是很清楚與明暸的。

