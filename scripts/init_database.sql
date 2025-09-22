-- ================================================
-- ⚙️ Initial Setup Script for Data Warehouse Project
-- 🧠 Author: Belal Ahmed
-- 📁 Purpose: Create clean environment with Bronze, Silver, Gold schemas
-- ================================================

-- Ensure you are on the master database
USE master;
GO

-- Check if the database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Force single-user mode and rollback active connections to allow drop
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop existing DataWarehouse database
    DROP DATABASE DataWarehouse;
END;
GO

-- ✅ Create a fresh DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- 🔁 Switch to the newly created database
USE DataWarehouse;
GO

-- ✅ Create Data Engineering schemas
-- Bronze Layer: Raw unprocessed data
CREATE SCHEMA bronze;
GO

-- Silver Layer: Cleansed and conformed data
CREATE SCHEMA silver;
GO

-- Gold Layer: Curated data for analytics/reporting
CREATE SCHEMA gold;
GO

-- 🎉 Setup complete! You are ready to build your data pipelines.
