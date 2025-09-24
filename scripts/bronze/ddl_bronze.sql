/* ==========================================================================================
   Project   : Data Warehouse - Bronze Layer
   Script    : DDL Script for Creating Source Tables
   Author    : Belal Ahmed

   Description:
   This script creates the staging (Bronze Layer) tables for both CRM and ERP data sources.
   The Bronze Layer represents the raw data ingestion layer in the Data Warehouse, where
   data is loaded directly from the operational source systems (CRM & ERP) with minimal or
   no transformations.

   Key Notes:
   - Tables are created under the [bronze] schema.
   - Structures are based on source CSV files (CRM & ERP exports).
   - Data types are chosen to reflect the source system definitions.
   - This layer serves as the foundation for the Silver Layer (cleansed data).
========================================================================================== */

/* ==========================================================
   CRM TABLES
   ========================================================== */

-- Drop if exists and create table bronze.crm_cust_info
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
GO

-- Drop if exists and create table bronze.crm_product_info
IF OBJECT_ID('bronze.crm_product_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_product_info;
GO

CREATE TABLE bronze.crm_product_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost DECIMAL(18,2),
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO

-- Drop if exists and create table bronze.crm_sales_order
IF OBJECT_ID('bronze.crm_sales_order', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_order;
GO

CREATE TABLE bronze.crm_sales_order (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
	sls_order_dt NVARCHAR(50),
	sls_ship_dt NVARCHAR(50),
	sls_due_dt NVARCHAR(50),
    sls_sales DECIMAL(18,2),
    sls_quantity INT,
    sls_price DECIMAL(18,2)
);
GO


/* ==========================================================
   ERP TABLES
   ========================================================== */

-- Drop if exists and create table bronze.erp_loc_a101
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO

-- Drop if exists and create table bronze.erp_cust_az12
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);
GO

-- Drop if exists and create table bronze.erp_px_cat_g1v2
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO
