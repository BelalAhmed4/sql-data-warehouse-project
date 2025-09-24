/* ==========================================================================================
   Project   : Data Warehouse - Bronze Layer
   Script    : Stored Procedure for Bulk Loading CRM & ERP Tables
   Author    : Belal Ahmed

   Description:
   This procedure is responsible for loading raw data into the Bronze Layer
   of the Data Warehouse from CRM and ERP source files.

   Key Features:
   - Uses BULK INSERT to load CSV files directly into Bronze tables.
   - Implements TRY...CATCH for error handling at the table level.
   - Logs progress and execution time for each table load using PRINT statements.
   - Tracks total ETL batch duration from start to end for monitoring performance.
   - Ensures existing data is cleared with TRUNCATE before loading fresh data.

   Purpose:
   The Bronze Layer stores raw, untransformed data as ingested from source systems (CRM & ERP),
   serving as the foundation for further transformations in the Silver and Gold layers.
========================================================================================== */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BatchStart DATETIME = GETDATE();
    DECLARE @TableStart DATETIME;
    DECLARE @Duration INT;

    PRINT '==============================';
    PRINT ' ETL Process Started at ' + CONVERT(VARCHAR(30), @BatchStart, 120);
    PRINT '==============================';

    /* ===============================
       CRM Customer Info
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading CRM Customer Info...';

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? CRM Customer Info loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading CRM Customer Info: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       CRM Product Info
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading CRM Product Info...';

        TRUNCATE TABLE bronze.crm_product_info;

        BULK INSERT bronze.crm_product_info
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? CRM Product Info loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading CRM Product Info: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       CRM Sales Order
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading CRM Sales Order...';

        TRUNCATE TABLE bronze.crm_sales_order;

        BULK INSERT bronze.crm_sales_order
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? CRM Sales Order loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading CRM Sales Order: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       ERP Loc A101
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading ERP Loc A101...';

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? ERP Loc A101 loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading ERP Loc A101: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       ERP Cust AZ12
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading ERP Cust AZ12...';

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? ERP Cust AZ12 loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading ERP Cust AZ12: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       ERP PX_CAT_G1V2
       =============================== */
    BEGIN TRY
        SET @TableStart = GETDATE();
        PRINT '>> Loading ERP PX_CAT_G1V2...';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\1-WorkingSpace\Learning\00-Courses\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @Duration = DATEDIFF(SECOND, @TableStart, GETDATE());
        PRINT '? ERP PX_CAT_G1V2 loaded successfully in ' + CAST(@Duration AS VARCHAR) + ' sec';
    END TRY
    BEGIN CATCH
        PRINT '? Error loading ERP PX_CAT_G1V2: ' + ERROR_MESSAGE();
    END CATCH;


    /* ===============================
       Final ETL Summary
       =============================== */
    DECLARE @BatchEnd DATETIME = GETDATE();
    PRINT '==============================';
    PRINT ' ETL Process Completed at ' + CONVERT(VARCHAR(30), @BatchEnd, 120);
    PRINT ' Total Duration: ' + CAST(DATEDIFF(SECOND, @BatchStart, @BatchEnd) AS VARCHAR) + ' sec';
    PRINT '==============================';
END;
GO
