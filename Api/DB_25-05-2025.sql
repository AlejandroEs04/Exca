USE [GPViviendaDb]
GO
/****** Object:  Table [dbo].[approval_flow]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[approval_flow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[approval_flow_step]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[approval_flow_step](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[flow_id] [int] NOT NULL,
	[step_order] [int] NOT NULL,
	[signator_role_id] [int] NULL,
	[signator_area_id] [int] NULL,
	[signator_id] [int] NULL,
	[is_required] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[approval_request]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[approval_request](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[flow_step_id] [int] NOT NULL,
	[item_id] [varchar](20) NOT NULL,
	[requested_by] [int] NOT NULL,
	[requested_at] [datetime] NOT NULL,
	[responsed_at] [datetime] NULL,
	[response] [bit] NULL,
	[comments] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[area]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[area](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[client_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[business_turn]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[business_turn](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[case]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[case](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NOT NULL,
	[case_type_id] [int] NOT NULL,
	[originator_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[sended_at] [datetime] NULL,
	[updated_at] [datetime] NOT NULL,
	[status_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[case_condition]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[case_condition](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[case_id] [int] NOT NULL,
	[condition_id] [int] NOT NULL,
	[text_value] [text] NULL,
	[number_value] [decimal](18, 2) NULL,
	[date_value] [date] NULL,
	[boolean_value] [bit] NULL,
	[option_id] [int] NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[case_type]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[case_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[business_name] [varchar](100) NOT NULL,
	[email] [varchar](100) NULL,
	[phone_number] [varchar](15) NULL,
	[tax_id] [varchar](20) NULL,
	[type_id] [int] NOT NULL,
	[turn_id] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client_address]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[client_id] [int] NOT NULL,
	[street] [varchar](100) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[state] [varchar](50) NOT NULL,
	[postal_code] [varchar](20) NOT NULL,
	[country] [varchar](50) NOT NULL,
	[is_primary] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client_document]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_document](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[client_id] [int] NOT NULL,
	[document_id] [int] NOT NULL,
	[file_path] [varchar](255) NOT NULL,
	[uploaded_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client_type]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[condition]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[condition](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[description] [text] NULL,
	[type_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[condition_category]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[condition_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[condition_option]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[condition_option](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[condition_id] [int] NOT NULL,
	[option_value] [nvarchar](255) NOT NULL,
	[display_order] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[condition_type]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[condition_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[document]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[document](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[document_usage]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[document_usage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[document_id] [int] NOT NULL,
	[usage_type] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estados]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[clave_estado] [int] NOT NULL,
	[abreviacion_estado] [varchar](10) NOT NULL,
	[descripcion] [varchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[guarantee_type]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guarantee_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[individual]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[individual](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [varchar](100) NOT NULL,
	[tax_id] [varchar](20) NULL,
	[address_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[individual_document]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[individual_document](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[individual_id] [int] NOT NULL,
	[document_id] [int] NOT NULL,
	[file_path] [varchar](255) NOT NULL,
	[uploaded_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[land]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[land](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[municipality_id] [int] NULL,
	[state_id] [int] NULL,
	[residential_development_id] [int] NULL,
	[land_type_id] [int] NULL,
	[category_id] [int] NULL,
	[owner_company_id] [int] NULL,
	[tax_payer_company_id] [int] NULL,
	[user_last_update_id] [int] NULL,
	[status_id] [int] NULL,
	[is_trust_owned] [bit] NULL,
	[cadastral_file] [varchar](20) NULL,
	[block_lot] [varchar](30) NULL,
	[address] [varchar](255) NULL,
	[area] [float] NULL,
	[built_area] [float] NULL,
	[comments] [varchar](255) NULL,
	[has_water_service] [bit] NULL,
	[has_drainage_service] [bit] NULL,
	[has_cfe_service] [bit] NULL,
	[notes] [varchar](255) NULL,
	[incorporation] [varchar](50) NULL,
	[incorporation_notes] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[land_categories]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[land_categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[land_statuses]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[land_statuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[land_types]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[land_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lease_request]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lease_request](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NOT NULL,
	[guarantee_id] [int] NULL,
	[guarantee_type_id] [int] NOT NULL,
	[owner_id] [int] NOT NULL,
	[commission_agreement] [bit] NOT NULL,
	[assignment_income] [bit] NOT NULL,
	[property_file] [varchar](20) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[status_id] [int] NOT NULL,
	[created_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lease_request_condition]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lease_request_condition](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[lease_request_id] [int] NOT NULL,
	[condition_id] [int] NOT NULL,
	[text_value] [text] NULL,
	[number_value] [decimal](18, 2) NULL,
	[date_value] [date] NULL,
	[boolean_value] [bit] NULL,
	[option_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[municipios]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[municipios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_estado] [int] NOT NULL,
	[clave_municipio] [int] NOT NULL,
	[descripcion] [varchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[owner]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[owner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand_id] [int] NOT NULL,
	[stage_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[originator_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_activity]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_activity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NOT NULL,
	[title] [varchar](100) NOT NULL,
	[description] [text] NULL,
	[responsible_area_id] [int] NOT NULL,
	[responsible_id] [int] NULL,
	[due_date] [date] NOT NULL,
	[completed_date] [date] NULL,
	[status_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_activity_status]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_activity_status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
	[color_code] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_event]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_event](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [text] NOT NULL,
	[tentative_date] [date] NOT NULL,
	[actual_date] [date] NULL,
	[project_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_land]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_land](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NOT NULL,
	[land_id] [int] NOT NULL,
	[area] [decimal](10, 2) NOT NULL,
	[build_area] [decimal](10, 2) NOT NULL,
	[type_id] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_land_type]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_land_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property_tax]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_tax](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[land_id] [int] NULL,
	[property_tax_estatus_id] [int] NULL,
	[verified_user_id] [int] NULL,
	[tax_year] [int] NULL,
	[cadastral_value] [float] NULL,
	[cadastral_value_per_area] [float] NULL,
	[cadastral_value_per_built_area] [float] NULL,
	[receipt_file_url] [varchar](255) NULL,
	[tax_amount] [float] NULL,
	[penalties] [float] NULL,
	[other_charges] [float] NULL,
	[total_tax] [float] NULL,
	[discount] [float] NULL,
	[bonuses] [float] NULL,
	[others] [float] NULL,
	[net_payable] [float] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property_tax_status]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_tax_status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[residential_development]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[residential_development](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[city] [varchar](45) NOT NULL,
	[state] [varchar](45) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stage]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [varchar](100) NOT NULL,
	[email] [varchar](150) NOT NULL,
	[rol_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
	[hashed_password] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_rol]    Script Date: 25/5/2025 07:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_rol](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[approval_flow] ON 

INSERT [dbo].[approval_flow] ([id], [name], [description], [is_active]) VALUES (1, N'Solicitud de contrato', N'Flujo para aprobación de contratos', 1)
INSERT [dbo].[approval_flow] ([id], [name], [description], [is_active]) VALUES (2, N'Caratula legal', N'Flujo para aprobación de carátulas legales', 1)
SET IDENTITY_INSERT [dbo].[approval_flow] OFF
GO
SET IDENTITY_INSERT [dbo].[area] ON 

INSERT [dbo].[area] ([id], [name]) VALUES (1, N'Comercial')
INSERT [dbo].[area] ([id], [name]) VALUES (2, N'Legal')
INSERT [dbo].[area] ([id], [name]) VALUES (3, N'Gestión')
INSERT [dbo].[area] ([id], [name]) VALUES (4, N'Desarrollo')
SET IDENTITY_INSERT [dbo].[area] OFF
GO
SET IDENTITY_INSERT [dbo].[case_type] ON 

INSERT [dbo].[case_type] ([id], [name], [description]) VALUES (1, N'Technical', N'Casos técnicos relacionados con el proyecto')
INSERT [dbo].[case_type] ([id], [name], [description]) VALUES (2, N'Legal', N'Casos legales relacionados con el proyecto')
SET IDENTITY_INSERT [dbo].[case_type] OFF
GO
SET IDENTITY_INSERT [dbo].[client_type] ON 

INSERT [dbo].[client_type] ([id], [name]) VALUES (1, N'Persona Moral')
INSERT [dbo].[client_type] ([id], [name]) VALUES (2, N'Persona Física')
SET IDENTITY_INSERT [dbo].[client_type] OFF
GO
SET IDENTITY_INSERT [dbo].[condition] ON 

INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (1, N'Tipo de contrato', NULL, 5, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (2, N'Renta Mensual', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (3, N'Renta Anterior', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (4, N'Precio por m2 (LOCA)', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (5, N'Porcentaje de incremento', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (6, N'Referencia lista precios (Breña)', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (7, N'Cuota de mantenimiento', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (8, N'¿Cumple lo mínimo autorizado', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (9, N'Vigencia', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (10, N'Prorroga', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (11, N'¿Automática?', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (12, N'Plazo forzoso GPV', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (13, N'Plazo forzoso arrendatario', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (14, N'Incremento anual', NULL, 1, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (15, N'Incremento a partir de', NULL, 5, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (16, N'Incremento adicional', NULL, 1, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (17, N'¿Cuándo?', NULL, 1, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (18, N'Fecha de firma de contrato', NULL, 3, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (19, N'Deposito de garantía (meses)', NULL, 5, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (20, N'Renta anticipada (meses)', NULL, 2, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (21, N'Inicio de pago de renta', NULL, 3, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (22, N'Periodo de gracia (meses)', NULL, 5, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (23, N'¿Cumple con la tabla autorizada de PG?', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (24, N'¿Cúando inicia el PG?', NULL, 1, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (25, N'¿Hay que firmar acta de entrega?', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (26, N'¿Paga predial proporcional?', NULL, 4, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (27, N'Derecho de preferencia en venta', NULL, 5, 1, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (28, N'Estatus del predio', NULL, 5, 10, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (29, N'¿Está pagado el 7%?', NULL, 4, 10, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (30, N'En caso de NO, tiempos estimados para pagarlo', NULL, 1, 10, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (31, N'¿Tenemos el plano Ejecutivo de Ventas que ampare este proyecto?', NULL, 4, 10, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (32, N'¿Existe infraestructura frente al predio?', NULL, 4, 7, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (33, N'En caso de NO tiempos estimados para tenerlo', NULL, 1, 7, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (34, N'¿Existe infraestructura frente al predio?', NULL, 4, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (35, N'Esta pagada la incorporación AyD', NULL, 4, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (36, N'Esta pagada la aportación de Ay D?', NULL, 4, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (37, N'¿El local / predio tiene o tuvo contrato de servicios?', NULL, 4, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (38, N'¿Tenemos que tramitar factibilidad?', NULL, 4, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (39, N'Tiempos para tramitarla', NULL, 1, 8, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (40, N'CLG', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (41, N'Alineamiento Vial', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (42, N'Amojonamiento', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (43, N'Licencias', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (44, N'Fusión', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (45, N'Subdivisión', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (46, N'Uso de Suelo', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (47, N'Estudios Ambientales', NULL, 1, 9, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (48, N'Municipio', NULL, 1, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (49, N'Estado', NULL, 1, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (50, N'Vigencia Contrato en Años', NULL, 2, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (51, N'Inicio de Vigencia', NULL, 3, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (52, N'Prórroga de Vigencia en Años', NULL, 2, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (53, N'Prórroga Condicionada o Automática', NULL, 5, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (54, N'Plazo Para Solicitar Prórroga en Días', NULL, 2, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (55, N'Incremento de Renta en Prórroga', NULL, 1, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (56, N'Riesgo de no recibir pago de Rentas', NULL, 4, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (57, N'Fecha de Entrega de Posesión del Inmueble', NULL, 3, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (58, N'Responsabilidad de Trámite de Licencias', NULL, 5, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (59, N'Fecha de Entrega de Licencias', NULL, 3, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (60, N'Mantenimiento (Sin IVA)', NULL, 2, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (61, N'Indexación Mantenimiento', NULL, 1, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (62, N'Periodo de Gracia en Meses', NULL, 2, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (63, N'Inicio de Periodo de Gracia', NULL, 5, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (64, N'Fecha de Inicio de Periodo de Gracia', NULL, 3, 2, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (65, N'Depósito en Garantía en Meses', NULL, 2, 3, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (66, N'Cantidad Garantía en Meses', NULL, 2, 3, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (67, N'Actualización de Depósito en Garantía', NULL, 1, 3, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (68, N'Renta Anticipada en Meses', NULL, 2, 3, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (69, N'Cantidad de Renta Anticipada', NULL, 2, 3, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (70, N'GPV Autoriza Layout', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (71, N'GP Puede Cancelar el Contrato', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (72, N'Supuesto en el que GP puede Cancelar el Contrato', NULL, 1, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (73, N'Plazo en días para que GP Termine el Contrato', NULL, 2, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (74, N'Subarrendamiento Libre', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (75, N'Subarrendamiento a Filiales', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (76, N'Derecho de Preferencia en Venta para la Arrendataria', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (77, N'Tiempo en Días para Respuesta para Aceptación del Derecho de Preferencia', NULL, 2, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (78, N'Derecho de Preferencia para Filiales de la Arrendataria', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (79, N'Aviso a Filiales de Derecho de Preferencia', NULL, 4, 4, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (80, N'Giro de Negocio de la Arrendataria', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (81, N'Riesgo por Distancia con Zona Habitacional', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (82, N'Distancia con Casa Habitación más Cercana', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (83, N'Riesgo de Olores', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (84, N'Visto Bueno de Área de Ventas', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (85, N'Riesgo de Generación de Tráfico', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (86, N'Visto Bueno de Proyectos', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (87, N'Riesgo de Residuos Peligrosos', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (88, N'Remediación por la Arrendataria en caso de Contaminación de Suelo', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (89, N'Riesgo de Contaminación de Suelo', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (90, N'Arrendataria Obligada a Contratación de Seguro por Obra y Operación', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (91, N'Giros Prohibidos', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (92, N'Listado de Giros Prohibidos', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (93, N'Lotes Afectados por Giros Prohibidos', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (94, N'Exclusividad de Giros en Contrato', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (95, N'Lotes Afectados por Exclusividad de Giros', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (96, N'Giros Exclusivos', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (97, N'Incumple Giros Exclusivos de Otros Contratos', NULL, 4, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (98, N'Estado de Devolución del Inmueble al Termino del Contrato', NULL, 1, 5, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (99, N'GP Construye', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
GO
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (100, N'Superficie a Construir', NULL, 2, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (101, N'Incluye Estacionamiento', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (102, N'Servicio de Agua y Drenaje', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (103, N'GP Administra el consumo de agua', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (104, N'Servicio de Electricidad', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (105, N'Preparación Eléctrica', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (106, N'Fecha de Entrega del Inmueble con Construcción', NULL, 3, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (107, N'Aplica posibilidad de Entrega Parcial', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (108, N'Permite Terminación del Contrato por la No Entrega de la Construcción', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (109, N'Licencias a Cargo de', NULL, 5, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (110, N'Construcción de Totem', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (111, N'Posición de Rótulo', NULL, 1, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (112, N'Entrega de Planos / Proyectos', NULL, 4, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
INSERT [dbo].[condition] ([id], [name], [description], [type_id], [category_id], [is_active], [created_at], [updated_at]) VALUES (113, N'Fecha de Entrega de Planos / Proyectos', NULL, 3, 6, 1, CAST(N'2025-05-24T21:43:09.650' AS DateTime), CAST(N'2025-05-24T21:43:09.650' AS DateTime))
SET IDENTITY_INSERT [dbo].[condition] OFF
GO
SET IDENTITY_INSERT [dbo].[condition_category] ON 

INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (1, N'Condiciones Comerciales', N'Condiciones relacionadas con aspectos comerciales')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (2, N'Condiciones Generales', N'Condiciones generales del contrato')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (3, N'Contención de riesgos económicos', N'Condiciones para mitigar riesgos económicos')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (4, N'Contención de riesgos', N'Condiciones generales de contención de riesgos')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (5, N'Mitigación de riesgos', N'Condiciones para mitigar riesgos específicos')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (6, N'Construcción por GP', N'Condiciones sobre construcción por parte de GP')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (7, N'Electricidad', N'Condiciones relacionadas con servicio eléctrico')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (8, N'Agua y Drenaje', N'Condiciones relacionadas con agua y drenaje')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (9, N'Gestiones requeridas', N'Gestiones administrativas requeridas')
INSERT [dbo].[condition_category] ([id], [name], [description]) VALUES (10, N'Técnicas', N'Condiciones técnicas especiales')
SET IDENTITY_INSERT [dbo].[condition_category] OFF
GO
SET IDENTITY_INSERT [dbo].[condition_option] ON 

INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (1, 1, N'Primer Contrato', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (2, 1, N'Renovación', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (3, 15, N'Fecha de firma', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (4, 15, N'Obtención de permisos', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (5, 15, N'Inicio de operaciones', 3, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (6, 19, N'1', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (7, 19, N'2', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (8, 19, N'3', 3, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (9, 19, N'4', 4, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (10, 19, N'5', 5, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (11, 19, N'6', 6, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (12, 19, N'7', 7, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (13, 19, N'8', 8, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (14, 19, N'9', 9, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (15, 19, N'10', 10, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (16, 19, N'11', 11, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (17, 19, N'12', 12, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (18, 19, N'NO', 13, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (19, 23, N'1', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (20, 23, N'2', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (21, 23, N'3', 3, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (22, 23, N'4', 4, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (23, 23, N'5', 5, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (24, 23, N'6', 6, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (25, 23, N'7', 7, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (26, 23, N'8', 8, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (27, 23, N'9', 9, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (28, 23, N'10', 10, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (29, 23, N'11', 11, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (30, 23, N'12', 12, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (31, 23, N'NO', 13, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (32, 27, N'No tiene derecho de preferencia, no se le tiene que avisar', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (33, 27, N'No tiene derecho de preferencia, si se le tiene que avisar', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (34, 27, N'Si tiene derecho, no aplica entre filiales GP, no se le avisa', 3, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (35, 27, N'Si tiene derecho, no aplica entre filiales GP, si se le avisa', 4, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (36, 28, N'Lote Comercial', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (37, 28, N'Área fuera de trámite', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (38, 44, N'Condicionada', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (39, 44, N'Automática', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (40, 51, N'Arrendadora', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (41, 51, N'Arrendataria', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (42, 56, N'Entrega del Local Construido', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (43, 56, N'Firma de contrato', 2, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (44, 56, N'Otro', 3, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (45, 96, N'Arrendadora', 1, 1)
INSERT [dbo].[condition_option] ([id], [condition_id], [option_value], [display_order], [is_active]) VALUES (46, 96, N'Arrendataria', 2, 1)
SET IDENTITY_INSERT [dbo].[condition_option] OFF
GO
SET IDENTITY_INSERT [dbo].[condition_type] ON 

INSERT [dbo].[condition_type] ([id], [name], [description]) VALUES (1, N'text', N'Campo de texto libre')
INSERT [dbo].[condition_type] ([id], [name], [description]) VALUES (2, N'number', N'Campo numérico')
INSERT [dbo].[condition_type] ([id], [name], [description]) VALUES (3, N'date', N'Campo de fecha')
INSERT [dbo].[condition_type] ([id], [name], [description]) VALUES (4, N'boolean', N'Campo verdadero/falso')
INSERT [dbo].[condition_type] ([id], [name], [description]) VALUES (5, N'options', N'Selección de opciones predefinidas')
SET IDENTITY_INSERT [dbo].[condition_type] OFF
GO
SET IDENTITY_INSERT [dbo].[document] ON 

INSERT [dbo].[document] ([id], [name]) VALUES (1, N'Acta Constitutiva c/Inscriptción RPP')
INSERT [dbo].[document] ([id], [name]) VALUES (2, N'Poder Representante Legal C/Inscripción RPP')
INSERT [dbo].[document] ([id], [name]) VALUES (3, N'Identificación Oficial Vigente')
INSERT [dbo].[document] ([id], [name]) VALUES (4, N'Comprobante de Domicilio No Mayor a 3 Meses')
INSERT [dbo].[document] ([id], [name]) VALUES (5, N'RFC')
INSERT [dbo].[document] ([id], [name]) VALUES (6, N'Estado de Cuenta Bancario')
INSERT [dbo].[document] ([id], [name]) VALUES (7, N'Escritura de la Propiedad en Garantia')
INSERT [dbo].[document] ([id], [name]) VALUES (8, N'Otro')
SET IDENTITY_INSERT [dbo].[document] OFF
GO
SET IDENTITY_INSERT [dbo].[document_usage] ON 

INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (1, 1, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (2, 2, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (3, 3, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (4, 3, N'physical_person')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (5, 3, N'individual')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (6, 4, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (7, 4, N'physical_person')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (8, 4, N'individual')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (9, 5, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (10, 5, N'physical_person')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (11, 6, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (12, 6, N'physical_person')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (13, 7, N'individual')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (14, 8, N'legal_entity')
INSERT [dbo].[document_usage] ([id], [document_id], [usage_type]) VALUES (15, 8, N'physical_person')
SET IDENTITY_INSERT [dbo].[document_usage] OFF
GO
SET IDENTITY_INSERT [dbo].[estados] ON 

INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (1, 1, N'AGS', N'Aguascalientes')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (2, 2, N'BC', N'Baja California')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (3, 3, N'BCS', N'Baja California Sur')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (4, 4, N'CAMP', N'Campeche')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (5, 5, N'COAH', N'Coahuila de Zaragoza')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (6, 6, N'COL', N'Colima')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (7, 7, N'CHIS', N'Chiapas')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (8, 8, N'CHIH', N'Chihuahua')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (9, 9, N'DF', N'Ciudad de México')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (10, 10, N'DGO', N'Durango')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (11, 11, N'GTO', N'Guanajuato')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (12, 12, N'GRO', N'Guerrero')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (13, 13, N'HGO', N'Hidalgo')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (14, 14, N'JAL', N'Jalisco')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (15, 15, N'MEX', N'México')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (16, 16, N'MICH', N'Michoacán de Ocampo')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (17, 17, N'MOR', N'Morelos')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (18, 18, N'NAY', N'Nayarit')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (19, 19, N'NL', N'Nuevo León')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (20, 20, N'OAX', N'Oaxaca')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (21, 21, N'PUE', N'Puebla')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (22, 22, N'QRO', N'Querétaro')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (23, 23, N'QROO', N'Quintana Roo')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (24, 24, N'SLP', N'San Luis Potosí')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (25, 25, N'SIN', N'Sinaloa')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (26, 26, N'SON', N'Sonora')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (27, 27, N'TAB', N'Tabasco')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (28, 28, N'TAMPS', N'Tamaulipas')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (29, 29, N'TLAX', N'Tlaxcala')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (30, 30, N'VER', N'Veracruz de Ignacio de la Llave')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (31, 31, N'YUC', N'Yucatán')
INSERT [dbo].[estados] ([id], [clave_estado], [abreviacion_estado], [descripcion]) VALUES (32, 32, N'ZAC', N'Zacatecas')
SET IDENTITY_INSERT [dbo].[estados] OFF
GO
SET IDENTITY_INSERT [dbo].[guarantee_type] ON 

INSERT [dbo].[guarantee_type] ([id], [name], [description]) VALUES (1, N'Propiedad libre de gravamen', N'Garantía con propiedad sin gravámenes')
INSERT [dbo].[guarantee_type] ([id], [name], [description]) VALUES (2, N'Estados financieros / contables', N'Garantía mediante estados financieros')
INSERT [dbo].[guarantee_type] ([id], [name], [description]) VALUES (3, N'Obligado Solidario', N'Garantía con obligado solidario')
INSERT [dbo].[guarantee_type] ([id], [name], [description]) VALUES (4, N'Rentas Anticipadas', N'Garantía mediante rentas anticipadas')
INSERT [dbo].[guarantee_type] ([id], [name], [description]) VALUES (5, N'Sin garantia', N'Sin garantía requerida')
SET IDENTITY_INSERT [dbo].[guarantee_type] OFF
GO
SET IDENTITY_INSERT [dbo].[land] ON 

INSERT [dbo].[land] ([id], [municipality_id], [state_id], [residential_development_id], [land_type_id], [category_id], [owner_company_id], [tax_payer_company_id], [user_last_update_id], [status_id], [is_trust_owned], [cadastral_file], [block_lot], [address], [area], [built_area], [comments], [has_water_service], [has_drainage_service], [has_cfe_service], [notes], [incorporation], [incorporation_notes], [created_at], [updated_at]) VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, N'1231', N'asdad', N'adasd', 13131, 13131, N'', 1, 1, 0, N'', N'', N'', CAST(N'2025-05-25T07:09:40.070' AS DateTime), CAST(N'2025-05-25T07:09:40.070' AS DateTime))
SET IDENTITY_INSERT [dbo].[land] OFF
GO
SET IDENTITY_INSERT [dbo].[land_categories] ON 

INSERT [dbo].[land_categories] ([id], [description], [created_at], [updated_at]) VALUES (1, N'RENTADO', CAST(N'2025-05-25T07:00:40.380' AS DateTime), CAST(N'2025-05-25T07:00:40.380' AS DateTime))
SET IDENTITY_INSERT [dbo].[land_categories] OFF
GO
SET IDENTITY_INSERT [dbo].[land_statuses] ON 

INSERT [dbo].[land_statuses] ([id], [description], [created_at], [updated_at]) VALUES (1, N'ACTIVO', CAST(N'2025-05-25T07:01:08.923' AS DateTime), CAST(N'2025-05-25T07:01:08.923' AS DateTime))
SET IDENTITY_INSERT [dbo].[land_statuses] OFF
GO
SET IDENTITY_INSERT [dbo].[land_types] ON 

INSERT [dbo].[land_types] ([id], [description], [created_at], [updated_at]) VALUES (1, N'LOCAL', CAST(N'2025-05-25T07:01:35.160' AS DateTime), CAST(N'2025-05-25T07:01:35.160' AS DateTime))
SET IDENTITY_INSERT [dbo].[land_types] OFF
GO
SET IDENTITY_INSERT [dbo].[municipios] ON 

INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1, 1, 1, N'Aguascalientes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2, 1, 2, N'Asientos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (3, 1, 3, N'Calvillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (4, 1, 4, N'Cosío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (5, 1, 10, N'El Llano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (6, 1, 5, N'Jesús María')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (7, 1, 6, N'Pabellón de Arteaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (8, 1, 7, N'Rincón de Romos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (9, 1, 11, N'San Francisco de los Romo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (10, 1, 8, N'San José de Gracia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (11, 1, 9, N'Tepezalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (12, 2, 1, N'Ensenada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (13, 2, 2, N'Mexicali')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (14, 2, 5, N'Playas de Rosarito')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (15, 2, 3, N'Tecate')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (16, 2, 4, N'Tijuana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (17, 3, 1, N'Comondú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (18, 3, 3, N'La Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (19, 3, 9, N'Loreto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (20, 3, 8, N'Los Cabos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (21, 3, 2, N'Mulegé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (22, 4, 10, N'Calakmul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (23, 4, 1, N'Calkiní')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (24, 4, 2, N'Campeche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (25, 4, 11, N'Candelaria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (26, 4, 3, N'Carmen')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (27, 4, 4, N'Champotón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (28, 4, 9, N'Escárcega')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (29, 4, 5, N'Hecelchakán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (30, 4, 6, N'Hopelchén')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (31, 4, 7, N'Palizada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (32, 4, 8, N'Tenabo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (33, 7, 1, N'Acacoyagua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (34, 7, 2, N'Acala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (35, 7, 3, N'Acapetahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (36, 7, 113, N'Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (37, 7, 4, N'Altamirano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (38, 7, 5, N'Amatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (39, 7, 6, N'Amatenango de la Frontera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (40, 7, 7, N'Amatenango del Valle')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (41, 7, 8, N'Angel Albino Corzo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (42, 7, 9, N'Arriaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (43, 7, 10, N'Bejucal de Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (44, 7, 11, N'Bella Vista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (45, 7, 114, N'Benemérito de las Américas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (46, 7, 12, N'Berriozábal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (47, 7, 13, N'Bochil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (48, 7, 15, N'Cacahoatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (49, 7, 120, N'Capitán Luis Ángel Vidal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (50, 7, 16, N'Catazajá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (51, 7, 22, N'Chalchihuitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (52, 7, 23, N'Chamula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (53, 7, 24, N'Chanal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (54, 7, 25, N'Chapultenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (55, 7, 26, N'Chenalhó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (56, 7, 27, N'Chiapa de Corzo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (57, 7, 28, N'Chiapilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (58, 7, 29, N'Chicoasén')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (59, 7, 30, N'Chicomuselo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (60, 7, 31, N'Chilón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (61, 7, 17, N'Cintalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (62, 7, 18, N'Coapilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (63, 7, 19, N'Comitán de Domínguez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (64, 7, 21, N'Copainalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (65, 7, 14, N'El Bosque')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (66, 7, 122, N'El Parral')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (67, 7, 70, N'El Porvenir')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (68, 7, 123, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (69, 7, 32, N'Escuintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (70, 7, 33, N'Francisco León')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (71, 7, 34, N'Frontera Comalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (72, 7, 35, N'Frontera Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (73, 7, 37, N'Huehuetán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (74, 7, 39, N'Huitiupán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (75, 7, 38, N'Huixtán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (76, 7, 40, N'Huixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (77, 7, 42, N'Ixhuatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (78, 7, 43, N'Ixtacomitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (79, 7, 44, N'Ixtapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (80, 7, 45, N'Ixtapangajoya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (81, 7, 46, N'Jiquipilas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (82, 7, 47, N'Jitotol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (83, 7, 48, N'Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (84, 7, 20, N'La Concordia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (85, 7, 36, N'La Grandeza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (86, 7, 41, N'La Independencia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (87, 7, 50, N'La Libertad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (88, 7, 99, N'La Trinitaria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (89, 7, 49, N'Larráinzar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (90, 7, 52, N'Las Margaritas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (91, 7, 75, N'Las Rosas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (92, 7, 51, N'Mapastepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (93, 7, 115, N'Maravilla Tenejapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (94, 7, 116, N'Marqués de Comillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (95, 7, 53, N'Mazapa de Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (96, 7, 54, N'Mazatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (97, 7, 55, N'Metapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (98, 7, 124, N'Mezcalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (99, 7, 56, N'Mitontic')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (100, 7, 117, N'Montecristo de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (101, 7, 57, N'Motozintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (102, 7, 58, N'Nicolás Ruíz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (103, 7, 59, N'Ocosingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (104, 7, 60, N'Ocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (105, 7, 61, N'Ocozocoautla de Espinosa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (106, 7, 62, N'Ostuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (107, 7, 63, N'Osumacinta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (108, 7, 64, N'Oxchuc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (109, 7, 65, N'Palenque')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (110, 7, 66, N'Pantelhó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (111, 7, 67, N'Pantepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (112, 7, 68, N'Pichucalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (113, 7, 69, N'Pijijiapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (114, 7, 72, N'Pueblo Nuevo Solistahuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (115, 7, 73, N'Rayón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (116, 7, 74, N'Reforma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (117, 7, 121, N'Rincón Chamula San Pedro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (118, 7, 76, N'Sabanilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (119, 7, 77, N'Salto de Agua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (120, 7, 118, N'San Andrés Duraznal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (121, 7, 78, N'San Cristóbal de las Casas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (122, 7, 79, N'San Fernando')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (123, 7, 112, N'San Juan Cancuc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (124, 7, 110, N'San Lucas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (125, 7, 119, N'Santiago el Pinar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (126, 7, 80, N'Siltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (127, 7, 81, N'Simojovel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (128, 7, 82, N'Sitalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (129, 7, 83, N'Socoltenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (130, 7, 84, N'Solosuchiapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (131, 7, 85, N'Soyaló')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (132, 7, 86, N'Suchiapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (133, 7, 87, N'Suchiate')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (134, 7, 88, N'Sunuapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (135, 7, 89, N'Tapachula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (136, 7, 90, N'Tapalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (137, 7, 91, N'Tapilula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (138, 7, 92, N'Tecpatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (139, 7, 93, N'Tenejapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (140, 7, 94, N'Teopisca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (141, 7, 96, N'Tila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (142, 7, 97, N'Tonalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (143, 7, 98, N'Totolapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (144, 7, 100, N'Tumbalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (145, 7, 102, N'Tuxtla Chico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (146, 7, 101, N'Tuxtla Gutiérrez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (147, 7, 103, N'Tuzantán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (148, 7, 104, N'Tzimol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (149, 7, 105, N'Unión Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (150, 7, 106, N'Venustiano Carranza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (151, 7, 71, N'Villa Comaltitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (152, 7, 107, N'Villa Corzo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (153, 7, 108, N'Villaflores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (154, 7, 109, N'Yajalón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (155, 7, 111, N'Zinacantán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (156, 8, 1, N'Ahumada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (157, 8, 2, N'Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (158, 8, 3, N'Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (159, 8, 4, N'Aquiles Serdán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (160, 8, 5, N'Ascensión')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (161, 8, 6, N'Bachíniva')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (162, 8, 7, N'Balleza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (163, 8, 8, N'Batopilas de Manuel Gómez Morín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (164, 8, 9, N'Bocoyna')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (165, 8, 10, N'Buenaventura')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (166, 8, 11, N'Camargo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (167, 8, 12, N'Carichí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (168, 8, 13, N'Casas Grandes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (169, 8, 19, N'Chihuahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (170, 8, 20, N'Chínipas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (171, 8, 14, N'Coronado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (172, 8, 15, N'Coyame del Sotol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (173, 8, 17, N'Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (174, 8, 18, N'Cusihuiriachi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (175, 8, 21, N'Delicias')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (176, 8, 22, N'Dr. Belisario Domínguez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (177, 8, 64, N'El Tule')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (178, 8, 23, N'Galeana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (179, 8, 25, N'Gómez Farías')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (180, 8, 26, N'Gran Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (181, 8, 27, N'Guachochi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (182, 8, 28, N'Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (183, 8, 29, N'Guadalupe y Calvo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (184, 8, 30, N'Guazapares')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (185, 8, 31, N'Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (186, 8, 32, N'Hidalgo del Parral')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (187, 8, 33, N'Huejotitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (188, 8, 34, N'Ignacio Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (189, 8, 35, N'Janos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (190, 8, 36, N'Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (191, 8, 37, N'Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (192, 8, 38, N'Julimes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (193, 8, 16, N'La Cruz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (194, 8, 39, N'López')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (195, 8, 40, N'Madera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (196, 8, 41, N'Maguarichi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (197, 8, 42, N'Manuel Benavides')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (198, 8, 43, N'Matachí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (199, 8, 44, N'Matamoros')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (200, 8, 45, N'Meoqui')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (201, 8, 46, N'Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (202, 8, 47, N'Moris')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (203, 8, 48, N'Namiquipa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (204, 8, 49, N'Nonoava')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (205, 8, 50, N'Nuevo Casas Grandes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (206, 8, 51, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (207, 8, 52, N'Ojinaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (208, 8, 53, N'Praxedis G. Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (209, 8, 54, N'Riva Palacio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (210, 8, 55, N'Rosales')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (211, 8, 56, N'Rosario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (212, 8, 57, N'San Francisco de Borja')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (213, 8, 58, N'San Francisco de Conchos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (214, 8, 59, N'San Francisco del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (215, 8, 60, N'Santa Bárbara')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (216, 8, 24, N'Santa Isabel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (217, 8, 61, N'Satevó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (218, 8, 62, N'Saucillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (219, 8, 63, N'Temósachic')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (220, 8, 65, N'Urique')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (221, 8, 66, N'Uruachi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (222, 8, 67, N'Valle de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (223, 9, 10, N'Álvaro Obregón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (224, 9, 2, N'Azcapotzalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (225, 9, 14, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (226, 9, 3, N'Coyoacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (227, 9, 4, N'Cuajimalpa de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (228, 9, 15, N'Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (229, 9, 5, N'Gustavo A. Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (230, 9, 6, N'Iztacalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (231, 9, 7, N'Iztapalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (232, 9, 8, N'La Magdalena Contreras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (233, 9, 16, N'Miguel Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (234, 9, 9, N'Milpa Alta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (235, 9, 11, N'Tláhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (236, 9, 12, N'Tlalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (237, 9, 17, N'Venustiano Carranza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (238, 9, 13, N'Xochimilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (239, 5, 1, N'Abasolo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (240, 5, 2, N'Acuña')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (241, 5, 3, N'Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (242, 5, 4, N'Arteaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (243, 5, 5, N'Candela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (244, 5, 6, N'Castaños')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (245, 5, 7, N'Cuatro Ciénegas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (246, 5, 8, N'Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (247, 5, 9, N'Francisco I. Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (248, 5, 10, N'Frontera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (249, 5, 11, N'General Cepeda')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (250, 5, 12, N'Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (251, 5, 13, N'Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (252, 5, 14, N'Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (253, 5, 15, N'Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (254, 5, 16, N'Lamadrid')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (255, 5, 17, N'Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (256, 5, 18, N'Monclova')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (257, 5, 19, N'Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (258, 5, 20, N'Múzquiz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (259, 5, 21, N'Nadadores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (260, 5, 22, N'Nava')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (261, 5, 23, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (262, 5, 24, N'Parras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (263, 5, 25, N'Piedras Negras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (264, 5, 26, N'Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (265, 5, 27, N'Ramos Arizpe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (266, 5, 28, N'Sabinas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (267, 5, 29, N'Sacramento')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (268, 5, 30, N'Saltillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (269, 5, 31, N'San Buenaventura')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (270, 5, 32, N'San Juan de Sabinas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (271, 5, 33, N'San Pedro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (272, 5, 34, N'Sierra Mojada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (273, 5, 35, N'Torreón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (274, 5, 36, N'Viesca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (275, 5, 37, N'Villa Unión')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (276, 5, 38, N'Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (277, 6, 1, N'Armería')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (278, 6, 2, N'Colima')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (279, 6, 3, N'Comala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (280, 6, 4, N'Coquimatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (281, 6, 5, N'Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (282, 6, 6, N'Ixtlahuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (283, 6, 7, N'Manzanillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (284, 6, 8, N'Minatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (285, 6, 9, N'Tecomán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (286, 6, 10, N'Villa de Álvarez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (287, 10, 1, N'Canatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (288, 10, 2, N'Canelas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (289, 10, 3, N'Coneto de Comonfort')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (290, 10, 4, N'Cuencamé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (291, 10, 5, N'Durango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (292, 10, 18, N'El Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (293, 10, 6, N'General Simón Bolívar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (294, 10, 7, N'Gómez Palacio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (295, 10, 8, N'Guadalupe Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (296, 10, 9, N'Guanaceví')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (297, 10, 10, N'Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (298, 10, 11, N'Indé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (299, 10, 12, N'Lerdo')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (300, 10, 13, N'Mapimí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (301, 10, 14, N'Mezquital')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (302, 10, 15, N'Nazas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (303, 10, 16, N'Nombre de Dios')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (304, 10, 39, N'Nuevo Ideal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (305, 10, 17, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (306, 10, 19, N'Otáez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (307, 10, 20, N'Pánuco de Coronado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (308, 10, 21, N'Peñón Blanco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (309, 10, 22, N'Poanas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (310, 10, 23, N'Pueblo Nuevo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (311, 10, 24, N'Rodeo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (312, 10, 25, N'San Bernardo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (313, 10, 26, N'San Dimas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (314, 10, 27, N'San Juan de Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (315, 10, 28, N'San Juan del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (316, 10, 29, N'San Luis del Cordero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (317, 10, 30, N'San Pedro del Gallo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (318, 10, 31, N'Santa Clara')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (319, 10, 32, N'Santiago Papasquiaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (320, 10, 33, N'Súchil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (321, 10, 34, N'Tamazula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (322, 10, 35, N'Tepehuanes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (323, 10, 36, N'Tlahualilo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (324, 10, 37, N'Topia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (325, 10, 38, N'Vicente Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (326, 11, 1, N'Abasolo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (327, 11, 2, N'Acámbaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (328, 11, 4, N'Apaseo el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (329, 11, 5, N'Apaseo el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (330, 11, 6, N'Atarjea')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (331, 11, 7, N'Celaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (332, 11, 9, N'Comonfort')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (333, 11, 10, N'Coroneo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (334, 11, 11, N'Cortazar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (335, 11, 12, N'Cuerámaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (336, 11, 13, N'Doctor Mora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (337, 11, 14, N'Dolores Hidalgo Cuna de la Independencia Nacional')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (338, 11, 15, N'Guanajuato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (339, 11, 16, N'Huanímaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (340, 11, 17, N'Irapuato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (341, 11, 18, N'Jaral del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (342, 11, 19, N'Jerécuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (343, 11, 20, N'León')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (344, 11, 8, N'Manuel Doblado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (345, 11, 21, N'Moroleón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (346, 11, 22, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (347, 11, 23, N'Pénjamo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (348, 11, 24, N'Pueblo Nuevo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (349, 11, 25, N'Purísima del Rincón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (350, 11, 26, N'Romita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (351, 11, 27, N'Salamanca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (352, 11, 28, N'Salvatierra')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (353, 11, 29, N'San Diego de la Unión')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (354, 11, 30, N'San Felipe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (355, 11, 31, N'San Francisco del Rincón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (356, 11, 32, N'San José Iturbide')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (357, 11, 33, N'San Luis de la Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (358, 11, 3, N'San Miguel de Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (359, 11, 34, N'Santa Catarina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (360, 11, 35, N'Santa Cruz de Juventino Rosas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (361, 11, 36, N'Santiago Maravatío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (362, 11, 37, N'Silao de la Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (363, 11, 38, N'Tarandacuao')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (364, 11, 39, N'Tarimoro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (365, 11, 40, N'Tierra Blanca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (366, 11, 41, N'Uriangato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (367, 11, 42, N'Valle de Santiago')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (368, 11, 43, N'Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (369, 11, 44, N'Villagrán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (370, 11, 45, N'Xichú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (371, 11, 46, N'Yuriria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (372, 12, 1, N'Acapulco de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (373, 12, 76, N'Acatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (374, 12, 2, N'Ahuacuotzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (375, 12, 3, N'Ajuchitlán del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (376, 12, 4, N'Alcozauca de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (377, 12, 5, N'Alpoyeca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (378, 12, 6, N'Apaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (379, 12, 7, N'Arcelia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (380, 12, 8, N'Atenango del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (381, 12, 9, N'Atlamajalcingo del Monte')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (382, 12, 10, N'Atlixtac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (383, 12, 11, N'Atoyac de Álvarez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (384, 12, 12, N'Ayutla de los Libres')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (385, 12, 13, N'Azoyú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (386, 12, 14, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (387, 12, 15, N'Buenavista de Cuéllar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (388, 12, 28, N'Chilapa de Álvarez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (389, 12, 29, N'Chilpancingo de los Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (390, 12, 16, N'Coahuayutla de José María Izazaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (391, 12, 78, N'Cochoapa el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (392, 12, 17, N'Cocula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (393, 12, 18, N'Copala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (394, 12, 19, N'Copalillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (395, 12, 20, N'Copanatoyac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (396, 12, 21, N'Coyuca de Benítez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (397, 12, 22, N'Coyuca de Catalán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (398, 12, 23, N'Cuajinicuilapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (399, 12, 24, N'Cualác')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (400, 12, 25, N'Cuautepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (401, 12, 26, N'Cuetzala del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (402, 12, 27, N'Cutzamala de Pinzón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (403, 12, 75, N'Eduardo Neri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (404, 12, 30, N'Florencio Villarreal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (405, 12, 31, N'General Canuto A. Neri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (406, 12, 32, N'General Heliodoro Castillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (407, 12, 33, N'Huamuxtitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (408, 12, 34, N'Huitzuco de los Figueroa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (409, 12, 35, N'Iguala de la Independencia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (410, 12, 36, N'Igualapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (411, 12, 81, N'Iliatenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (412, 12, 37, N'Ixcateopan de Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (413, 12, 79, N'José Joaquín de Herrera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (414, 12, 39, N'Juan R. Escudero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (415, 12, 80, N'Juchitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (416, 12, 68, N'La Unión de Isidoro Montes de Oca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (417, 12, 40, N'Leonardo Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (418, 12, 41, N'Malinaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (419, 12, 77, N'Marquelia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (420, 12, 42, N'Mártir de Cuilapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (421, 12, 43, N'Metlatónoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (422, 12, 44, N'Mochitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (423, 12, 45, N'Olinalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (424, 12, 46, N'Ometepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (425, 12, 47, N'Pedro Ascencio Alquisiras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (426, 12, 48, N'Petatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (427, 12, 49, N'Pilcaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (428, 12, 50, N'Pungarabato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (429, 12, 51, N'Quechultenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (430, 12, 52, N'San Luis Acatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (431, 12, 53, N'San Marcos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (432, 12, 54, N'San Miguel Totolapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (433, 12, 55, N'Taxco de Alarcón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (434, 12, 56, N'Tecoanapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (435, 12, 57, N'Técpan de Galeana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (436, 12, 58, N'Teloloapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (437, 12, 59, N'Tepecoacuilco de Trujano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (438, 12, 60, N'Tetipac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (439, 12, 61, N'Tixtla de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (440, 12, 62, N'Tlacoachistlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (441, 12, 63, N'Tlacoapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (442, 12, 64, N'Tlalchapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (443, 12, 65, N'Tlalixtaquilla de Maldonado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (444, 12, 66, N'Tlapa de Comonfort')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (445, 12, 67, N'Tlapehuala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (446, 12, 69, N'Xalpatláhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (447, 12, 70, N'Xochihuehuetlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (448, 12, 71, N'Xochistlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (449, 12, 72, N'Zapotitlán Tablas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (450, 12, 38, N'Zihuatanejo de Azueta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (451, 12, 73, N'Zirándaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (452, 12, 74, N'Zitlala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (453, 13, 1, N'Acatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (454, 13, 2, N'Acaxochitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (455, 13, 3, N'Actopan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (456, 13, 4, N'Agua Blanca de Iturbide')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (457, 13, 5, N'Ajacuba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (458, 13, 6, N'Alfajayucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (459, 13, 7, N'Almoloya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (460, 13, 8, N'Apan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (461, 13, 10, N'Atitalaquia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (462, 13, 11, N'Atlapexco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (463, 13, 13, N'Atotonilco de Tula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (464, 13, 12, N'Atotonilco el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (465, 13, 14, N'Calnali')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (466, 13, 15, N'Cardonal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (467, 13, 17, N'Chapantongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (468, 13, 18, N'Chapulhuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (469, 13, 19, N'Chilcuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (470, 13, 16, N'Cuautepec de Hinojosa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (471, 13, 9, N'El Arenal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (472, 13, 20, N'Eloxochitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (473, 13, 21, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (474, 13, 22, N'Epazoyucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (475, 13, 23, N'Francisco I. Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (476, 13, 24, N'Huasca de Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (477, 13, 25, N'Huautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (478, 13, 26, N'Huazalingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (479, 13, 27, N'Huehuetla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (480, 13, 28, N'Huejutla de Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (481, 13, 29, N'Huichapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (482, 13, 30, N'Ixmiquilpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (483, 13, 31, N'Jacala de Ledezma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (484, 13, 32, N'Jaltocán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (485, 13, 33, N'Juárez Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (486, 13, 40, N'La Misión')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (487, 13, 34, N'Lolotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (488, 13, 35, N'Metepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (489, 13, 37, N'Metztitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (490, 13, 51, N'Mineral de la Reforma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (491, 13, 38, N'Mineral del Chico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (492, 13, 39, N'Mineral del Monte')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (493, 13, 41, N'Mixquiahuala de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (494, 13, 42, N'Molango de Escamilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (495, 13, 43, N'Nicolás Flores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (496, 13, 44, N'Nopala de Villagrán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (497, 13, 45, N'Omitlán de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (498, 13, 48, N'Pachuca de Soto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (499, 13, 47, N'Pacula')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (500, 13, 49, N'Pisaflores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (501, 13, 50, N'Progreso de Obregón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (502, 13, 36, N'San Agustín Metzquititlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (503, 13, 52, N'San Agustín Tlaxiaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (504, 13, 53, N'San Bartolo Tutotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (505, 13, 46, N'San Felipe Orizatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (506, 13, 54, N'San Salvador')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (507, 13, 55, N'Santiago de Anaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (508, 13, 56, N'Santiago Tulantepec de Lugo Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (509, 13, 57, N'Singuilucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (510, 13, 58, N'Tasquillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (511, 13, 59, N'Tecozautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (512, 13, 60, N'Tenango de Doria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (513, 13, 61, N'Tepeapulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (514, 13, 62, N'Tepehuacán de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (515, 13, 63, N'Tepeji del Río de Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (516, 13, 64, N'Tepetitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (517, 13, 65, N'Tetepango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (518, 13, 67, N'Tezontepec de Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (519, 13, 68, N'Tianguistengo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (520, 13, 69, N'Tizayuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (521, 13, 70, N'Tlahuelilpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (522, 13, 71, N'Tlahuiltepa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (523, 13, 72, N'Tlanalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (524, 13, 73, N'Tlanchinol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (525, 13, 74, N'Tlaxcoapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (526, 13, 75, N'Tolcayuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (527, 13, 76, N'Tula de Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (528, 13, 77, N'Tulancingo de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (529, 13, 66, N'Villa de Tezontepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (530, 13, 78, N'Xochiatipan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (531, 13, 79, N'Xochicoatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (532, 13, 80, N'Yahualica')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (533, 13, 81, N'Zacualtipán de Ángeles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (534, 13, 82, N'Zapotlán de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (535, 13, 83, N'Zempoala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (536, 13, 84, N'Zimapán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (537, 14, 1, N'Acatic')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (538, 14, 2, N'Acatlán de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (539, 14, 3, N'Ahualulco de Mercado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (540, 14, 4, N'Amacueca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (541, 14, 5, N'Amatitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (542, 14, 6, N'Ameca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (543, 14, 8, N'Arandas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (544, 14, 10, N'Atemajac de Brizuela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (545, 14, 11, N'Atengo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (546, 14, 12, N'Atenguillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (547, 14, 13, N'Atotonilco el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (548, 14, 14, N'Atoyac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (549, 14, 15, N'Autlán de Navarro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (550, 14, 16, N'Ayotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (551, 14, 17, N'Ayutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (552, 14, 19, N'Bolaños')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (553, 14, 20, N'Cabo Corrientes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (554, 14, 117, N'Cañadas de Obregón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (555, 14, 21, N'Casimiro Castillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (556, 14, 30, N'Chapala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (557, 14, 31, N'Chimaltitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (558, 14, 32, N'Chiquilistlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (559, 14, 22, N'Cihuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (560, 14, 24, N'Cocula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (561, 14, 25, N'Colotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (562, 14, 26, N'Concepción de Buenos Aires')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (563, 14, 27, N'Cuautitlán de García Barragán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (564, 14, 28, N'Cuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (565, 14, 29, N'Cuquío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (566, 14, 33, N'Degollado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (567, 14, 34, N'Ejutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (568, 14, 9, N'El Arenal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (569, 14, 37, N'El Grullo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (570, 14, 54, N'El Limón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (571, 14, 70, N'El Salto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (572, 14, 35, N'Encarnación de Díaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (573, 14, 36, N'Etzatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (574, 14, 79, N'Gómez Farías')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (575, 14, 38, N'Guachinango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (576, 14, 39, N'Guadalajara')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (577, 14, 40, N'Hostotipaquillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (578, 14, 41, N'Huejúcar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (579, 14, 42, N'Huejuquilla el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (580, 14, 44, N'Ixtlahuacán de los Membrillos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (581, 14, 45, N'Ixtlahuacán del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (582, 14, 46, N'Jalostotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (583, 14, 47, N'Jamay')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (584, 14, 48, N'Jesús María')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (585, 14, 49, N'Jilotlán de los Dolores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (586, 14, 50, N'Jocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (587, 14, 51, N'Juanacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (588, 14, 52, N'Juchitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (589, 14, 18, N'La Barca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (590, 14, 43, N'La Huerta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (591, 14, 57, N'La Manzanilla de la Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (592, 14, 53, N'Lagos de Moreno')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (593, 14, 55, N'Magdalena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (594, 14, 58, N'Mascota')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (595, 14, 59, N'Mazamitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (596, 14, 60, N'Mexticacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (597, 14, 61, N'Mezquitic')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (598, 14, 62, N'Mixtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (599, 14, 63, N'Ocotlán')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (600, 14, 64, N'Ojuelos de Jalisco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (601, 14, 65, N'Pihuamo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (602, 14, 66, N'Poncitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (603, 14, 67, N'Puerto Vallarta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (604, 14, 69, N'Quitupan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (605, 14, 71, N'San Cristóbal de la Barranca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (606, 14, 72, N'San Diego de Alejandría')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (607, 14, 113, N'San Gabriel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (608, 14, 125, N'San Ignacio Cerro Gordo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (609, 14, 73, N'San Juan de los Lagos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (610, 14, 7, N'San Juanito de Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (611, 14, 74, N'San Julián')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (612, 14, 75, N'San Marcos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (613, 14, 76, N'San Martín de Bolaños')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (614, 14, 77, N'San Martín Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (615, 14, 78, N'San Miguel el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (616, 14, 98, N'San Pedro Tlaquepaque')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (617, 14, 80, N'San Sebastián del Oeste')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (618, 14, 81, N'Santa María de los Ángeles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (619, 14, 56, N'Santa María del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (620, 14, 82, N'Sayula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (621, 14, 83, N'Tala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (622, 14, 84, N'Talpa de Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (623, 14, 85, N'Tamazula de Gordiano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (624, 14, 86, N'Tapalpa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (625, 14, 87, N'Tecalitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (626, 14, 89, N'Techaluta de Montenegro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (627, 14, 88, N'Tecolotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (628, 14, 90, N'Tenamaxtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (629, 14, 91, N'Teocaltiche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (630, 14, 92, N'Teocuitatlán de Corona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (631, 14, 93, N'Tepatitlán de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (632, 14, 94, N'Tequila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (633, 14, 95, N'Teuchitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (634, 14, 96, N'Tizapán el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (635, 14, 97, N'Tlajomulco de Zúñiga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (636, 14, 99, N'Tolimán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (637, 14, 100, N'Tomatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (638, 14, 101, N'Tonalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (639, 14, 102, N'Tonaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (640, 14, 103, N'Tonila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (641, 14, 104, N'Totatiche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (642, 14, 105, N'Tototlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (643, 14, 106, N'Tuxcacuesco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (644, 14, 107, N'Tuxcueca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (645, 14, 108, N'Tuxpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (646, 14, 109, N'Unión de San Antonio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (647, 14, 110, N'Unión de Tula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (648, 14, 111, N'Valle de Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (649, 14, 112, N'Valle de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (650, 14, 114, N'Villa Corona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (651, 14, 115, N'Villa Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (652, 14, 116, N'Villa Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (653, 14, 68, N'Villa Purificación')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (654, 14, 118, N'Yahualica de González Gallo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (655, 14, 119, N'Zacoalco de Torres')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (656, 14, 120, N'Zapopan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (657, 14, 121, N'Zapotiltic')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (658, 14, 122, N'Zapotitlán de Vadillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (659, 14, 123, N'Zapotlán del Rey')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (660, 14, 23, N'Zapotlán el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (661, 14, 124, N'Zapotlanejo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (662, 15, 1, N'Acambay de Ruíz Castañeda')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (663, 15, 2, N'Acolman')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (664, 15, 3, N'Aculco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (665, 15, 4, N'Almoloya de Alquisiras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (666, 15, 5, N'Almoloya de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (667, 15, 6, N'Almoloya del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (668, 15, 7, N'Amanalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (669, 15, 8, N'Amatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (670, 15, 9, N'Amecameca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (671, 15, 10, N'Apaxco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (672, 15, 11, N'Atenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (673, 15, 12, N'Atizapán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (674, 15, 13, N'Atizapán de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (675, 15, 14, N'Atlacomulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (676, 15, 15, N'Atlautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (677, 15, 16, N'Axapusco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (678, 15, 17, N'Ayapango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (679, 15, 18, N'Calimaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (680, 15, 19, N'Capulhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (681, 15, 25, N'Chalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (682, 15, 26, N'Chapa de Mota')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (683, 15, 27, N'Chapultepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (684, 15, 28, N'Chiautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (685, 15, 29, N'Chicoloapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (686, 15, 30, N'Chiconcuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (687, 15, 31, N'Chimalhuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (688, 15, 20, N'Coacalco de Berriozábal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (689, 15, 21, N'Coatepec Harinas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (690, 15, 22, N'Cocotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (691, 15, 23, N'Coyotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (692, 15, 24, N'Cuautitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (693, 15, 121, N'Cuautitlán Izcalli')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (694, 15, 32, N'Donato Guerra')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (695, 15, 33, N'Ecatepec de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (696, 15, 34, N'Ecatzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (697, 15, 64, N'El Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (698, 15, 35, N'Huehuetoca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (699, 15, 36, N'Hueypoxtla')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (700, 15, 37, N'Huixquilucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (701, 15, 38, N'Isidro Fabela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (702, 15, 39, N'Ixtapaluca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (703, 15, 40, N'Ixtapan de la Sal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (704, 15, 41, N'Ixtapan del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (705, 15, 42, N'Ixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (706, 15, 44, N'Jaltenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (707, 15, 45, N'Jilotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (708, 15, 46, N'Jilotzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (709, 15, 47, N'Jiquipilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (710, 15, 48, N'Jocotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (711, 15, 49, N'Joquicingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (712, 15, 50, N'Juchitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (713, 15, 70, N'La Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (714, 15, 51, N'Lerma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (715, 15, 123, N'Luvianos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (716, 15, 52, N'Malinalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (717, 15, 53, N'Melchor Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (718, 15, 54, N'Metepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (719, 15, 55, N'Mexicaltzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (720, 15, 56, N'Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (721, 15, 57, N'Naucalpan de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (722, 15, 59, N'Nextlalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (723, 15, 58, N'Nezahualcóyotl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (724, 15, 60, N'Nicolás Romero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (725, 15, 61, N'Nopaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (726, 15, 62, N'Ocoyoacac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (727, 15, 63, N'Ocuilan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (728, 15, 65, N'Otumba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (729, 15, 66, N'Otzoloapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (730, 15, 67, N'Otzolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (731, 15, 68, N'Ozumba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (732, 15, 69, N'Papalotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (733, 15, 71, N'Polotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (734, 15, 72, N'Rayón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (735, 15, 73, N'San Antonio la Isla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (736, 15, 74, N'San Felipe del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (737, 15, 124, N'San José del Rincón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (738, 15, 75, N'San Martín de las Pirámides')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (739, 15, 76, N'San Mateo Atenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (740, 15, 77, N'San Simón de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (741, 15, 78, N'Santo Tomás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (742, 15, 79, N'Soyaniquilpan de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (743, 15, 80, N'Sultepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (744, 15, 81, N'Tecámac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (745, 15, 82, N'Tejupilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (746, 15, 83, N'Temamatla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (747, 15, 84, N'Temascalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (748, 15, 85, N'Temascalcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (749, 15, 86, N'Temascaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (750, 15, 87, N'Temoaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (751, 15, 88, N'Tenancingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (752, 15, 89, N'Tenango del Aire')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (753, 15, 90, N'Tenango del Valle')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (754, 15, 91, N'Teoloyucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (755, 15, 92, N'Teotihuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (756, 15, 93, N'Tepetlaoxtoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (757, 15, 94, N'Tepetlixpa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (758, 15, 95, N'Tepotzotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (759, 15, 96, N'Tequixquiac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (760, 15, 97, N'Texcaltitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (761, 15, 98, N'Texcalyacac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (762, 15, 99, N'Texcoco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (763, 15, 100, N'Tezoyuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (764, 15, 101, N'Tianguistenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (765, 15, 102, N'Timilpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (766, 15, 103, N'Tlalmanalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (767, 15, 104, N'Tlalnepantla de Baz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (768, 15, 105, N'Tlatlaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (769, 15, 106, N'Toluca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (770, 15, 125, N'Tonanitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (771, 15, 107, N'Tonatico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (772, 15, 108, N'Tultepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (773, 15, 109, N'Tultitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (774, 15, 110, N'Valle de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (775, 15, 122, N'Valle de Chalco Solidaridad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (776, 15, 111, N'Villa de Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (777, 15, 112, N'Villa del Carbón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (778, 15, 113, N'Villa Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (779, 15, 114, N'Villa Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (780, 15, 43, N'Xalatlaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (781, 15, 115, N'Xonacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (782, 15, 116, N'Zacazonapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (783, 15, 117, N'Zacualpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (784, 15, 118, N'Zinacantepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (785, 15, 119, N'Zumpahuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (786, 15, 120, N'Zumpango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (787, 16, 1, N'Acuitzio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (788, 16, 2, N'Aguililla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (789, 16, 3, N'Álvaro Obregón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (790, 16, 4, N'Angamacutiro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (791, 16, 5, N'Angangueo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (792, 16, 6, N'Apatzingán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (793, 16, 7, N'Aporo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (794, 16, 8, N'Aquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (795, 16, 9, N'Ario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (796, 16, 10, N'Arteaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (797, 16, 11, N'Briseñas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (798, 16, 12, N'Buenavista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (799, 16, 13, N'Carácuaro')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (800, 16, 21, N'Charapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (801, 16, 22, N'Charo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (802, 16, 23, N'Chavinda')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (803, 16, 24, N'Cherán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (804, 16, 25, N'Chilchota')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (805, 16, 26, N'Chinicuila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (806, 16, 27, N'Chucándiro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (807, 16, 28, N'Churintzio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (808, 16, 29, N'Churumuco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (809, 16, 14, N'Coahuayana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (810, 16, 15, N'Coalcomán de Vázquez Pallares')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (811, 16, 16, N'Coeneo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (812, 16, 74, N'Cojumatlán de Régules')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (813, 16, 17, N'Contepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (814, 16, 18, N'Copándaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (815, 16, 19, N'Cotija')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (816, 16, 20, N'Cuitzeo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (817, 16, 30, N'Ecuandureo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (818, 16, 31, N'Epitacio Huerta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (819, 16, 32, N'Erongarícuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (820, 16, 33, N'Gabriel Zamora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (821, 16, 34, N'Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (822, 16, 36, N'Huandacareo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (823, 16, 37, N'Huaniqueo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (824, 16, 38, N'Huetamo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (825, 16, 39, N'Huiramba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (826, 16, 40, N'Indaparapeo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (827, 16, 41, N'Irimbo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (828, 16, 42, N'Ixtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (829, 16, 43, N'Jacona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (830, 16, 44, N'Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (831, 16, 45, N'Jiquilpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (832, 16, 113, N'José Sixto Verduzco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (833, 16, 46, N'Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (834, 16, 47, N'Jungapeo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (835, 16, 35, N'La Huacana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (836, 16, 69, N'La Piedad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (837, 16, 48, N'Lagunillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (838, 16, 52, N'Lázaro Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (839, 16, 75, N'Los Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (840, 16, 49, N'Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (841, 16, 50, N'Maravatío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (842, 16, 51, N'Marcos Castellanos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (843, 16, 53, N'Morelia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (844, 16, 54, N'Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (845, 16, 55, N'Múgica')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (846, 16, 56, N'Nahuatzen')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (847, 16, 57, N'Nocupétaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (848, 16, 58, N'Nuevo Parangaricutiro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (849, 16, 59, N'Nuevo Urecho')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (850, 16, 60, N'Numarán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (851, 16, 61, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (852, 16, 62, N'Pajacuarán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (853, 16, 63, N'Panindícuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (854, 16, 65, N'Paracho')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (855, 16, 64, N'Parácuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (856, 16, 66, N'Pátzcuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (857, 16, 67, N'Penjamillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (858, 16, 68, N'Peribán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (859, 16, 70, N'Purépero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (860, 16, 71, N'Puruándiro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (861, 16, 72, N'Queréndaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (862, 16, 73, N'Quiroga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (863, 16, 76, N'Sahuayo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (864, 16, 79, N'Salvador Escalante')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (865, 16, 77, N'San Lucas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (866, 16, 78, N'Santa Ana Maya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (867, 16, 80, N'Senguio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (868, 16, 81, N'Susupuato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (869, 16, 82, N'Tacámbaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (870, 16, 83, N'Tancítaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (871, 16, 84, N'Tangamandapio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (872, 16, 85, N'Tangancícuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (873, 16, 86, N'Tanhuato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (874, 16, 87, N'Taretan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (875, 16, 88, N'Tarímbaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (876, 16, 89, N'Tepalcatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (877, 16, 90, N'Tingambato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (878, 16, 91, N'Tingüindín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (879, 16, 92, N'Tiquicheo de Nicolás Romero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (880, 16, 93, N'Tlalpujahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (881, 16, 94, N'Tlazazalca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (882, 16, 95, N'Tocumbo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (883, 16, 96, N'Tumbiscatío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (884, 16, 97, N'Turicato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (885, 16, 98, N'Tuxpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (886, 16, 99, N'Tuzantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (887, 16, 100, N'Tzintzuntzan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (888, 16, 101, N'Tzitzio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (889, 16, 102, N'Uruapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (890, 16, 103, N'Venustiano Carranza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (891, 16, 104, N'Villamar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (892, 16, 105, N'Vista Hermosa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (893, 16, 106, N'Yurécuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (894, 16, 107, N'Zacapu')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (895, 16, 108, N'Zamora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (896, 16, 109, N'Zináparo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (897, 16, 110, N'Zinapécuaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (898, 16, 111, N'Ziracuaretiro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (899, 16, 112, N'Zitácuaro')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (900, 17, 1, N'Amacuzac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (901, 17, 2, N'Atlatlahucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (902, 17, 3, N'Axochiapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (903, 17, 4, N'Ayala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (904, 17, 5, N'Coatlán del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (905, 17, 6, N'Cuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (906, 17, 7, N'Cuernavaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (907, 17, 8, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (908, 17, 9, N'Huitzilac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (909, 17, 10, N'Jantetelco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (910, 17, 11, N'Jiutepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (911, 17, 12, N'Jojutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (912, 17, 13, N'Jonacatepec de Leandro Valle')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (913, 17, 14, N'Mazatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (914, 17, 15, N'Miacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (915, 17, 16, N'Ocuituco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (916, 17, 17, N'Puente de Ixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (917, 17, 18, N'Temixco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (918, 17, 33, N'Temoac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (919, 17, 19, N'Tepalcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (920, 17, 20, N'Tepoztlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (921, 17, 21, N'Tetecala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (922, 17, 22, N'Tetela del Volcán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (923, 17, 23, N'Tlalnepantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (924, 17, 24, N'Tlaltizapán de Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (925, 17, 25, N'Tlaquiltenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (926, 17, 26, N'Tlayacapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (927, 17, 27, N'Totolapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (928, 17, 28, N'Xochitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (929, 17, 29, N'Yautepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (930, 17, 30, N'Yecapixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (931, 17, 31, N'Zacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (932, 17, 32, N'Zacualpan de Amilpas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (933, 18, 1, N'Acaponeta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (934, 18, 2, N'Ahuacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (935, 18, 3, N'Amatlán de Cañas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (936, 18, 20, N'Bahía de Banderas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (937, 18, 4, N'Compostela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (938, 18, 9, N'Del Nayar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (939, 18, 5, N'Huajicori')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (940, 18, 6, N'Ixtlán del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (941, 18, 7, N'Jala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (942, 18, 19, N'La Yesca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (943, 18, 10, N'Rosamorada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (944, 18, 11, N'Ruíz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (945, 18, 12, N'San Blas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (946, 18, 13, N'San Pedro Lagunillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (947, 18, 14, N'Santa María del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (948, 18, 15, N'Santiago Ixcuintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (949, 18, 16, N'Tecuala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (950, 18, 17, N'Tepic')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (951, 18, 18, N'Tuxpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (952, 18, 8, N'Xalisco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (953, 19, 1, N'Abasolo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (954, 19, 2, N'Agualeguas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (955, 19, 4, N'Allende')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (956, 19, 5, N'Anáhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (957, 19, 6, N'Apodaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (958, 19, 7, N'Aramberri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (959, 19, 8, N'Bustamante')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (960, 19, 9, N'Cadereyta Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (961, 19, 11, N'Cerralvo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (962, 19, 13, N'China')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (963, 19, 12, N'Ciénega de Flores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (964, 19, 14, N'Doctor Arroyo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (965, 19, 15, N'Doctor Coss')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (966, 19, 16, N'Doctor González')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (967, 19, 10, N'El Carmen')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (968, 19, 17, N'Galeana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (969, 19, 18, N'García')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (970, 19, 20, N'General Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (971, 19, 21, N'General Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (972, 19, 22, N'General Terán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (973, 19, 23, N'General Treviño')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (974, 19, 24, N'General Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (975, 19, 25, N'General Zuazua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (976, 19, 26, N'Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (977, 19, 47, N'Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (978, 19, 28, N'Higueras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (979, 19, 29, N'Hualahuises')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (980, 19, 30, N'Iturbide')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (981, 19, 31, N'Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (982, 19, 32, N'Lampazos de Naranjo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (983, 19, 33, N'Linares')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (984, 19, 3, N'Los Aldamas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (985, 19, 27, N'Los Herreras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (986, 19, 42, N'Los Ramones')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (987, 19, 34, N'Marín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (988, 19, 35, N'Melchor Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (989, 19, 36, N'Mier y Noriega')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (990, 19, 37, N'Mina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (991, 19, 38, N'Montemorelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (992, 19, 39, N'Monterrey')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (993, 19, 40, N'Parás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (994, 19, 41, N'Pesquería')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (995, 19, 43, N'Rayones')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (996, 19, 44, N'Sabinas Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (997, 19, 45, N'Salinas Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (998, 19, 46, N'San Nicolás de los Garza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (999, 19, 19, N'San Pedro Garza García')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1000, 19, 48, N'Santa Catarina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1001, 19, 49, N'Santiago')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1002, 19, 50, N'Vallecillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1003, 19, 51, N'Villaldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1004, 20, 1, N'Abejones')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1005, 20, 2, N'Acatlán de Pérez Figueroa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1006, 20, 174, N'Ánimas Trujano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1007, 20, 3, N'Asunción Cacalotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1008, 20, 4, N'Asunción Cuyotepeji')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1009, 20, 5, N'Asunción Ixtaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1010, 20, 6, N'Asunción Nochixtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1011, 20, 7, N'Asunción Ocotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1012, 20, 8, N'Asunción Tlacolulita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1013, 20, 398, N'Ayoquezco de Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1014, 20, 9, N'Ayotzintepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1015, 20, 11, N'Calihualá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1016, 20, 12, N'Candelaria Loxicha')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1017, 20, 247, N'Capulálpam de Méndez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1018, 20, 25, N'Chahuites')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1019, 20, 26, N'Chalcatongo de Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1020, 20, 27, N'Chiquihuitlán de Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1021, 20, 13, N'Ciénega de Zimatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1022, 20, 14, N'Ciudad Ixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1023, 20, 15, N'Coatecas Altas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1024, 20, 16, N'Coicoyán de las Flores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1025, 20, 18, N'Concepción Buenavista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1026, 20, 19, N'Concepción Pápalo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1027, 20, 20, N'Constancia del Rosario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1028, 20, 21, N'Cosolapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1029, 20, 22, N'Cosoltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1030, 20, 23, N'Cuilápam de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1031, 20, 24, N'Cuyamecalco Villa de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1032, 20, 10, N'El Barrio de la Soledad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1033, 20, 30, N'El Espinal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1034, 20, 29, N'Eloxochitlán de Flores Magón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1035, 20, 32, N'Fresnillo de Trujano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1036, 20, 34, N'Guadalupe de Ramírez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1037, 20, 33, N'Guadalupe Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1038, 20, 35, N'Guelatao de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1039, 20, 36, N'Guevea de Humboldt')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1040, 20, 28, N'Heroica Ciudad de Ejutla de Crespo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1041, 20, 39, N'Heroica Ciudad de Huajuapan de León')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1042, 20, 43, N'Heroica Ciudad de Juchitán de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1043, 20, 397, N'Heroica Ciudad de Tlaxiaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1044, 20, 40, N'Huautepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1045, 20, 41, N'Huautla de Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1046, 20, 65, N'Ixpantepec Nieves')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1047, 20, 42, N'Ixtlán de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1048, 20, 17, N'La Compañía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1049, 20, 69, N'La Pe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1050, 20, 76, N'La Reforma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1051, 20, 556, N'La Trinidad Vista Hermosa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1052, 20, 44, N'Loma Bonita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1053, 20, 45, N'Magdalena Apasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1054, 20, 46, N'Magdalena Jaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1055, 20, 48, N'Magdalena Mixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1056, 20, 49, N'Magdalena Ocotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1057, 20, 50, N'Magdalena Peñasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1058, 20, 51, N'Magdalena Teitipac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1059, 20, 52, N'Magdalena Tequisistlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1060, 20, 53, N'Magdalena Tlacotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1061, 20, 562, N'Magdalena Yodocono de Porfirio Díaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1062, 20, 54, N'Magdalena Zahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1063, 20, 55, N'Mariscala de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1064, 20, 56, N'Mártires de Tacubaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1065, 20, 57, N'Matías Romero Avendaño')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1066, 20, 58, N'Mazatlán Villa de Flores')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1067, 20, 37, N'Mesones Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1068, 20, 59, N'Miahuatlán de Porfirio Díaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1069, 20, 60, N'Mixistlán de la Reforma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1070, 20, 61, N'Monjas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1071, 20, 62, N'Natividad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1072, 20, 63, N'Nazareno Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1073, 20, 64, N'Nejapa de Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1074, 20, 504, N'Nuevo Zoquiápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1075, 20, 67, N'Oaxaca de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1076, 20, 68, N'Ocotlán de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1077, 20, 70, N'Pinotepa de Don Luis')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1078, 20, 71, N'Pluma Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1079, 20, 73, N'Putla Villa de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1080, 20, 75, N'Reforma de Pineda')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1081, 20, 77, N'Reyes Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1082, 20, 78, N'Rojas de Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1083, 20, 79, N'Salina Cruz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1084, 20, 80, N'San Agustín Amatengo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1085, 20, 81, N'San Agustín Atenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1086, 20, 82, N'San Agustín Chayuco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1087, 20, 83, N'San Agustín de las Juntas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1088, 20, 84, N'San Agustín Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1089, 20, 85, N'San Agustín Loxicha')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1090, 20, 86, N'San Agustín Tlacotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1091, 20, 87, N'San Agustín Yatareni')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1092, 20, 88, N'San Andrés Cabecera Nueva')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1093, 20, 89, N'San Andrés Dinicuiti')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1094, 20, 90, N'San Andrés Huaxpaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1095, 20, 91, N'San Andrés Huayápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1096, 20, 92, N'San Andrés Ixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1097, 20, 93, N'San Andrés Lagunas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1098, 20, 94, N'San Andrés Nuxiño')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1099, 20, 95, N'San Andrés Paxtlán')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1100, 20, 96, N'San Andrés Sinaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1101, 20, 97, N'San Andrés Solaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1102, 20, 98, N'San Andrés Teotilálpam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1103, 20, 99, N'San Andrés Tepetlapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1104, 20, 100, N'San Andrés Yaá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1105, 20, 101, N'San Andrés Zabache')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1106, 20, 102, N'San Andrés Zautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1107, 20, 103, N'San Antonino Castillo Velasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1108, 20, 104, N'San Antonino el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1109, 20, 105, N'San Antonino Monte Verde')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1110, 20, 106, N'San Antonio Acutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1111, 20, 107, N'San Antonio de la Cal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1112, 20, 108, N'San Antonio Huitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1113, 20, 109, N'San Antonio Nanahuatípam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1114, 20, 110, N'San Antonio Sinicahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1115, 20, 111, N'San Antonio Tepetlapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1116, 20, 112, N'San Baltazar Chichicápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1117, 20, 113, N'San Baltazar Loxicha')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1118, 20, 114, N'San Baltazar Yatzachi el Bajo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1119, 20, 115, N'San Bartolo Coyotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1120, 20, 121, N'San Bartolo Soyaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1121, 20, 122, N'San Bartolo Yautepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1122, 20, 116, N'San Bartolomé Ayautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1123, 20, 117, N'San Bartolomé Loxicha')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1124, 20, 118, N'San Bartolomé Quialana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1125, 20, 119, N'San Bartolomé Yucuañe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1126, 20, 120, N'San Bartolomé Zoogocho')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1127, 20, 123, N'San Bernardo Mixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1128, 20, 124, N'San Blas Atempa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1129, 20, 125, N'San Carlos Yautepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1130, 20, 126, N'San Cristóbal Amatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1131, 20, 127, N'San Cristóbal Amoltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1132, 20, 128, N'San Cristóbal Lachirioag')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1133, 20, 129, N'San Cristóbal Suchixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1134, 20, 130, N'San Dionisio del Mar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1135, 20, 131, N'San Dionisio Ocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1136, 20, 132, N'San Dionisio Ocotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1137, 20, 133, N'San Esteban Atatlahuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1138, 20, 134, N'San Felipe Jalapa de Díaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1139, 20, 135, N'San Felipe Tejalápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1140, 20, 136, N'San Felipe Usila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1141, 20, 137, N'San Francisco Cahuacuá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1142, 20, 138, N'San Francisco Cajonos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1143, 20, 139, N'San Francisco Chapulapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1144, 20, 140, N'San Francisco Chindúa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1145, 20, 141, N'San Francisco del Mar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1146, 20, 142, N'San Francisco Huehuetlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1147, 20, 143, N'San Francisco Ixhuatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1148, 20, 144, N'San Francisco Jaltepetongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1149, 20, 145, N'San Francisco Lachigoló')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1150, 20, 146, N'San Francisco Logueche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1151, 20, 147, N'San Francisco Nuxaño')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1152, 20, 148, N'San Francisco Ozolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1153, 20, 149, N'San Francisco Sola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1154, 20, 150, N'San Francisco Telixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1155, 20, 151, N'San Francisco Teopan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1156, 20, 152, N'San Francisco Tlapancingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1157, 20, 153, N'San Gabriel Mixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1158, 20, 154, N'San Ildefonso Amatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1159, 20, 155, N'San Ildefonso Sola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1160, 20, 156, N'San Ildefonso Villa Alta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1161, 20, 157, N'San Jacinto Amilpas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1162, 20, 158, N'San Jacinto Tlacotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1163, 20, 159, N'San Jerónimo Coatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1164, 20, 160, N'San Jerónimo Silacayoapilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1165, 20, 161, N'San Jerónimo Sosola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1166, 20, 162, N'San Jerónimo Taviche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1167, 20, 163, N'San Jerónimo Tecóatl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1168, 20, 550, N'San Jerónimo Tlacochahuaya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1169, 20, 164, N'San Jorge Nuchita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1170, 20, 165, N'San José Ayuquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1171, 20, 166, N'San José Chiltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1172, 20, 167, N'San José del Peñasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1173, 20, 72, N'San José del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1174, 20, 168, N'San José Estancia Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1175, 20, 169, N'San José Independencia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1176, 20, 170, N'San José Lachiguiri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1177, 20, 171, N'San José Tenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1178, 20, 172, N'San Juan Achiutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1179, 20, 173, N'San Juan Atepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1180, 20, 175, N'San Juan Bautista Atatlahuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1181, 20, 176, N'San Juan Bautista Coixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1182, 20, 177, N'San Juan Bautista Cuicatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1183, 20, 178, N'San Juan Bautista Guelache')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1184, 20, 179, N'San Juan Bautista Jayacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1185, 20, 180, N'San Juan Bautista Lo de Soto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1186, 20, 181, N'San Juan Bautista Suchitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1187, 20, 183, N'San Juan Bautista Tlachichilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1188, 20, 182, N'San Juan Bautista Tlacoatzintepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1189, 20, 184, N'San Juan Bautista Tuxtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1190, 20, 559, N'San Juan Bautista Valle Nacional')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1191, 20, 185, N'San Juan Cacahuatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1192, 20, 191, N'San Juan Chicomezúchil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1193, 20, 192, N'San Juan Chilateca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1194, 20, 186, N'San Juan Cieneguilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1195, 20, 187, N'San Juan Coatzóspam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1196, 20, 188, N'San Juan Colorado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1197, 20, 189, N'San Juan Comaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1198, 20, 190, N'San Juan Cotzocón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1199, 20, 206, N'San Juan de los Cués')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1200, 20, 193, N'San Juan del Estado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1201, 20, 194, N'San Juan del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1202, 20, 195, N'San Juan Diuxi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1203, 20, 196, N'San Juan Evangelista Analco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1204, 20, 197, N'San Juan Guelavía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1205, 20, 198, N'San Juan Guichicovi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1206, 20, 199, N'San Juan Ihualtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1207, 20, 200, N'San Juan Juquila Mixes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1208, 20, 201, N'San Juan Juquila Vijanos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1209, 20, 202, N'San Juan Lachao')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1210, 20, 203, N'San Juan Lachigalla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1211, 20, 204, N'San Juan Lajarcia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1212, 20, 205, N'San Juan Lalana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1213, 20, 207, N'San Juan Mazatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1214, 20, 208, N'San Juan Mixtepec -Dto. 08 -')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1215, 20, 209, N'San Juan Mixtepec -Dto. 26 -')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1216, 20, 210, N'San Juan Ñumí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1217, 20, 211, N'San Juan Ozolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1218, 20, 212, N'San Juan Petlapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1219, 20, 213, N'San Juan Quiahije')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1220, 20, 214, N'San Juan Quiotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1221, 20, 215, N'San Juan Sayultepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1222, 20, 216, N'San Juan Tabaá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1223, 20, 217, N'San Juan Tamazola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1224, 20, 218, N'San Juan Teita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1225, 20, 219, N'San Juan Teitipac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1226, 20, 220, N'San Juan Tepeuxila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1227, 20, 221, N'San Juan Teposcolula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1228, 20, 222, N'San Juan Yaeé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1229, 20, 223, N'San Juan Yatzona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1230, 20, 224, N'San Juan Yucuita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1231, 20, 225, N'San Lorenzo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1232, 20, 226, N'San Lorenzo Albarradas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1233, 20, 227, N'San Lorenzo Cacaotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1234, 20, 228, N'San Lorenzo Cuaunecuiltitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1235, 20, 229, N'San Lorenzo Texmelúcan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1236, 20, 230, N'San Lorenzo Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1237, 20, 231, N'San Lucas Camotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1238, 20, 232, N'San Lucas Ojitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1239, 20, 233, N'San Lucas Quiaviní')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1240, 20, 234, N'San Lucas Zoquiápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1241, 20, 235, N'San Luis Amatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1242, 20, 236, N'San Marcial Ozolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1243, 20, 237, N'San Marcos Arteaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1244, 20, 238, N'San Martín de los Cansecos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1245, 20, 239, N'San Martín Huamelúlpam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1246, 20, 240, N'San Martín Itunyoso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1247, 20, 241, N'San Martín Lachilá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1248, 20, 242, N'San Martín Peras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1249, 20, 243, N'San Martín Tilcajete')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1250, 20, 244, N'San Martín Toxpalan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1251, 20, 245, N'San Martín Zacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1252, 20, 246, N'San Mateo Cajonos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1253, 20, 248, N'San Mateo del Mar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1254, 20, 250, N'San Mateo Etlatongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1255, 20, 251, N'San Mateo Nejápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1256, 20, 252, N'San Mateo Peñasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1257, 20, 253, N'San Mateo Piñas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1258, 20, 254, N'San Mateo Río Hondo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1259, 20, 255, N'San Mateo Sindihui')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1260, 20, 256, N'San Mateo Tlapiltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1261, 20, 249, N'San Mateo Yoloxochitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1262, 20, 566, N'San Mateo Yucutindoo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1263, 20, 257, N'San Melchor Betaza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1264, 20, 258, N'San Miguel Achiutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1265, 20, 259, N'San Miguel Ahuehuetitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1266, 20, 260, N'San Miguel Aloápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1267, 20, 261, N'San Miguel Amatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1268, 20, 262, N'San Miguel Amatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1269, 20, 264, N'San Miguel Chicahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1270, 20, 265, N'San Miguel Chimalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1271, 20, 263, N'San Miguel Coatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1272, 20, 266, N'San Miguel del Puerto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1273, 20, 267, N'San Miguel del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1274, 20, 268, N'San Miguel Ejutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1275, 20, 269, N'San Miguel el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1276, 20, 270, N'San Miguel Huautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1277, 20, 271, N'San Miguel Mixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1278, 20, 272, N'San Miguel Panixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1279, 20, 273, N'San Miguel Peras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1280, 20, 274, N'San Miguel Piedras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1281, 20, 275, N'San Miguel Quetzaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1282, 20, 276, N'San Miguel Santa Flor')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1283, 20, 278, N'San Miguel Soyaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1284, 20, 279, N'San Miguel Suchixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1285, 20, 281, N'San Miguel Tecomatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1286, 20, 282, N'San Miguel Tenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1287, 20, 283, N'San Miguel Tequixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1288, 20, 284, N'San Miguel Tilquiápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1289, 20, 285, N'San Miguel Tlacamama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1290, 20, 286, N'San Miguel Tlacotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1291, 20, 287, N'San Miguel Tulancingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1292, 20, 288, N'San Miguel Yotao')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1293, 20, 289, N'San Nicolás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1294, 20, 290, N'San Nicolás Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1295, 20, 291, N'San Pablo Coatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1296, 20, 292, N'San Pablo Cuatro Venados')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1297, 20, 293, N'San Pablo Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1298, 20, 294, N'San Pablo Huitzo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1299, 20, 295, N'San Pablo Huixtepec')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1300, 20, 296, N'San Pablo Macuiltianguis')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1301, 20, 297, N'San Pablo Tijaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1302, 20, 298, N'San Pablo Villa de Mitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1303, 20, 299, N'San Pablo Yaganiza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1304, 20, 300, N'San Pedro Amuzgos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1305, 20, 301, N'San Pedro Apóstol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1306, 20, 302, N'San Pedro Atoyac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1307, 20, 303, N'San Pedro Cajonos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1308, 20, 305, N'San Pedro Comitancillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1309, 20, 304, N'San Pedro Coxcaltepec Cántaros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1310, 20, 306, N'San Pedro el Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1311, 20, 307, N'San Pedro Huamelula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1312, 20, 308, N'San Pedro Huilotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1313, 20, 309, N'San Pedro Ixcatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1314, 20, 310, N'San Pedro Ixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1315, 20, 311, N'San Pedro Jaltepetongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1316, 20, 312, N'San Pedro Jicayán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1317, 20, 313, N'San Pedro Jocotipac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1318, 20, 314, N'San Pedro Juchatengo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1319, 20, 315, N'San Pedro Mártir')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1320, 20, 316, N'San Pedro Mártir Quiechapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1321, 20, 317, N'San Pedro Mártir Yucuxaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1322, 20, 318, N'San Pedro Mixtepec -Dto. 22 -')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1323, 20, 319, N'San Pedro Mixtepec -Dto. 26 -')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1324, 20, 320, N'San Pedro Molinos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1325, 20, 321, N'San Pedro Nopala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1326, 20, 322, N'San Pedro Ocopetatillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1327, 20, 323, N'San Pedro Ocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1328, 20, 324, N'San Pedro Pochutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1329, 20, 325, N'San Pedro Quiatoni')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1330, 20, 326, N'San Pedro Sochiápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1331, 20, 327, N'San Pedro Tapanatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1332, 20, 328, N'San Pedro Taviche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1333, 20, 329, N'San Pedro Teozacoalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1334, 20, 330, N'San Pedro Teutila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1335, 20, 331, N'San Pedro Tidaá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1336, 20, 332, N'San Pedro Topiltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1337, 20, 333, N'San Pedro Totolápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1338, 20, 337, N'San Pedro y San Pablo Ayutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1339, 20, 339, N'San Pedro y San Pablo Teposcolula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1340, 20, 340, N'San Pedro y San Pablo Tequixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1341, 20, 335, N'San Pedro Yaneri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1342, 20, 336, N'San Pedro Yólox')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1343, 20, 341, N'San Pedro Yucunama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1344, 20, 342, N'San Raymundo Jalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1345, 20, 343, N'San Sebastián Abasolo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1346, 20, 344, N'San Sebastián Coatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1347, 20, 345, N'San Sebastián Ixcapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1348, 20, 346, N'San Sebastián Nicananduta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1349, 20, 347, N'San Sebastián Río Hondo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1350, 20, 348, N'San Sebastián Tecomaxtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1351, 20, 349, N'San Sebastián Teitipac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1352, 20, 350, N'San Sebastián Tutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1353, 20, 351, N'San Simón Almolongas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1354, 20, 352, N'San Simón Zahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1355, 20, 534, N'San Vicente Coatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1356, 20, 535, N'San Vicente Lachixío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1357, 20, 536, N'San Vicente Nuñú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1358, 20, 353, N'Santa Ana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1359, 20, 354, N'Santa Ana Ateixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1360, 20, 355, N'Santa Ana Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1361, 20, 356, N'Santa Ana del Valle')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1362, 20, 357, N'Santa Ana Tavela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1363, 20, 358, N'Santa Ana Tlapacoyan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1364, 20, 359, N'Santa Ana Yareni')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1365, 20, 360, N'Santa Ana Zegache')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1366, 20, 361, N'Santa Catalina Quierí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1367, 20, 362, N'Santa Catarina Cuixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1368, 20, 363, N'Santa Catarina Ixtepeji')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1369, 20, 364, N'Santa Catarina Juquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1370, 20, 365, N'Santa Catarina Lachatao')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1371, 20, 366, N'Santa Catarina Loxicha')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1372, 20, 367, N'Santa Catarina Mechoacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1373, 20, 368, N'Santa Catarina Minas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1374, 20, 369, N'Santa Catarina Quiané')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1375, 20, 74, N'Santa Catarina Quioquitani')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1376, 20, 370, N'Santa Catarina Tayata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1377, 20, 371, N'Santa Catarina Ticuá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1378, 20, 372, N'Santa Catarina Yosonotú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1379, 20, 373, N'Santa Catarina Zapoquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1380, 20, 374, N'Santa Cruz Acatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1381, 20, 375, N'Santa Cruz Amilpas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1382, 20, 376, N'Santa Cruz de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1383, 20, 377, N'Santa Cruz Itundujia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1384, 20, 378, N'Santa Cruz Mixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1385, 20, 379, N'Santa Cruz Nundaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1386, 20, 380, N'Santa Cruz Papalutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1387, 20, 381, N'Santa Cruz Tacache de Mina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1388, 20, 382, N'Santa Cruz Tacahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1389, 20, 383, N'Santa Cruz Tayata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1390, 20, 384, N'Santa Cruz Xitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1391, 20, 385, N'Santa Cruz Xoxocotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1392, 20, 386, N'Santa Cruz Zenzontepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1393, 20, 387, N'Santa Gertrudis')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1394, 20, 569, N'Santa Inés de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1395, 20, 388, N'Santa Inés del Monte')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1396, 20, 389, N'Santa Inés Yatzeche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1397, 20, 390, N'Santa Lucía del Camino')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1398, 20, 391, N'Santa Lucía Miahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1399, 20, 392, N'Santa Lucía Monteverde')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1400, 20, 393, N'Santa Lucía Ocotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1401, 20, 47, N'Santa Magdalena Jicotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1402, 20, 394, N'Santa María Alotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1403, 20, 395, N'Santa María Apazco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1404, 20, 399, N'Santa María Atzompa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1405, 20, 400, N'Santa María Camotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1406, 20, 404, N'Santa María Chachoápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1407, 20, 406, N'Santa María Chilchotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1408, 20, 407, N'Santa María Chimalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1409, 20, 401, N'Santa María Colotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1410, 20, 402, N'Santa María Cortijo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1411, 20, 403, N'Santa María Coyotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1412, 20, 408, N'Santa María del Rosario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1413, 20, 409, N'Santa María del Tule')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1414, 20, 410, N'Santa María Ecatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1415, 20, 411, N'Santa María Guelacé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1416, 20, 412, N'Santa María Guienagati')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1417, 20, 413, N'Santa María Huatulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1418, 20, 414, N'Santa María Huazolotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1419, 20, 415, N'Santa María Ipalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1420, 20, 416, N'Santa María Ixcatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1421, 20, 417, N'Santa María Jacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1422, 20, 418, N'Santa María Jalapa del Marqués')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1423, 20, 419, N'Santa María Jaltianguis')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1424, 20, 396, N'Santa María la Asunción')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1425, 20, 420, N'Santa María Lachixío')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1426, 20, 421, N'Santa María Mixtequilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1427, 20, 422, N'Santa María Nativitas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1428, 20, 423, N'Santa María Nduayaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1429, 20, 424, N'Santa María Ozolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1430, 20, 425, N'Santa María Pápalo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1431, 20, 426, N'Santa María Peñoles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1432, 20, 427, N'Santa María Petapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1433, 20, 428, N'Santa María Quiegolani')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1434, 20, 429, N'Santa María Sola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1435, 20, 430, N'Santa María Tataltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1436, 20, 431, N'Santa María Tecomavaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1437, 20, 432, N'Santa María Temaxcalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1438, 20, 433, N'Santa María Temaxcaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1439, 20, 434, N'Santa María Teopoxco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1440, 20, 435, N'Santa María Tepantlali')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1441, 20, 436, N'Santa María Texcatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1442, 20, 437, N'Santa María Tlahuitoltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1443, 20, 438, N'Santa María Tlalixtac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1444, 20, 439, N'Santa María Tonameca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1445, 20, 440, N'Santa María Totolapilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1446, 20, 441, N'Santa María Xadani')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1447, 20, 442, N'Santa María Yalina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1448, 20, 443, N'Santa María Yavesía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1449, 20, 444, N'Santa María Yolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1450, 20, 445, N'Santa María Yosoyúa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1451, 20, 446, N'Santa María Yucuhiti')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1452, 20, 447, N'Santa María Zacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1453, 20, 448, N'Santa María Zaniza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1454, 20, 449, N'Santa María Zoquitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1455, 20, 450, N'Santiago Amoltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1456, 20, 451, N'Santiago Apoala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1457, 20, 452, N'Santiago Apóstol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1458, 20, 453, N'Santiago Astata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1459, 20, 454, N'Santiago Atitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1460, 20, 455, N'Santiago Ayuquililla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1461, 20, 456, N'Santiago Cacaloxtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1462, 20, 457, N'Santiago Camotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1463, 20, 459, N'Santiago Chazumba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1464, 20, 460, N'Santiago Choápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1465, 20, 458, N'Santiago Comaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1466, 20, 461, N'Santiago del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1467, 20, 462, N'Santiago Huajolotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1468, 20, 463, N'Santiago Huauclilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1469, 20, 464, N'Santiago Ihuitlán Plumas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1470, 20, 465, N'Santiago Ixcuintepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1471, 20, 466, N'Santiago Ixtayutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1472, 20, 467, N'Santiago Jamiltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1473, 20, 468, N'Santiago Jocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1474, 20, 469, N'Santiago Juxtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1475, 20, 470, N'Santiago Lachiguiri')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1476, 20, 471, N'Santiago Lalopa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1477, 20, 472, N'Santiago Laollaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1478, 20, 473, N'Santiago Laxopa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1479, 20, 474, N'Santiago Llano Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1480, 20, 475, N'Santiago Matatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1481, 20, 476, N'Santiago Miltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1482, 20, 477, N'Santiago Minas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1483, 20, 478, N'Santiago Nacaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1484, 20, 479, N'Santiago Nejapilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1485, 20, 66, N'Santiago Niltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1486, 20, 480, N'Santiago Nundiche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1487, 20, 481, N'Santiago Nuyoó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1488, 20, 482, N'Santiago Pinotepa Nacional')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1489, 20, 483, N'Santiago Suchilquitongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1490, 20, 484, N'Santiago Tamazola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1491, 20, 485, N'Santiago Tapextla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1492, 20, 487, N'Santiago Tenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1493, 20, 488, N'Santiago Tepetlapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1494, 20, 489, N'Santiago Tetepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1495, 20, 490, N'Santiago Texcalcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1496, 20, 491, N'Santiago Textitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1497, 20, 492, N'Santiago Tilantongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1498, 20, 493, N'Santiago Tillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1499, 20, 494, N'Santiago Tlazoyaltepec')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1500, 20, 495, N'Santiago Xanica')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1501, 20, 496, N'Santiago Xiacuí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1502, 20, 497, N'Santiago Yaitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1503, 20, 498, N'Santiago Yaveo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1504, 20, 499, N'Santiago Yolomécatl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1505, 20, 500, N'Santiago Yosondúa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1506, 20, 501, N'Santiago Yucuyachi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1507, 20, 502, N'Santiago Zacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1508, 20, 503, N'Santiago Zoochila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1509, 20, 506, N'Santo Domingo Albarradas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1510, 20, 507, N'Santo Domingo Armenta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1511, 20, 508, N'Santo Domingo Chihuitán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1512, 20, 509, N'Santo Domingo de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1513, 20, 505, N'Santo Domingo Ingenio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1514, 20, 510, N'Santo Domingo Ixcatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1515, 20, 511, N'Santo Domingo Nuxaá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1516, 20, 512, N'Santo Domingo Ozolotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1517, 20, 513, N'Santo Domingo Petapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1518, 20, 514, N'Santo Domingo Roayaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1519, 20, 515, N'Santo Domingo Tehuantepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1520, 20, 516, N'Santo Domingo Teojomulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1521, 20, 517, N'Santo Domingo Tepuxtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1522, 20, 518, N'Santo Domingo Tlatayápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1523, 20, 519, N'Santo Domingo Tomaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1524, 20, 520, N'Santo Domingo Tonalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1525, 20, 521, N'Santo Domingo Tonaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1526, 20, 522, N'Santo Domingo Xagacía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1527, 20, 523, N'Santo Domingo Yanhuitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1528, 20, 524, N'Santo Domingo Yodohino')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1529, 20, 525, N'Santo Domingo Zanatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1530, 20, 530, N'Santo Tomás Jalieza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1531, 20, 531, N'Santo Tomás Mazaltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1532, 20, 532, N'Santo Tomás Ocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1533, 20, 533, N'Santo Tomás Tamazulapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1534, 20, 526, N'Santos Reyes Nopala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1535, 20, 527, N'Santos Reyes Pápalo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1536, 20, 528, N'Santos Reyes Tepejillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1537, 20, 529, N'Santos Reyes Yucuná')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1538, 20, 537, N'Silacayoápam')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1539, 20, 538, N'Sitio de Xitlapehua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1540, 20, 539, N'Soledad Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1541, 20, 31, N'Tamazulápam del Espíritu Santo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1542, 20, 541, N'Tanetze de Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1543, 20, 542, N'Taniche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1544, 20, 543, N'Tataltepec de Valdés')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1545, 20, 544, N'Teococuilco de Marcos Pérez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1546, 20, 545, N'Teotitlán de Flores Magón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1547, 20, 546, N'Teotitlán del Valle')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1548, 20, 547, N'Teotongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1549, 20, 548, N'Tepelmeme Villa de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1550, 20, 549, N'Tezoatlán de Segura y Luna')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1551, 20, 551, N'Tlacolula de Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1552, 20, 552, N'Tlacotepec Plumas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1553, 20, 553, N'Tlalixtac de Cabrera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1554, 20, 554, N'Totontepec Villa de Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1555, 20, 555, N'Trinidad Zaachila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1556, 20, 557, N'Unión Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1557, 20, 558, N'Valerio Trujano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1558, 20, 405, N'Villa de Chilapa de Díaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1559, 20, 338, N'Villa de Etla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1560, 20, 540, N'Villa de Tamazulápam del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1561, 20, 334, N'Villa de Tututepec de Melchor Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1562, 20, 565, N'Villa de Zaachila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1563, 20, 560, N'Villa Díaz Ordaz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1564, 20, 38, N'Villa Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1565, 20, 277, N'Villa Sola de Vega')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1566, 20, 280, N'Villa Talea de Castro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1567, 20, 486, N'Villa Tejúpam de la Unión')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1568, 20, 561, N'Yaxe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1569, 20, 563, N'Yogana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1570, 20, 564, N'Yutanduchi de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1571, 20, 567, N'Zapotitlán Lagunas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1572, 20, 568, N'Zapotitlán Palmas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1573, 20, 570, N'Zimatlán de Álvarez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1574, 21, 1, N'Acajete')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1575, 21, 2, N'Acateno')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1576, 21, 3, N'Acatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1577, 21, 4, N'Acatzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1578, 21, 5, N'Acteopan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1579, 21, 6, N'Ahuacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1580, 21, 7, N'Ahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1581, 21, 8, N'Ahuazotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1582, 21, 9, N'Ahuehuetitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1583, 21, 10, N'Ajalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1584, 21, 11, N'Albino Zertuche')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1585, 21, 12, N'Aljojuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1586, 21, 13, N'Altepexi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1587, 21, 14, N'Amixtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1588, 21, 15, N'Amozoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1589, 21, 16, N'Aquixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1590, 21, 17, N'Atempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1591, 21, 18, N'Atexcal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1592, 21, 80, N'Atlequizayan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1593, 21, 19, N'Atlixco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1594, 21, 20, N'Atoyatempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1595, 21, 21, N'Atzala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1596, 21, 22, N'Atzitzihuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1597, 21, 23, N'Atzitzintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1598, 21, 24, N'Axutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1599, 21, 25, N'Ayotoxco de Guerrero')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1600, 21, 26, N'Calpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1601, 21, 27, N'Caltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1602, 21, 28, N'Camocuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1603, 21, 99, N'Cañada Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1604, 21, 29, N'Caxhuacan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1605, 21, 45, N'Chalchicomula de Sesma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1606, 21, 46, N'Chapulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1607, 21, 47, N'Chiautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1608, 21, 48, N'Chiautzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1609, 21, 50, N'Chichiquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1610, 21, 49, N'Chiconcuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1611, 21, 51, N'Chietla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1612, 21, 52, N'Chigmecatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1613, 21, 53, N'Chignahuapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1614, 21, 54, N'Chignautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1615, 21, 55, N'Chila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1616, 21, 56, N'Chila de la Sal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1617, 21, 58, N'Chilchotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1618, 21, 59, N'Chinantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1619, 21, 30, N'Coatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1620, 21, 31, N'Coatzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1621, 21, 32, N'Cohetzala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1622, 21, 33, N'Cohuecan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1623, 21, 34, N'Coronango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1624, 21, 35, N'Coxcatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1625, 21, 36, N'Coyomeapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1626, 21, 37, N'Coyotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1627, 21, 38, N'Cuapiaxtla de Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1628, 21, 39, N'Cuautempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1629, 21, 40, N'Cuautinchán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1630, 21, 41, N'Cuautlancingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1631, 21, 42, N'Cuayuca de Andrade')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1632, 21, 43, N'Cuetzalan del Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1633, 21, 44, N'Cuyoaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1634, 21, 60, N'Domingo Arenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1635, 21, 61, N'Eloxochitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1636, 21, 62, N'Epatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1637, 21, 63, N'Esperanza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1638, 21, 64, N'Francisco Z. Mena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1639, 21, 65, N'General Felipe Ángeles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1640, 21, 66, N'Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1641, 21, 67, N'Guadalupe Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1642, 21, 68, N'Hermenegildo Galeana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1643, 21, 57, N'Honey')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1644, 21, 69, N'Huaquechula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1645, 21, 70, N'Huatlatlauca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1646, 21, 71, N'Huauchinango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1647, 21, 72, N'Huehuetla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1648, 21, 73, N'Huehuetlán el Chico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1649, 21, 150, N'Huehuetlán el Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1650, 21, 74, N'Huejotzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1651, 21, 75, N'Hueyapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1652, 21, 76, N'Hueytamalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1653, 21, 77, N'Hueytlalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1654, 21, 78, N'Huitzilan de Serdán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1655, 21, 79, N'Huitziltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1656, 21, 81, N'Ixcamilpa de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1657, 21, 82, N'Ixcaquixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1658, 21, 83, N'Ixtacamaxtitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1659, 21, 84, N'Ixtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1660, 21, 85, N'Izúcar de Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1661, 21, 86, N'Jalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1662, 21, 87, N'Jolalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1663, 21, 88, N'Jonotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1664, 21, 89, N'Jopala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1665, 21, 90, N'Juan C. Bonilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1666, 21, 91, N'Juan Galindo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1667, 21, 92, N'Juan N. Méndez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1668, 21, 95, N'La Magdalena Tlatlauquitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1669, 21, 93, N'Lafragua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1670, 21, 94, N'Libres')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1671, 21, 118, N'Los Reyes de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1672, 21, 96, N'Mazapiltepec de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1673, 21, 97, N'Mixtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1674, 21, 98, N'Molcaxac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1675, 21, 100, N'Naupan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1676, 21, 101, N'Nauzontla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1677, 21, 102, N'Nealtican')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1678, 21, 103, N'Nicolás Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1679, 21, 104, N'Nopalucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1680, 21, 105, N'Ocotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1681, 21, 106, N'Ocoyucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1682, 21, 107, N'Olintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1683, 21, 108, N'Oriental')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1684, 21, 109, N'Pahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1685, 21, 110, N'Palmar de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1686, 21, 111, N'Pantepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1687, 21, 112, N'Petlalcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1688, 21, 113, N'Piaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1689, 21, 114, N'Puebla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1690, 21, 115, N'Quecholac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1691, 21, 116, N'Quimixtlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1692, 21, 117, N'Rafael Lara Grajales')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1693, 21, 119, N'San Andrés Cholula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1694, 21, 120, N'San Antonio Cañada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1695, 21, 121, N'San Diego la Mesa Tochimiltzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1696, 21, 122, N'San Felipe Teotlalcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1697, 21, 123, N'San Felipe Tepatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1698, 21, 124, N'San Gabriel Chilac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1699, 21, 125, N'San Gregorio Atzompa')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1700, 21, 126, N'San Jerónimo Tecuanipan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1701, 21, 127, N'San Jerónimo Xayacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1702, 21, 128, N'San José Chiapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1703, 21, 129, N'San José Miahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1704, 21, 130, N'San Juan Atenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1705, 21, 131, N'San Juan Atzompa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1706, 21, 132, N'San Martín Texmelucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1707, 21, 133, N'San Martín Totoltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1708, 21, 134, N'San Matías Tlalancaleca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1709, 21, 135, N'San Miguel Ixitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1710, 21, 136, N'San Miguel Xoxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1711, 21, 137, N'San Nicolás Buenos Aires')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1712, 21, 138, N'San Nicolás de los Ranchos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1713, 21, 139, N'San Pablo Anicano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1714, 21, 140, N'San Pedro Cholula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1715, 21, 141, N'San Pedro Yeloixtlahuaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1716, 21, 142, N'San Salvador el Seco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1717, 21, 143, N'San Salvador el Verde')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1718, 21, 144, N'San Salvador Huixcolotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1719, 21, 145, N'San Sebastián Tlacotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1720, 21, 146, N'Santa Catarina Tlaltempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1721, 21, 147, N'Santa Inés Ahuatempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1722, 21, 148, N'Santa Isabel Cholula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1723, 21, 149, N'Santiago Miahuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1724, 21, 151, N'Santo Tomás Hueyotlipan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1725, 21, 152, N'Soltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1726, 21, 153, N'Tecali de Herrera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1727, 21, 154, N'Tecamachalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1728, 21, 155, N'Tecomatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1729, 21, 156, N'Tehuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1730, 21, 157, N'Tehuitzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1731, 21, 158, N'Tenampulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1732, 21, 159, N'Teopantlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1733, 21, 160, N'Teotlalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1734, 21, 161, N'Tepanco de López')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1735, 21, 162, N'Tepango de Rodríguez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1736, 21, 163, N'Tepatlaxco de Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1737, 21, 164, N'Tepeaca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1738, 21, 165, N'Tepemaxalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1739, 21, 166, N'Tepeojuma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1740, 21, 167, N'Tepetzintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1741, 21, 168, N'Tepexco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1742, 21, 169, N'Tepexi de Rodríguez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1743, 21, 170, N'Tepeyahualco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1744, 21, 171, N'Tepeyahualco de Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1745, 21, 172, N'Tetela de Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1746, 21, 173, N'Teteles de Avila Castillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1747, 21, 174, N'Teziutlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1748, 21, 175, N'Tianguismanalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1749, 21, 176, N'Tilapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1750, 21, 179, N'Tlachichuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1751, 21, 177, N'Tlacotepec de Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1752, 21, 178, N'Tlacuilotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1753, 21, 180, N'Tlahuapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1754, 21, 181, N'Tlaltenango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1755, 21, 182, N'Tlanepantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1756, 21, 183, N'Tlaola')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1757, 21, 184, N'Tlapacoya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1758, 21, 185, N'Tlapanalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1759, 21, 186, N'Tlatlauquitepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1760, 21, 187, N'Tlaxco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1761, 21, 188, N'Tochimilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1762, 21, 189, N'Tochtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1763, 21, 190, N'Totoltepec de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1764, 21, 191, N'Tulcingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1765, 21, 192, N'Tuzamapan de Galeana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1766, 21, 193, N'Tzicatlacoyan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1767, 21, 194, N'Venustiano Carranza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1768, 21, 195, N'Vicente Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1769, 21, 196, N'Xayacatlán de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1770, 21, 197, N'Xicotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1771, 21, 198, N'Xicotlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1772, 21, 199, N'Xiutetelco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1773, 21, 200, N'Xochiapulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1774, 21, 201, N'Xochiltepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1775, 21, 202, N'Xochitlán de Vicente Suárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1776, 21, 203, N'Xochitlán Todos Santos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1777, 21, 204, N'Yaonáhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1778, 21, 205, N'Yehualtepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1779, 21, 206, N'Zacapala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1780, 21, 207, N'Zacapoaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1781, 21, 208, N'Zacatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1782, 21, 209, N'Zapotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1783, 21, 210, N'Zapotitlán de Méndez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1784, 21, 211, N'Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1785, 21, 212, N'Zautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1786, 21, 213, N'Zihuateutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1787, 21, 214, N'Zinacatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1788, 21, 215, N'Zongozotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1789, 21, 216, N'Zoquiapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1790, 21, 217, N'Zoquitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1791, 22, 1, N'Amealco de Bonfil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1792, 22, 3, N'Arroyo Seco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1793, 22, 4, N'Cadereyta de Montes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1794, 22, 5, N'Colón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1795, 22, 6, N'Corregidora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1796, 22, 11, N'El Marqués')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1797, 22, 7, N'Ezequiel Montes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1798, 22, 8, N'Huimilpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1799, 22, 9, N'Jalpan de Serra')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1800, 22, 10, N'Landa de Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1801, 22, 12, N'Pedro Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1802, 22, 13, N'Peñamiller')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1803, 22, 2, N'Pinal de Amoles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1804, 22, 14, N'Querétaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1805, 22, 15, N'San Joaquín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1806, 22, 16, N'San Juan del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1807, 22, 17, N'Tequisquiapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1808, 22, 18, N'Tolimán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1809, 23, 10, N'Bacalar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1810, 23, 5, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1811, 23, 1, N'Cozumel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1812, 23, 2, N'Felipe Carrillo Puerto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1813, 23, 3, N'Isla Mujeres')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1814, 23, 6, N'José María Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1815, 23, 7, N'Lázaro Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1816, 23, 4, N'Othón P. Blanco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1817, 23, 11, N'Puerto Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1818, 23, 8, N'Solidaridad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1819, 23, 9, N'Tulum')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1820, 24, 1, N'Ahualulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1821, 24, 2, N'Alaquines')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1822, 24, 3, N'Aquismón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1823, 24, 4, N'Armadillo de los Infante')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1824, 24, 53, N'Axtla de Terrazas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1825, 24, 5, N'Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1826, 24, 6, N'Catorce')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1827, 24, 7, N'Cedral')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1828, 24, 8, N'Cerritos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1829, 24, 9, N'Cerro de San Pedro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1830, 24, 15, N'Charcas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1831, 24, 10, N'Ciudad del Maíz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1832, 24, 11, N'Ciudad Fernández')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1833, 24, 13, N'Ciudad Valles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1834, 24, 14, N'Coxcatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1835, 24, 16, N'Ebano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1836, 24, 58, N'El Naranjo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1837, 24, 17, N'Guadalcázar')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1838, 24, 18, N'Huehuetlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1839, 24, 19, N'Lagunillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1840, 24, 20, N'Matehuala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1841, 24, 57, N'Matlapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1842, 24, 21, N'Mexquitic de Carmona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1843, 24, 22, N'Moctezuma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1844, 24, 23, N'Rayón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1845, 24, 24, N'Rioverde')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1846, 24, 25, N'Salinas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1847, 24, 26, N'San Antonio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1848, 24, 27, N'San Ciro de Acosta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1849, 24, 28, N'San Luis Potosí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1850, 24, 29, N'San Martín Chalchicuautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1851, 24, 30, N'San Nicolás Tolentino')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1852, 24, 34, N'San Vicente Tancuayalab')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1853, 24, 31, N'Santa Catarina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1854, 24, 32, N'Santa María del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1855, 24, 33, N'Santo Domingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1856, 24, 35, N'Soledad de Graciano Sánchez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1857, 24, 36, N'Tamasopo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1858, 24, 37, N'Tamazunchale')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1859, 24, 38, N'Tampacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1860, 24, 39, N'Tampamolón Corona')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1861, 24, 40, N'Tamuín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1862, 24, 12, N'Tancanhuitz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1863, 24, 41, N'Tanlajás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1864, 24, 42, N'Tanquián de Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1865, 24, 43, N'Tierra Nueva')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1866, 24, 44, N'Vanegas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1867, 24, 45, N'Venado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1868, 24, 56, N'Villa de Arista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1869, 24, 46, N'Villa de Arriaga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1870, 24, 47, N'Villa de Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1871, 24, 48, N'Villa de la Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1872, 24, 49, N'Villa de Ramos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1873, 24, 50, N'Villa de Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1874, 24, 51, N'Villa Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1875, 24, 52, N'Villa Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1876, 24, 54, N'Xilitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1877, 24, 55, N'Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1878, 25, 1, N'Ahome')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1879, 25, 2, N'Angostura')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1880, 25, 3, N'Badiraguato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1881, 25, 7, N'Choix')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1882, 25, 4, N'Concordia')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1883, 25, 5, N'Cosalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1884, 25, 6, N'Culiacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1885, 25, 10, N'El Fuerte')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1886, 25, 8, N'Elota')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1887, 25, 9, N'Escuinapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1888, 25, 11, N'Guasave')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1889, 25, 12, N'Mazatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1890, 25, 13, N'Mocorito')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1891, 25, 18, N'Navolato')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1892, 25, 14, N'Rosario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1893, 25, 15, N'Salvador Alvarado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1894, 25, 16, N'San Ignacio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1895, 25, 17, N'Sinaloa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1896, 26, 1, N'Aconchi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1897, 26, 2, N'Agua Prieta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1898, 26, 3, N'Alamos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1899, 26, 4, N'Altar')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1900, 26, 5, N'Arivechi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1901, 26, 6, N'Arizpe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1902, 26, 7, N'Atil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1903, 26, 8, N'Bacadéhuachi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1904, 26, 9, N'Bacanora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1905, 26, 10, N'Bacerac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1906, 26, 11, N'Bacoachi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1907, 26, 12, N'Bácum')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1908, 26, 13, N'Banámichi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1909, 26, 14, N'Baviácora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1910, 26, 15, N'Bavispe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1911, 26, 71, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1912, 26, 16, N'Benjamín Hill')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1913, 26, 17, N'Caborca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1914, 26, 18, N'Cajeme')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1915, 26, 19, N'Cananea')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1916, 26, 20, N'Carbó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1917, 26, 22, N'Cucurpe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1918, 26, 23, N'Cumpas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1919, 26, 24, N'Divisaderos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1920, 26, 25, N'Empalme')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1921, 26, 26, N'Etchojoa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1922, 26, 27, N'Fronteras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1923, 26, 70, N'General Plutarco Elías Calles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1924, 26, 28, N'Granados')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1925, 26, 29, N'Guaymas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1926, 26, 30, N'Hermosillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1927, 26, 31, N'Huachinera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1928, 26, 32, N'Huásabas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1929, 26, 33, N'Huatabampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1930, 26, 34, N'Huépac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1931, 26, 35, N'Imuris')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1932, 26, 21, N'La Colorada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1933, 26, 36, N'Magdalena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1934, 26, 37, N'Mazatán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1935, 26, 38, N'Moctezuma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1936, 26, 39, N'Naco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1937, 26, 40, N'Nácori Chico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1938, 26, 41, N'Nacozari de García')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1939, 26, 42, N'Navojoa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1940, 26, 43, N'Nogales')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1941, 26, 44, N'Onavas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1942, 26, 45, N'Opodepe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1943, 26, 46, N'Oquitoa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1944, 26, 47, N'Pitiquito')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1945, 26, 48, N'Puerto Peñasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1946, 26, 49, N'Quiriego')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1947, 26, 50, N'Rayón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1948, 26, 51, N'Rosario')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1949, 26, 52, N'Sahuaripa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1950, 26, 53, N'San Felipe de Jesús')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1951, 26, 72, N'San Ignacio Río Muerto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1952, 26, 54, N'San Javier')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1953, 26, 55, N'San Luis Río Colorado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1954, 26, 56, N'San Miguel de Horcasitas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1955, 26, 57, N'San Pedro de la Cueva')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1956, 26, 58, N'Santa Ana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1957, 26, 59, N'Santa Cruz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1958, 26, 60, N'Sáric')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1959, 26, 61, N'Soyopa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1960, 26, 62, N'Suaqui Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1961, 26, 63, N'Tepache')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1962, 26, 64, N'Trincheras')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1963, 26, 65, N'Tubutama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1964, 26, 66, N'Ures')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1965, 26, 67, N'Villa Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1966, 26, 68, N'Villa Pesqueira')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1967, 26, 69, N'Yécora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1968, 27, 1, N'Balancán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1969, 27, 2, N'Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1970, 27, 3, N'Centla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1971, 27, 4, N'Centro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1972, 27, 5, N'Comalcalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1973, 27, 6, N'Cunduacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1974, 27, 7, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1975, 27, 8, N'Huimanguillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1976, 27, 9, N'Jalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1977, 27, 10, N'Jalpa de Méndez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1978, 27, 11, N'Jonuta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1979, 27, 12, N'Macuspana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1980, 27, 13, N'Nacajuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1981, 27, 14, N'Paraíso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1982, 27, 15, N'Tacotalpa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1983, 27, 16, N'Teapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1984, 27, 17, N'Tenosique')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1985, 28, 1, N'Abasolo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1986, 28, 2, N'Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1987, 28, 3, N'Altamira')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1988, 28, 4, N'Antiguo Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1989, 28, 5, N'Burgos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1990, 28, 6, N'Bustamante')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1991, 28, 7, N'Camargo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1992, 28, 8, N'Casas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1993, 28, 9, N'Ciudad Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1994, 28, 10, N'Cruillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1995, 28, 21, N'El Mante')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1996, 28, 11, N'Gómez Farías')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1997, 28, 12, N'González')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1998, 28, 14, N'Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (1999, 28, 15, N'Gustavo Díaz Ordaz')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2000, 28, 13, N'Güémez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2001, 28, 16, N'Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2002, 28, 17, N'Jaumave')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2003, 28, 18, N'Jiménez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2004, 28, 19, N'Llera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2005, 28, 20, N'Mainero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2006, 28, 22, N'Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2007, 28, 23, N'Méndez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2008, 28, 24, N'Mier')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2009, 28, 25, N'Miguel Alemán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2010, 28, 26, N'Miquihuana')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2011, 28, 27, N'Nuevo Laredo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2012, 28, 28, N'Nuevo Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2013, 28, 29, N'Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2014, 28, 30, N'Padilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2015, 28, 31, N'Palmillas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2016, 28, 32, N'Reynosa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2017, 28, 33, N'Río Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2018, 28, 34, N'San Carlos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2019, 28, 35, N'San Fernando')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2020, 28, 36, N'San Nicolás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2021, 28, 37, N'Soto la Marina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2022, 28, 38, N'Tampico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2023, 28, 39, N'Tula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2024, 28, 40, N'Valle Hermoso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2025, 28, 41, N'Victoria')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2026, 28, 42, N'Villagrán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2027, 28, 43, N'Xicoténcatl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2028, 29, 22, N'Acuamanala de Miguel Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2029, 29, 1, N'Amaxac de Guerrero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2030, 29, 2, N'Apetatitlán de Antonio Carvajal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2031, 29, 5, N'Apizaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2032, 29, 3, N'Atlangatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2033, 29, 4, N'Atltzayanca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2034, 29, 45, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2035, 29, 6, N'Calpulalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2036, 29, 10, N'Chiautempan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2037, 29, 18, N'Contla de Juan Cuamatzi')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2038, 29, 8, N'Cuapiaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2039, 29, 9, N'Cuaxomulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2040, 29, 7, N'El Carmen Tequexquitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2041, 29, 46, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2042, 29, 12, N'Españita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2043, 29, 13, N'Huamantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2044, 29, 14, N'Hueyotlipan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2045, 29, 15, N'Ixtacuixtla de Mariano Matamoros')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2046, 29, 16, N'Ixtenco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2047, 29, 48, N'La Magdalena Tlaltelulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2048, 29, 47, N'Lázaro Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2049, 29, 17, N'Mazatecochco de José María Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2050, 29, 11, N'Muñoz de Domingo Arenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2051, 29, 21, N'Nanacamilpa de Mariano Arista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2052, 29, 23, N'Natívitas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2053, 29, 24, N'Panotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2054, 29, 41, N'Papalotla de Xicohténcatl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2055, 29, 49, N'San Damián Texóloc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2056, 29, 50, N'San Francisco Tetlanohcan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2057, 29, 51, N'San Jerónimo Zacualpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2058, 29, 52, N'San José Teacalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2059, 29, 53, N'San Juan Huactzinco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2060, 29, 54, N'San Lorenzo Axocomanitla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2061, 29, 55, N'San Lucas Tecopilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2062, 29, 25, N'San Pablo del Monte')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2063, 29, 20, N'Sanctórum de Lázaro Cárdenas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2064, 29, 56, N'Santa Ana Nopalucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2065, 29, 57, N'Santa Apolonia Teacalco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2066, 29, 58, N'Santa Catarina Ayometla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2067, 29, 59, N'Santa Cruz Quilehtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2068, 29, 26, N'Santa Cruz Tlaxcala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2069, 29, 60, N'Santa Isabel Xiloxoxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2070, 29, 27, N'Tenancingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2071, 29, 28, N'Teolocholco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2072, 29, 19, N'Tepetitla de Lardizábal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2073, 29, 29, N'Tepeyanco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2074, 29, 30, N'Terrenate')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2075, 29, 31, N'Tetla de la Solidaridad')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2076, 29, 32, N'Tetlatlahuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2077, 29, 33, N'Tlaxcala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2078, 29, 34, N'Tlaxco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2079, 29, 35, N'Tocatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2080, 29, 36, N'Totolac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2081, 29, 38, N'Tzompantepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2082, 29, 39, N'Xaloztoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2083, 29, 40, N'Xaltocan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2084, 29, 42, N'Xicohtzinco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2085, 29, 43, N'Yauhquemehcan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2086, 29, 44, N'Zacatelco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2087, 29, 37, N'Ziltlaltépec de Trinidad Sánchez Santos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2088, 30, 1, N'Acajete')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2089, 30, 2, N'Acatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2090, 30, 3, N'Acayucan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2091, 30, 4, N'Actopan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2092, 30, 5, N'Acula')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2093, 30, 6, N'Acultzingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2094, 30, 204, N'Agua Dulce')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2095, 30, 160, N'Álamo Temapache')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2096, 30, 8, N'Alpatláhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2097, 30, 9, N'Alto Lucero de Gutiérrez Barrios')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2098, 30, 10, N'Altotonga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2099, 30, 11, N'Alvarado')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2100, 30, 12, N'Amatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2101, 30, 14, N'Amatlán de los Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2102, 30, 15, N'Angel R. Cabada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2103, 30, 17, N'Apazapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2104, 30, 18, N'Aquila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2105, 30, 19, N'Astacinga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2106, 30, 20, N'Atlahuilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2107, 30, 21, N'Atoyac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2108, 30, 22, N'Atzacan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2109, 30, 23, N'Atzalan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2110, 30, 25, N'Ayahualulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2111, 30, 26, N'Banderilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2112, 30, 27, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2113, 30, 28, N'Boca del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2114, 30, 29, N'Calcahualco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2115, 30, 7, N'Camarón de Tejeda')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2116, 30, 30, N'Camerino Z. Mendoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2117, 30, 208, N'Carlos A. Carrillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2118, 30, 31, N'Carrillo Puerto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2119, 30, 157, N'Castillo de Teayo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2120, 30, 32, N'Catemaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2121, 30, 33, N'Cazones de Herrera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2122, 30, 34, N'Cerro Azul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2123, 30, 54, N'Chacaltianguis')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2124, 30, 55, N'Chalma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2125, 30, 56, N'Chiconamel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2126, 30, 57, N'Chiconquiaco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2127, 30, 58, N'Chicontepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2128, 30, 59, N'Chinameca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2129, 30, 60, N'Chinampa de Gorostiza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2130, 30, 62, N'Chocamán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2131, 30, 63, N'Chontla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2132, 30, 64, N'Chumatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2133, 30, 35, N'Citlaltépetl')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2134, 30, 36, N'Coacoatzintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2135, 30, 37, N'Coahuitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2136, 30, 38, N'Coatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2137, 30, 39, N'Coatzacoalcos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2138, 30, 40, N'Coatzintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2139, 30, 41, N'Coetzala')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2140, 30, 42, N'Colipa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2141, 30, 43, N'Comapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2142, 30, 44, N'Córdoba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2143, 30, 45, N'Cosamaloapan de Carpio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2144, 30, 46, N'Cosautlán de Carvajal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2145, 30, 47, N'Coscomatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2146, 30, 48, N'Cosoleacaque')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2147, 30, 49, N'Cotaxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2148, 30, 50, N'Coxquihui')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2149, 30, 51, N'Coyutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2150, 30, 52, N'Cuichapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2151, 30, 53, N'Cuitláhuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2152, 30, 205, N'El Higo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2153, 30, 65, N'Emiliano Zapata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2154, 30, 66, N'Espinal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2155, 30, 67, N'Filomeno Mata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2156, 30, 68, N'Fortín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2157, 30, 69, N'Gutiérrez Zamora')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2158, 30, 70, N'Hidalgotitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2159, 30, 71, N'Huatusco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2160, 30, 72, N'Huayacocotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2161, 30, 73, N'Hueyapan de Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2162, 30, 74, N'Huiloapan de Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2163, 30, 75, N'Ignacio de la Llave')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2164, 30, 76, N'Ilamatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2165, 30, 77, N'Isla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2166, 30, 78, N'Ixcatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2167, 30, 79, N'Ixhuacán de los Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2168, 30, 83, N'Ixhuatlán de Madero')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2169, 30, 80, N'Ixhuatlán del Café')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2170, 30, 82, N'Ixhuatlán del Sureste')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2171, 30, 81, N'Ixhuatlancillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2172, 30, 84, N'Ixmatlahuacan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2173, 30, 85, N'Ixtaczoquitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2174, 30, 86, N'Jalacingo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2175, 30, 88, N'Jalcomulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2176, 30, 89, N'Jáltipan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2177, 30, 90, N'Jamapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2178, 30, 91, N'Jesús Carranza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2179, 30, 93, N'Jilotepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2180, 30, 169, N'José Azueta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2181, 30, 94, N'Juan Rodríguez Clara')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2182, 30, 95, N'Juchique de Ferrer')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2183, 30, 16, N'La Antigua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2184, 30, 127, N'La Perla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2185, 30, 96, N'Landero y Coss')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2186, 30, 61, N'Las Choapas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2187, 30, 107, N'Las Minas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2188, 30, 132, N'Las Vigas de Ramírez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2189, 30, 97, N'Lerdo de Tejada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2190, 30, 137, N'Los Reyes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2191, 30, 98, N'Magdalena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2192, 30, 99, N'Maltrata')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2193, 30, 100, N'Manlio Fabio Altamirano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2194, 30, 101, N'Mariano Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2195, 30, 102, N'Martínez de la Torre')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2196, 30, 103, N'Mecatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2197, 30, 104, N'Mecayapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2198, 30, 105, N'Medellín de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2199, 30, 106, N'Miahuatlán')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2200, 30, 108, N'Minatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2201, 30, 109, N'Misantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2202, 30, 110, N'Mixtla de Altamirano')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2203, 30, 111, N'Moloacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2204, 30, 206, N'Nanchital de Lázaro Cárdenas del Río')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2205, 30, 112, N'Naolinco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2206, 30, 113, N'Naranjal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2207, 30, 13, N'Naranjos Amatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2208, 30, 114, N'Nautla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2209, 30, 115, N'Nogales')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2210, 30, 116, N'Oluta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2211, 30, 117, N'Omealca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2212, 30, 118, N'Orizaba')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2213, 30, 119, N'Otatitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2214, 30, 120, N'Oteapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2215, 30, 121, N'Ozuluama de Mascareñas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2216, 30, 122, N'Pajapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2217, 30, 123, N'Pánuco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2218, 30, 124, N'Papantla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2219, 30, 126, N'Paso de Ovejas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2220, 30, 125, N'Paso del Macho')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2221, 30, 128, N'Perote')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2222, 30, 129, N'Platón Sánchez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2223, 30, 130, N'Playa Vicente')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2224, 30, 131, N'Poza Rica de Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2225, 30, 133, N'Pueblo Viejo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2226, 30, 134, N'Puente Nacional')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2227, 30, 135, N'Rafael Delgado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2228, 30, 136, N'Rafael Lucio')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2229, 30, 138, N'Río Blanco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2230, 30, 139, N'Saltabarranca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2231, 30, 140, N'San Andrés Tenejapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2232, 30, 141, N'San Andrés Tuxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2233, 30, 142, N'San Juan Evangelista')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2234, 30, 211, N'San Rafael')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2235, 30, 212, N'Santiago Sochiapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2236, 30, 143, N'Santiago Tuxtla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2237, 30, 144, N'Sayula de Alemán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2238, 30, 146, N'Sochiapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2239, 30, 145, N'Soconusco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2240, 30, 147, N'Soledad Atzompa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2241, 30, 148, N'Soledad de Doblado')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2242, 30, 149, N'Soteapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2243, 30, 150, N'Tamalín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2244, 30, 151, N'Tamiahua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2245, 30, 152, N'Tampico Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2246, 30, 153, N'Tancoco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2247, 30, 154, N'Tantima')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2248, 30, 155, N'Tantoyuca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2249, 30, 209, N'Tatahuicapan de Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2250, 30, 156, N'Tatatila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2251, 30, 158, N'Tecolutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2252, 30, 159, N'Tehuipango')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2253, 30, 161, N'Tempoal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2254, 30, 162, N'Tenampa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2255, 30, 163, N'Tenochtitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2256, 30, 164, N'Teocelo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2257, 30, 165, N'Tepatlaxco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2258, 30, 166, N'Tepetlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2259, 30, 167, N'Tepetzintla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2260, 30, 168, N'Tequila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2261, 30, 170, N'Texcatepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2262, 30, 171, N'Texhuacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2263, 30, 172, N'Texistepec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2264, 30, 173, N'Tezonapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2265, 30, 174, N'Tierra Blanca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2266, 30, 175, N'Tihuatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2267, 30, 180, N'Tlachichilco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2268, 30, 176, N'Tlacojalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2269, 30, 177, N'Tlacolulan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2270, 30, 178, N'Tlacotalpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2271, 30, 179, N'Tlacotepec de Mejía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2272, 30, 181, N'Tlalixcoyan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2273, 30, 182, N'Tlalnelhuayocan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2274, 30, 24, N'Tlaltetela')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2275, 30, 183, N'Tlapacoyan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2276, 30, 184, N'Tlaquilpa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2277, 30, 185, N'Tlilapan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2278, 30, 186, N'Tomatlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2279, 30, 187, N'Tonayán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2280, 30, 188, N'Totutla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2281, 30, 207, N'Tres Valles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2282, 30, 189, N'Tuxpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2283, 30, 190, N'Tuxtilla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2284, 30, 191, N'Ursulo Galván')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2285, 30, 210, N'Uxpanapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2286, 30, 192, N'Vega de Alatorre')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2287, 30, 193, N'Veracruz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2288, 30, 194, N'Villa Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2289, 30, 87, N'Xalapa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2290, 30, 92, N'Xico')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2291, 30, 195, N'Xoxocotla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2292, 30, 196, N'Yanga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2293, 30, 197, N'Yecuatla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2294, 30, 198, N'Zacualpan')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2295, 30, 199, N'Zaragoza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2296, 30, 200, N'Zentla')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2297, 30, 201, N'Zongolica')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2298, 30, 202, N'Zontecomatlán de López y Fuentes')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2299, 30, 203, N'Zozocolco de Hidalgo')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2300, 31, 1, N'Abalá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2301, 31, 2, N'Acanceh')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2302, 31, 3, N'Akil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2303, 31, 4, N'Baca')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2304, 31, 5, N'Bokobá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2305, 31, 6, N'Buctzotz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2306, 31, 7, N'Cacalchén')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2307, 31, 8, N'Calotmul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2308, 31, 9, N'Cansahcab')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2309, 31, 10, N'Cantamayec')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2310, 31, 11, N'Celestún')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2311, 31, 12, N'Cenotillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2312, 31, 16, N'Chacsinkín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2313, 31, 17, N'Chankom')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2314, 31, 18, N'Chapab')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2315, 31, 19, N'Chemax')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2316, 31, 21, N'Chichimilá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2317, 31, 20, N'Chicxulub Pueblo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2318, 31, 22, N'Chikindzonot')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2319, 31, 23, N'Chocholá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2320, 31, 24, N'Chumayel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2321, 31, 13, N'Conkal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2322, 31, 14, N'Cuncunul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2323, 31, 15, N'Cuzamá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2324, 31, 25, N'Dzán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2325, 31, 26, N'Dzemul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2326, 31, 27, N'Dzidzantún')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2327, 31, 28, N'Dzilam de Bravo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2328, 31, 29, N'Dzilam González')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2329, 31, 30, N'Dzitás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2330, 31, 31, N'Dzoncauich')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2331, 31, 32, N'Espita')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2332, 31, 33, N'Halachó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2333, 31, 34, N'Hocabá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2334, 31, 35, N'Hoctún')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2335, 31, 36, N'Homún')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2336, 31, 37, N'Huhí')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2337, 31, 38, N'Hunucmá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2338, 31, 39, N'Ixil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2339, 31, 40, N'Izamal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2340, 31, 41, N'Kanasín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2341, 31, 42, N'Kantunil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2342, 31, 43, N'Kaua')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2343, 31, 44, N'Kinchil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2344, 31, 45, N'Kopomá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2345, 31, 46, N'Mama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2346, 31, 47, N'Maní')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2347, 31, 48, N'Maxcanú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2348, 31, 49, N'Mayapán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2349, 31, 50, N'Mérida')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2350, 31, 51, N'Mocochá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2351, 31, 52, N'Motul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2352, 31, 53, N'Muna')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2353, 31, 54, N'Muxupip')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2354, 31, 55, N'Opichén')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2355, 31, 56, N'Oxkutzcab')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2356, 31, 57, N'Panabá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2357, 31, 58, N'Peto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2358, 31, 59, N'Progreso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2359, 31, 60, N'Quintana Roo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2360, 31, 61, N'Río Lagartos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2361, 31, 62, N'Sacalum')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2362, 31, 63, N'Samahil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2363, 31, 65, N'San Felipe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2364, 31, 64, N'Sanahcat')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2365, 31, 66, N'Santa Elena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2366, 31, 67, N'Seyé')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2367, 31, 68, N'Sinanché')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2368, 31, 69, N'Sotuta')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2369, 31, 70, N'Sucilá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2370, 31, 71, N'Sudzal')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2371, 31, 72, N'Suma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2372, 31, 73, N'Tahdziú')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2373, 31, 74, N'Tahmek')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2374, 31, 75, N'Teabo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2375, 31, 76, N'Tecoh')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2376, 31, 77, N'Tekal de Venegas')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2377, 31, 78, N'Tekantó')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2378, 31, 79, N'Tekax')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2379, 31, 80, N'Tekit')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2380, 31, 81, N'Tekom')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2381, 31, 82, N'Telchac Pueblo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2382, 31, 83, N'Telchac Puerto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2383, 31, 84, N'Temax')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2384, 31, 85, N'Temozón')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2385, 31, 86, N'Tepakán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2386, 31, 87, N'Tetiz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2387, 31, 88, N'Teya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2388, 31, 89, N'Ticul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2389, 31, 90, N'Timucuy')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2390, 31, 91, N'Tinum')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2391, 31, 92, N'Tixcacalcupul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2392, 31, 93, N'Tixkokob')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2393, 31, 94, N'Tixmehuac')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2394, 31, 95, N'Tixpéhual')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2395, 31, 96, N'Tizimín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2396, 31, 97, N'Tunkás')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2397, 31, 98, N'Tzucacab')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2398, 31, 99, N'Uayma')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2399, 31, 100, N'Ucú')
GO
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2400, 31, 101, N'Umán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2401, 31, 102, N'Valladolid')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2402, 31, 103, N'Xocchel')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2403, 31, 104, N'Yaxcabá')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2404, 31, 105, N'Yaxkukul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2405, 31, 106, N'Yobaín')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2406, 32, 1, N'Apozol')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2407, 32, 2, N'Apulco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2408, 32, 3, N'Atolinga')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2409, 32, 4, N'Benito Juárez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2410, 32, 5, N'Calera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2411, 32, 6, N'Cañitas de Felipe Pescador')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2412, 32, 9, N'Chalchihuites')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2413, 32, 7, N'Concepción del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2414, 32, 8, N'Cuauhtémoc')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2415, 32, 15, N'El Plateado de Joaquín Amaro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2416, 32, 41, N'El Salvador')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2417, 32, 10, N'Fresnillo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2418, 32, 12, N'Genaro Codina')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2419, 32, 13, N'General Enrique Estrada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2420, 32, 14, N'General Francisco R. Murguía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2421, 32, 16, N'General Pánfilo Natera')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2422, 32, 17, N'Guadalupe')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2423, 32, 18, N'Huanusco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2424, 32, 19, N'Jalpa')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2425, 32, 20, N'Jerez')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2426, 32, 21, N'Jiménez del Teul')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2427, 32, 22, N'Juan Aldama')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2428, 32, 23, N'Juchipila')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2429, 32, 24, N'Loreto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2430, 32, 25, N'Luis Moya')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2431, 32, 26, N'Mazapil')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2432, 32, 27, N'Melchor Ocampo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2433, 32, 28, N'Mezquital del Oro')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2434, 32, 29, N'Miguel Auza')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2435, 32, 30, N'Momax')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2436, 32, 31, N'Monte Escobedo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2437, 32, 32, N'Morelos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2438, 32, 33, N'Moyahua de Estrada')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2439, 32, 34, N'Nochistlán de Mejía')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2440, 32, 35, N'Noria de Ángeles')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2441, 32, 36, N'Ojocaliente')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2442, 32, 37, N'Pánuco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2443, 32, 38, N'Pinos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2444, 32, 39, N'Río Grande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2445, 32, 40, N'Sain Alto')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2446, 32, 58, N'Santa María de la Paz')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2447, 32, 42, N'Sombrerete')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2448, 32, 43, N'Susticacán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2449, 32, 44, N'Tabasco')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2450, 32, 45, N'Tepechitlán')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2451, 32, 46, N'Tepetongo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2452, 32, 47, N'Teúl de González Ortega')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2453, 32, 48, N'Tlaltenango de Sánchez Román')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2454, 32, 57, N'Trancoso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2455, 32, 11, N'Trinidad García de la Cadena')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2456, 32, 49, N'Valparaíso')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2457, 32, 50, N'Vetagrande')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2458, 32, 51, N'Villa de Cos')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2459, 32, 52, N'Villa García')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2460, 32, 53, N'Villa González Ortega')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2461, 32, 54, N'Villa Hidalgo')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2462, 32, 55, N'Villanueva')
INSERT [dbo].[municipios] ([id], [id_estado], [clave_municipio], [descripcion]) VALUES (2463, 32, 56, N'Zacatecas')
SET IDENTITY_INSERT [dbo].[municipios] OFF
GO
SET IDENTITY_INSERT [dbo].[owner] ON 

INSERT [dbo].[owner] ([id], [name], [description]) VALUES (1, N'FIMSA', N'FIMSA como propietario')
INSERT [dbo].[owner] ([id], [name], [description]) VALUES (2, N'FEISA', N'FEISA como propietario')
INSERT [dbo].[owner] ([id], [name], [description]) VALUES (3, N'FIMSA / FEISA', N'Ambas entidades como propietarias')
INSERT [dbo].[owner] ([id], [name], [description]) VALUES (4, N'Otro', N'Otro propietario no listado')
SET IDENTITY_INSERT [dbo].[owner] OFF
GO
SET IDENTITY_INSERT [dbo].[project_activity_status] ON 

INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (1, N'No visto', N'Actividad no revisada', N'#FF0000')
INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (2, N'Visto', N'Actividad revisada pero no iniciada', N'#FFFF00')
INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (3, N'En proceso', N'Actividad en progreso', N'#0000FF')
INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (4, N'Finalizado', N'Actividad completada', N'#00FF00')
INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (5, N'Cancelado', N'Actividad cancelada', N'#888888')
INSERT [dbo].[project_activity_status] ([id], [name], [description], [color_code]) VALUES (6, N'Retrasado', N'Actividad retrasada', N'#FFA500')
SET IDENTITY_INSERT [dbo].[project_activity_status] OFF
GO
SET IDENTITY_INSERT [dbo].[project_land_type] ON 

INSERT [dbo].[project_land_type] ([id], [name], [description]) VALUES (1, N'Local Construido', N'Local comercial ya construido')
INSERT [dbo].[project_land_type] ([id], [name], [description]) VALUES (2, N'Terreno en breña', N'Terreno sin construcciones')
INSERT [dbo].[project_land_type] ([id], [name], [description]) VALUES (3, N'Terreno con mejoras', N'Terreno con algunas mejoras básicas')
SET IDENTITY_INSERT [dbo].[project_land_type] OFF
GO
SET IDENTITY_INSERT [dbo].[residential_development] ON 

INSERT [dbo].[residential_development] ([id], [name], [city], [state], [created_at], [updated_at]) VALUES (1, N'Aguascalientes', N'1', N'1', CAST(N'2025-05-25T06:59:08.887' AS DateTime), CAST(N'2025-05-25T06:59:08.887' AS DateTime))
SET IDENTITY_INSERT [dbo].[residential_development] OFF
GO
SET IDENTITY_INSERT [dbo].[stage] ON 

INSERT [dbo].[stage] ([id], [name], [description]) VALUES (1, N'Negociación', N'Etapa inicial de negociación con el cliente')
INSERT [dbo].[stage] ([id], [name], [description]) VALUES (2, N'Solicitud', N'Solicitud formal recibida')
INSERT [dbo].[stage] ([id], [name], [description]) VALUES (3, N'En Proceso', N'Proyecto en proceso de ejecución')
INSERT [dbo].[stage] ([id], [name], [description]) VALUES (4, N'Ratificación', N'Esperando ratificación de términos')
INSERT [dbo].[stage] ([id], [name], [description]) VALUES (5, N'Cerrado', N'Proyecto finalizado')
SET IDENTITY_INSERT [dbo].[stage] OFF
GO
SET IDENTITY_INSERT [dbo].[status] ON 

INSERT [dbo].[status] ([id], [name], [description]) VALUES (1, N'Nuevo', N'Elemento recién creado')
INSERT [dbo].[status] ([id], [name], [description]) VALUES (2, N'En firmas', N'En proceso de firma')
INSERT [dbo].[status] ([id], [name], [description]) VALUES (3, N'Aceptado', N'Aceptado y aprobado')
INSERT [dbo].[status] ([id], [name], [description]) VALUES (4, N'Cancelado', N'Cancelado o rechazado')
INSERT [dbo].[status] ([id], [name], [description]) VALUES (5, N'En renta', N'Terreno en renta')
INSERT [dbo].[status] ([id], [name], [description]) VALUES (6, N'Disponible', N'Terreno disponible')
SET IDENTITY_INSERT [dbo].[status] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([id], [full_name], [email], [rol_id], [area_id], [hashed_password]) VALUES (1, N'Administrador', N'admin@excadb.com', 1, 1, N'$2b$12$5r1.bjr72xbAL0X3jZtvkuqtObxMZG8waRP1h43RK3GPBBzaogWVq')
SET IDENTITY_INSERT [dbo].[user] OFF
GO
SET IDENTITY_INSERT [dbo].[user_rol] ON 

INSERT [dbo].[user_rol] ([id], [name]) VALUES (1, N'Administrator')
INSERT [dbo].[user_rol] ([id], [name]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[user_rol] OFF
GO
/****** Object:  Index [UQ_flow_step_order]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[approval_flow_step] ADD  CONSTRAINT [UQ_flow_step_order] UNIQUE NONCLUSTERED 
(
	[flow_id] ASC,
	[step_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__client__129B8671D971B165]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[client] ADD UNIQUE NONCLUSTERED 
(
	[tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__client__AB6E616486AA2588]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[client] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__individu__129B867129AEC264]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[individual] ADD UNIQUE NONCLUSTERED 
(
	[tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_project_land]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[project_land] ADD  CONSTRAINT [UK_project_land] UNIQUE NONCLUSTERED 
(
	[project_id] ASC,
	[land_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user__AB6E61640FC55F74]    Script Date: 25/5/2025 07:11:15 ******/
ALTER TABLE [dbo].[user] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[approval_flow] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[approval_flow_step] ADD  DEFAULT ((1)) FOR [is_required]
GO
ALTER TABLE [dbo].[approval_request] ADD  DEFAULT (getdate()) FOR [requested_at]
GO
ALTER TABLE [dbo].[case] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[case] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[case] ADD  DEFAULT ((1)) FOR [status_id]
GO
ALTER TABLE [dbo].[case_condition] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[client] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[client] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[client_address] ADD  DEFAULT ('México') FOR [country]
GO
ALTER TABLE [dbo].[client_address] ADD  DEFAULT ((1)) FOR [is_primary]
GO
ALTER TABLE [dbo].[client_document] ADD  DEFAULT (getdate()) FOR [uploaded_at]
GO
ALTER TABLE [dbo].[condition] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[condition] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[condition] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[condition_option] ADD  DEFAULT ((0)) FOR [display_order]
GO
ALTER TABLE [dbo].[condition_option] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[individual] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[individual] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[individual_document] ADD  DEFAULT (getdate()) FOR [uploaded_at]
GO
ALTER TABLE [dbo].[land] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[land] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[land_categories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[land_categories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[land_statuses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[land_statuses] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[land_types] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[land_types] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[lease_request] ADD  DEFAULT ((0)) FOR [commission_agreement]
GO
ALTER TABLE [dbo].[lease_request] ADD  DEFAULT ((0)) FOR [assignment_income]
GO
ALTER TABLE [dbo].[lease_request] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[lease_request] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[lease_request] ADD  DEFAULT ((1)) FOR [status_id]
GO
ALTER TABLE [dbo].[lease_request_condition] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[lease_request_condition] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[lease_request_condition] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[project] ADD  DEFAULT ((1)) FOR [stage_id]
GO
ALTER TABLE [dbo].[project] ADD  DEFAULT ((1)) FOR [status_id]
GO
ALTER TABLE [dbo].[project] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[project] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[project_activity] ADD  DEFAULT ((1)) FOR [status_id]
GO
ALTER TABLE [dbo].[project_activity] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[project_activity] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[project_event] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[project_event] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[project_land] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[project_land] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[property_tax] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[property_tax] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[property_tax_status] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[property_tax_status] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[residential_development] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[residential_development] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[approval_flow_step]  WITH CHECK ADD FOREIGN KEY([flow_id])
REFERENCES [dbo].[approval_flow] ([id])
GO
ALTER TABLE [dbo].[approval_flow_step]  WITH CHECK ADD FOREIGN KEY([signator_role_id])
REFERENCES [dbo].[user_rol] ([id])
GO
ALTER TABLE [dbo].[approval_flow_step]  WITH CHECK ADD FOREIGN KEY([signator_area_id])
REFERENCES [dbo].[area] ([id])
GO
ALTER TABLE [dbo].[approval_flow_step]  WITH CHECK ADD FOREIGN KEY([signator_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[approval_request]  WITH CHECK ADD FOREIGN KEY([flow_step_id])
REFERENCES [dbo].[approval_flow_step] ([id])
GO
ALTER TABLE [dbo].[approval_request]  WITH CHECK ADD FOREIGN KEY([requested_by])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[brand]  WITH CHECK ADD FOREIGN KEY([client_id])
REFERENCES [dbo].[client] ([id])
GO
ALTER TABLE [dbo].[case]  WITH CHECK ADD FOREIGN KEY([case_type_id])
REFERENCES [dbo].[case_type] ([id])
GO
ALTER TABLE [dbo].[case]  WITH CHECK ADD FOREIGN KEY([originator_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[case]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([id])
GO
ALTER TABLE [dbo].[case]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[case_condition]  WITH CHECK ADD FOREIGN KEY([case_id])
REFERENCES [dbo].[case] ([id])
GO
ALTER TABLE [dbo].[case_condition]  WITH CHECK ADD FOREIGN KEY([condition_id])
REFERENCES [dbo].[condition] ([id])
GO
ALTER TABLE [dbo].[case_condition]  WITH CHECK ADD FOREIGN KEY([option_id])
REFERENCES [dbo].[condition_option] ([id])
GO
ALTER TABLE [dbo].[client]  WITH CHECK ADD FOREIGN KEY([turn_id])
REFERENCES [dbo].[business_turn] ([id])
GO
ALTER TABLE [dbo].[client]  WITH CHECK ADD FOREIGN KEY([type_id])
REFERENCES [dbo].[client_type] ([id])
GO
ALTER TABLE [dbo].[client_address]  WITH CHECK ADD FOREIGN KEY([client_id])
REFERENCES [dbo].[client] ([id])
GO
ALTER TABLE [dbo].[client_document]  WITH CHECK ADD FOREIGN KEY([client_id])
REFERENCES [dbo].[client] ([id])
GO
ALTER TABLE [dbo].[client_document]  WITH CHECK ADD FOREIGN KEY([document_id])
REFERENCES [dbo].[document] ([id])
GO
ALTER TABLE [dbo].[condition]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[condition_category] ([id])
GO
ALTER TABLE [dbo].[condition]  WITH CHECK ADD FOREIGN KEY([type_id])
REFERENCES [dbo].[condition_type] ([id])
GO
ALTER TABLE [dbo].[condition_option]  WITH CHECK ADD FOREIGN KEY([condition_id])
REFERENCES [dbo].[condition] ([id])
GO
ALTER TABLE [dbo].[document_usage]  WITH CHECK ADD FOREIGN KEY([document_id])
REFERENCES [dbo].[document] ([id])
GO
ALTER TABLE [dbo].[individual]  WITH CHECK ADD FOREIGN KEY([address_id])
REFERENCES [dbo].[client_address] ([id])
GO
ALTER TABLE [dbo].[individual]  WITH CHECK ADD FOREIGN KEY([client_id])
REFERENCES [dbo].[client] ([id])
GO
ALTER TABLE [dbo].[individual_document]  WITH CHECK ADD FOREIGN KEY([document_id])
REFERENCES [dbo].[document] ([id])
GO
ALTER TABLE [dbo].[individual_document]  WITH CHECK ADD FOREIGN KEY([individual_id])
REFERENCES [dbo].[individual] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([guarantee_id])
REFERENCES [dbo].[individual] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([guarantee_type_id])
REFERENCES [dbo].[guarantee_type] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([owner_id])
REFERENCES [dbo].[owner] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([id])
GO
ALTER TABLE [dbo].[lease_request]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[lease_request_condition]  WITH CHECK ADD FOREIGN KEY([condition_id])
REFERENCES [dbo].[condition] ([id])
GO
ALTER TABLE [dbo].[lease_request_condition]  WITH CHECK ADD FOREIGN KEY([lease_request_id])
REFERENCES [dbo].[lease_request] ([id])
GO
ALTER TABLE [dbo].[lease_request_condition]  WITH CHECK ADD FOREIGN KEY([option_id])
REFERENCES [dbo].[condition_option] ([id])
GO
ALTER TABLE [dbo].[municipios]  WITH CHECK ADD FOREIGN KEY([id_estado])
REFERENCES [dbo].[estados] ([id])
GO
ALTER TABLE [dbo].[municipios]  WITH CHECK ADD FOREIGN KEY([id_estado])
REFERENCES [dbo].[estados] ([id])
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([id])
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD FOREIGN KEY([originator_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD FOREIGN KEY([stage_id])
REFERENCES [dbo].[stage] ([id])
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[project_activity]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[project_activity]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([id])
GO
ALTER TABLE [dbo].[project_activity]  WITH CHECK ADD FOREIGN KEY([responsible_area_id])
REFERENCES [dbo].[area] ([id])
GO
ALTER TABLE [dbo].[project_activity]  WITH CHECK ADD FOREIGN KEY([responsible_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[project_activity]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[project_activity_status] ([id])
GO
ALTER TABLE [dbo].[project_event]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([id])
GO
ALTER TABLE [dbo].[project_land]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([id])
GO
ALTER TABLE [dbo].[project_land]  WITH CHECK ADD FOREIGN KEY([type_id])
REFERENCES [dbo].[project_land_type] ([id])
GO
ALTER TABLE [dbo].[project_land]  WITH CHECK ADD  CONSTRAINT [FK_project_land] FOREIGN KEY([land_id])
REFERENCES [dbo].[land] ([id])
GO
ALTER TABLE [dbo].[project_land] CHECK CONSTRAINT [FK_project_land]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[area] ([id])
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([rol_id])
REFERENCES [dbo].[user_rol] ([id])
GO
ALTER TABLE [dbo].[document_usage]  WITH CHECK ADD CHECK  (([usage_type]='individual' OR [usage_type]='physical_person' OR [usage_type]='legal_entity'))
GO
ALTER TABLE [dbo].[project_land]  WITH CHECK ADD CHECK  (([build_area]>=(0)))
GO
ALTER TABLE [dbo].[project_land]  WITH CHECK ADD CHECK  (([area]>(0)))
GO
USE [master]
GO
ALTER DATABASE [GPViviendaDb] SET  READ_WRITE 
GO
