IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'lab2filesystem_lab2datalake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [lab2filesystem_lab2datalake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://lab2filesystem@lab2datalake.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION = 'dim_rider',
    DATA_SOURCE = [lab2filesystem_lab2datalake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[RiderId] rider_id, 
[First] first_name, 
[Last] last_name, 
[Birthday] birthday,
[Address] address, 
[AccountStartDate] account_start_date, 
[AccountEndDate] account_end_date,
[IsMember] is_member
FROM [dbo].[staging_rider]
GO

SELECT TOP 100 * FROM dbo.dim_rider
GO