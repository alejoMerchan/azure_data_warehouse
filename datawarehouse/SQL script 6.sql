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

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION = 'fact_trip',
    DATA_SOURCE = [lab2filesystem_lab2datalake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[TripId] trip_id, 
[staging_rider].[RiderId] rider_id, 
[RideableType] rideable_type, 
[StartedAt] started_at, 
[EndedAt] ended_at, 
[StartStationId] start_station_id, 
[EndStationId] end_station_id,
DATEDIFF(year,CAST(Birthday AS DATETIME2), CAST(AccountStartDate AS DATETIME2)) age,
DATEDIFF(minute, CAST(StartedAt AS DATETIME2), CAST(EndedAt AS DATETIME2)) duration
FROM [dbo].[staging_trip] inner join [dbo].[staging_rider] on [dbo].[staging_trip].[RiderId] = [dbo].[staging_rider].[RiderId]
where [dbo].[staging_trip].[RiderId] = 70870;
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO