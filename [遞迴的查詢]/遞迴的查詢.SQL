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