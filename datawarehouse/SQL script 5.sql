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

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION = 'fact_payment',
    DATA_SOURCE = [lab2filesystem_lab2datalake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[PaymentId] payment_id, 
[PaymentDate] payment_date, 
[Amount] amount, 
[RiderId] rider_id,
DATEPART(DAY, CONVERT(DATE,PaymentDate)) day,
DATEPART(MONTH, CONVERT(DATE, PaymentDate)) month,
DATEPART(QUARTER, CONVERT(DATE, PaymentDate)) quarter,
DATEPART(YEAR, CONVERT(DATE, PaymentDate)) year,
DATEPART(DAYOFYEAR, CONVERT(DATE, PaymentDate)) day_of_year,
DATEPART(WEEKDAY, CONVERT(DATE, PaymentDate)) day_of_week
FROM [dbo].[staging_payment]
GO

SELECT TOP 100 * FROM dbo.fact_payment
GO