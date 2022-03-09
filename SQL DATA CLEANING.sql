--Viewing the dataset

	SELECT *
	FROM ProjectPortfolio.dbo.Nashville_housing_data_2013_201$
	Order by 1


--Standradize Date Format

	SELECT [Sale Date], CONVERT(date, [Sale Date])
	FROM ProjectPortfolio.dbo.Nashville_housing_data_2013_201$

	Update ProjectPortfolio..Nashville_housing_data_2013_201$
	SET [Sale Date] = CONVERT(date, [Sale Date])

	ALTER TABLE Nashville_housing_data_2013_201$
	ADD Sale_Date_Converted Date;

	Update Nashville_housing_data_2013_201$
	SET Sale_Date_Converted = CONVERT(date, [Sale Date])


--Populate property address data using existing records

	--See the data where adress in null
		SELECT *
		FROM ProjectPortfolio..Nashville_housing_data_2013_201$
		Where [Property Address] is null

	--joining the data to itself
		SELECT *
		FROM ProjectPortfolio..Nashville_housing_data_2013_201$ table_a
			JOIN ProjectPortfolio..Nashville_housing_data_2013_201$ table_b
			ON table_a.[Parcel ID] = table_b.[Parcel ID]
			AND table_a.F1 = table_b.F1

--Populating adress data
	Select a.[Parcel ID], a.[Property Address], b.[Parcel ID], b.[Property Address], ISNULL(a.[Property Address],b.[Property Address])
	From ProjectPortfolio..Nashville_housing_data_2013_201$ a
	JOIN ProjectPortfolio..Nashville_housing_data_2013_201$ b
	on a.[Parcel ID] = b.[Parcel ID]
	Where a.[Property Address] is null and b.[Property Address] is not null

	Update a
	SET [Property Address] = ISNULL(a.[Property Address],b.[Property Address])
	From ProjectPortfolio..Nashville_housing_data_2013_201$ a
	JOIN ProjectPortfolio..Nashville_housing_data_2013_201$ b
		on a.[Parcel ID] = b.[Parcel ID]
	Where a.[Property Address] is null and b.[Property Address] is not null

	--There are still some null adresses, remove the entire rows (159 rows are still showing as null)
	DELETE
	FROM ProjectPortfolio..Nashville_housing_data_2013_201$
	Where [Property Address] is null


-- Delete Unused Columns

Select *
From ProjectPortfolio..Nashville_housing_data_2013_201$


ALTER TABLE ProjectPortfolio..Nashville_housing_data_2013_201$
DROP COLUMN [TaxDistrict], [SaleDate]





	   








