/*
==========================================================
 Script:    Create Database and Schemas
 Author:    Belal Ahmed
==========================================================
 Purpose:
   This script creates a new database named 'DataWarehouse' 
   after checking if it already exists. 
   If the database exists, it is dropped and recreated. 
   Additionally, the script sets up three schemas within 
   the database: 'bronze', 'silver', and 'gold'.

 WARNING:
   Running this script will drop the entire 'DataWarehouse' 
   database if it exists. 
   ⚠️ All data in the database will be permanently deleted. 
   Proceed with caution and ensure you have proper backups 
   before running this script.
==========================================================
*/

-- Ensure you are on the master
USE master;
GO

-- Check if the database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Force single-user mode and rollback active connections
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    
    -- Drop the existing database
    DROP DATABASE DataWarehouse;
END;
GO

-- ✅ Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the new database
USE DataWarehouse;
GO

-- ✅ Create Schemas for Data Engineering Layers
CREATE SCHEMA bronze;  -- Raw data
GO
CREATE SCHEMA silver;  -- Cleansed/standardized data
GO
CREATE SCHEMA gold;    -- Curated/aggregated data
GO

-- 🎉 Setup complete
