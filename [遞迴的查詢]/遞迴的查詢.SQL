--以下的查詢是透過遞迴的方式來找出相關層級的方法
-- HexMage_NOTEID       是自動遞增的方式
-- HexMage_PARENDID     是繼承來自於 HexMage_NOTEID 的代碼
-- 當要找出此單位是否有上層單位，就是用 HexMage_PARENDID 去比對出 HexMage_NOTEID 的資料
-- 以此方式就可以找出來這些資料


;WITH HexMangDeptInfo(NOTEID,PARENDID,CNAME,[Level])
AS   
(  
    SELECT	
            HexMage_NOTEID		AS NOTEID, 
            HexMage_PARENDID	AS PARENDID,
            HexMage_CNAME		AS CNAME	,
            HexMage_Level		AS [Level]
    FROM	[Hex_Manage_Main] AS MAINDEPT WITH(NOLOCK)
    WHERE	HexMage_UNID = JSON_VALUE(@_InBox_SearchWhere,'$[0].data.DEPTUNID')
    
    UNION ALL
    
    SELECT	
            DEPT.HexMage_NOTEID				AS HOTEID	,
            DEPT.HexMage_PARENDID			AS PARENDID,
            DEPT.HexMage_CNAME				AS CNAME	,
            DEPT.HexMage_Level				AS [LEVEL]
    FROM	[Hex_Manage_Main] AS DEPT
        INNER JOIN HexMangDeptInfo AS DEPTINFO
        ON DEPT.HexMage_PARENDID = DEPTINFO.NOTEID
)

SELECT * FROM HexMangDeptInfo order by 2