--FUNCTION - Month End Start Date Query
	EXECUTE dbo.sp_executesql @statement = N'
	IF exists(SELECT * FROM sysobjects WHERE  name = ''MonthStartAndEndDate'')
		drop function [reporting].MonthStartAndEndDate'
	EXECUTE dbo.sp_executesql @statement = N'
	CREATE FUNCTION [reporting].[MonthStartAndEndDate](@date DATETIME)
	RETURNS @dates table(startDate DATETIME, endDate DATETIME)
	AS
	BEGIN
		DECLARE  @endDate DATETIME, @startDate DATETIME

		SELECT @startDATE = DATEADD(S,59,DATEADD(MI,59,DATEADD(HOUR,23,CONVERT(DATETIME, CONVERT(VARCHAR(8), (DATEPART(year,@date)*10000)+(DATEPART(month,@date)*100+1))))))
		SELECT @ENDDATE = DATEADD(DD,-1,DATEADD(MM, 1, @startDATE))

		INSERT INTO @dates VALUES ( @startDATE, @ENDDATE)

		RETURN
	END'
