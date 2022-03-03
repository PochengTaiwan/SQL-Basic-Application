SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hex_Manage_Main](
	[HexMage_NOTEID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[HexMage_PARENDID] [numeric](18, 0) NOT NULL,
	[HexMage_CNAME] [nvarchar](40) NULL,
	[HexMage_ENAME] [nvarchar](40) NULL,
	[HexMage_ThumbURL] [nvarchar](100) NULL,
	[HexMage_Level] [tinyint] NULL,
	[HexMage_ID] [nvarchar](20) NULL,
	[HexMage_Type] [tinyint] NULL,
	[HexMage_Desc] [nvarchar](2000) NULL,
	[HexMage_StatusCode] [tinyint] NULL,
	[HexMage_UNID] [uniqueidentifier] NULL,
	[HexMage_NowDateTime] [datetime] NULL,
	[HexMage_UPDDateTime] [datetime] NULL,
	[HexMage_NowUNID] [uniqueidentifier] NULL,
	[HexMage_UPDUNID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Hex_CASE_Main] PRIMARY KEY CLUSTERED 
(
	[HexMage_NOTEID] ASC,
	[HexMage_PARENDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Hex_Manage_Main] ON 
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), N'台北市政府消防局', NULL, NULL, 1, N'GOV-001', 0, NULL, 0, N'cb197ab8-6325-4f09-8fd4-45a898460eee', CAST(N'2022-03-02T10:28:01.180' AS DateTime), CAST(N'2022-03-02T10:28:01.180' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'第一救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'8be23d73-bce8-42cb-8954-de78c794892d', CAST(N'2022-03-02T10:29:08.313' AS DateTime), CAST(N'2022-03-02T10:29:08.313' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'第二救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'fc8c5fad-ad58-44d4-b990-1fd9fa30f11f', CAST(N'2022-03-02T10:29:21.377' AS DateTime), CAST(N'2022-03-02T10:29:21.377' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(4 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'第三救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'aa4cfa94-5f42-4078-87cd-f9861ec34240', CAST(N'2022-03-02T10:29:22.263' AS DateTime), CAST(N'2022-03-02T10:29:22.263' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(5 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'第四救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'184e3a42-e2c5-4bb5-a18a-37c8e3a84e0b', CAST(N'2022-03-02T10:29:23.010' AS DateTime), CAST(N'2022-03-02T10:29:23.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(6 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'萬華中隊', NULL, NULL, 3, N'GOV-001-0', 1, NULL, 0, N'56a0c6a1-4aef-4277-9f20-125861f270b0', CAST(N'2022-03-02T10:31:09.103' AS DateTime), CAST(N'2022-03-02T10:31:09.103' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(7 AS Numeric(18, 0)), CAST(6 AS Numeric(18, 0)), N'龍山分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'f0da873f-e202-413d-be71-bc29df05cf4a', CAST(N'2022-03-02T10:31:19.423' AS DateTime), CAST(N'2022-03-02T10:31:19.423' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(8 AS Numeric(18, 0)), CAST(6 AS Numeric(18, 0)), N'雙園分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'c43a9a26-36be-49c8-aa97-c85c20f064fb', CAST(N'2022-03-02T10:31:26.013' AS DateTime), CAST(N'2022-03-02T10:31:26.013' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(9 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'信義中隊', NULL, NULL, 3, N'GOV-001-0', 1, NULL, 0, N'f9f0bfc1-07a8-4dc5-b6fe-56d971b8cf72', CAST(N'2022-03-02T10:32:06.113' AS DateTime), CAST(N'2022-03-02T10:32:06.113' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(10 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'信義分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'7c42a3a8-12de-41aa-a620-a0f251a61490', CAST(N'2022-03-02T10:32:19.043' AS DateTime), CAST(N'2022-03-02T10:32:19.043' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(11 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'永吉分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'8bfefdfd-f112-4ce7-9987-831bd4b017f0', CAST(N'2022-03-02T10:32:25.877' AS DateTime), CAST(N'2022-03-02T10:32:25.877' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(12 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'莊敬分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'a215e105-0fbc-4ac9-82de-7b2fad351fdd', CAST(N'2022-03-02T10:32:34.020' AS DateTime), CAST(N'2022-03-02T10:32:34.020' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(13 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), N'松山中隊', NULL, NULL, 3, N'GOV-001-0', 1, NULL, 0, N'428b1179-6e1f-4314-9dd3-444a1195eb9c', CAST(N'2022-03-02T10:38:35.543' AS DateTime), CAST(N'2022-03-02T10:38:35.543' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(14 AS Numeric(18, 0)), CAST(13 AS Numeric(18, 0)), N'八德分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'468587e5-f062-489a-a0cf-ae652be49c91', CAST(N'2022-03-02T10:38:39.910' AS DateTime), CAST(N'2022-03-02T10:38:39.910' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(15 AS Numeric(18, 0)), CAST(13 AS Numeric(18, 0)), N'中崙分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'2e62e94a-9c55-4be5-ae4a-464293c86fac', CAST(N'2022-03-02T10:38:40.807' AS DateTime), CAST(N'2022-03-02T10:38:40.807' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(16 AS Numeric(18, 0)), CAST(5 AS Numeric(18, 0)), N'士林中隊', NULL, NULL, 3, N'GOV-001-0', 1, NULL, 0, N'6162408f-692c-4dc9-b1a3-f21aff45adcb', CAST(N'2022-03-02T10:39:12.707' AS DateTime), CAST(N'2022-03-02T10:39:12.707' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(17 AS Numeric(18, 0)), CAST(16 AS Numeric(18, 0)), N'後港分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'028d17d9-e740-4ab8-8e38-3385ef0e0646', CAST(N'2022-03-02T10:39:30.180' AS DateTime), CAST(N'2022-03-02T10:39:30.180' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(18 AS Numeric(18, 0)), CAST(16 AS Numeric(18, 0)), N'社子分隊', NULL, NULL, 4, N'GOV-001-0', 1, NULL, 0, N'e45cc87d-c24a-43a6-860e-3442a6ad9716', CAST(N'2022-03-02T10:39:41.830' AS DateTime), CAST(N'2022-03-02T10:39:41.830' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(19 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), N'新北市政府消防局', NULL, NULL, 1, N'GOV-001', 0, NULL, 0, N'e2b3865e-ec85-4b04-8ea3-89b336fd87c3', CAST(N'2022-03-02T10:40:56.973' AS DateTime), CAST(N'2022-03-02T10:40:56.973' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(20 AS Numeric(18, 0)), CAST(19 AS Numeric(18, 0)), N'第一救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'b7215296-d680-4a70-bdbc-1c7792816e07', CAST(N'2022-03-02T10:42:58.813' AS DateTime), CAST(N'2022-03-02T10:42:58.813' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(21 AS Numeric(18, 0)), CAST(19 AS Numeric(18, 0)), N'第二救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'8b9fcfd7-17d5-4485-a948-9bd962a0682b', CAST(N'2022-03-02T10:43:14.250' AS DateTime), CAST(N'2022-03-02T10:43:14.250' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Hex_Manage_Main] ([HexMage_NOTEID], [HexMage_PARENDID], [HexMage_CNAME], [HexMage_ENAME], [HexMage_ThumbURL], [HexMage_Level], [HexMage_ID], [HexMage_Type], [HexMage_Desc], [HexMage_StatusCode], [HexMage_UNID], [HexMage_NowDateTime], [HexMage_UPDDateTime], [HexMage_NowUNID], [HexMage_UPDUNID]) VALUES (CAST(22 AS Numeric(18, 0)), CAST(19 AS Numeric(18, 0)), N'第三救災救護大隊', NULL, NULL, 2, N'GOV-001-0', 1, NULL, 0, N'71e91c72-e272-4805-9ca0-e43b293b4c73', CAST(N'2022-03-02T10:43:28.050' AS DateTime), CAST(N'2022-03-02T10:43:28.050' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Hex_Manage_Main] OFF
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_CASE_Main_HexCase_PARENDID]  DEFAULT ((0)) FOR [HexMage_PARENDID]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_Manage_Main_HexMage_Level]  DEFAULT ((0)) FOR [HexMage_Level]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_Manage_Main_HexMage_Type]  DEFAULT ((0)) FOR [HexMage_Type]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_CASE_Main_HexCase_StatusCode]  DEFAULT ((0)) FOR [HexMage_StatusCode]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_CASE_Main_HexCase_UNID]  DEFAULT (newid()) FOR [HexMage_UNID]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_CASE_Main_HexCase_NowDateTime]  DEFAULT (getdate()) FOR [HexMage_NowDateTime]
GO
ALTER TABLE [dbo].[Hex_Manage_Main] ADD  CONSTRAINT [DF_Hex_CASE_Main_HexCase_UPDDateTime]  DEFAULT (getdate()) FOR [HexMage_UPDDateTime]
GO
