
/****** Object:  Table [dbo].[sys_ConversionRecored]    Script Date: 2022/1/11 下午 02:01:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sys_ConversionRecored](
	[sysDPR_SNO] [int] IDENTITY(1,1) NOT NULL,
	[sysDPR_SetErrorSeverity] [tinyint] NULL,
	[sysDPR_NowDateTime] [datetime] NULL,
	[sysDPR_ActionUNID] [uniqueidentifier] NULL,
	[sysDPR_ProgramID] [nvarchar](60) NULL,
	[sysDPR_Action] [nvarchar](400) NULL,
	[sysDPR_Msg] [nvarchar](max) NULL,
	[sysDPR_isDEL] [bit] NULL,
 CONSTRAINT [PK_Hex_sys_ConversionRecored] PRIMARY KEY CLUSTERED 
(
	[sysDPR_SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


