-- Pharma sales analytics SQL code for reporting and dashboard preparation
-- Use this file to populate the tables, enrich raw data, and derive commercial KPIs.

-- 1. Create source tables for raw Excel data and helper mapping.
CREATE TABLE IF NOT EXISTS raw_data (
    Drug_Name TEXT,
    Manufacturer TEXT,
    Dosage_Form TEXT,
    Strength TEXT,
    Package_Size TEXT,
    Units_Sold INTEGER,
    Revenue REAL,
    Sale_Date TEXT,
    Region TEXT,
    Sales_Representative TEXT,
    Customer_Type TEXT
);

CREATE TABLE IF NOT EXISTS helper_table (
    Region TEXT,
    Target_Multiplier REAL
);

-- 2. Example insert statements for helper table. Replace values with the actual helper values from the workbook if needed.
INSERT INTO helper_table (Region, Target_Multiplier) VALUES
    ('Asia', 0.95),
    ('Europe', 1.1),
    ('Africa', 0.9),
    ('North America', 1.2),
    ('South America', 1.1);

-- 3. Create a cleaned view that mirrors the Excel analytics logic.
CREATE VIEW IF NOT EXISTS cleaned_sales AS
SELECT
    r.*,
    CASE
        WHEN LENGTH(Sale_Date) >= 10 THEN substr(Sale_Date, 1, 4) || '-' || substr(Sale_Date, 6, 2) || '-' || substr(Sale_Date, 9, 2)
        ELSE Sale_Date
    END AS Sale_Date_ISO,
    CASE
        WHEN Sale_Date IS NULL THEN 'Unknown'
        WHEN strftime('%m', Sale_Date) IN ('01','02','03') THEN 'Jan'
        WHEN strftime('%m', Sale_Date) = '04' THEN 'Apr'
        WHEN strftime('%m', Sale_Date) = '05' THEN 'May'
        WHEN strftime('%m', Sale_Date) = '06' THEN 'Jun'
        WHEN strftime('%m', Sale_Date) = '07' THEN 'Jul'
        WHEN strftime('%m', Sale_Date) = '08' THEN 'Aug'
        WHEN strftime('%m', Sale_Date) = '09' THEN 'Sep'
        WHEN strftime('%m', Sale_Date) = '10' THEN 'Oct'
        WHEN strftime('%m', Sale_Date) = '11' THEN 'Nov'
        WHEN strftime('%m', Sale_Date) = '12' THEN 'Dec'
        ELSE 'Unknown'
    END AS Month,
    CASE
        WHEN strftime('%m', Sale_Date) IN ('01','02','03') THEN 'Q1'
        WHEN strftime('%m', Sale_Date) IN ('04','05','06') THEN 'Q2'
        WHEN strftime('%m', Sale_Date) IN ('07','08','09') THEN 'Q3'
        WHEN strftime('%m', Sale_Date) IN ('10','11','12') THEN 'Q4'
        ELSE 'Unknown'
    END AS Quarter,
    CASE
        WHEN Revenue >= 40000 THEN 'High'
        WHEN Revenue >= 20000 THEN 'Medium'
        ELSE 'Low'
    END AS Revenue_Category,
    COALESCE(h.Target_Multiplier, 1.0) AS Target_Multiplier,
    Revenue * COALESCE(h.Target_Multiplier, 1.0) AS Target_Revenue,
    CASE
        WHEN COALESCE(h.Target_Multiplier, 1.0) = 0 THEN 0
        ELSE Revenue / (Revenue * COALESCE(h.Target_Multiplier, 1.0))
    END AS Achievement_Pct,
    CASE
        WHEN Revenue / (Revenue * COALESCE(h.Target_Multiplier, 1.0)) >= 1.0 THEN 'Achieved'
        ELSE 'Below Target'
    END AS Performance_Status
FROM raw_data r
LEFT JOIN helper_table h ON r.Region = h.Region;

-- 4. Regional revenue and performance summary
SELECT
    Region,
    COUNT(*) AS Transaction_Count,
    SUM(Revenue) AS Total_Revenue,
    SUM(Units_Sold) AS Total_Units_Sold,
    AVG(Achievement_Pct) AS Avg_Achievement_Pct,
    SUM(CASE WHEN Performance_Status = 'Achieved' THEN 1 ELSE 0 END) AS Achieved_Count,
    SUM(CASE WHEN Performance_Status = 'Below Target' THEN 1 ELSE 0 END) AS Below_Target_Count
FROM cleaned_sales
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- 5. Monthly revenue summary and seasonality tracking
SELECT
    Month,
    COUNT(*) AS Transaction_Count,
    SUM(Revenue) AS Total_Revenue,
    SUM(Units_Sold) AS Total_Units_Sold,
    AVG(Achievement_Pct) AS Avg_Achievement_Pct
FROM cleaned_sales
GROUP BY Month
ORDER BY
    CASE Month
        WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3 WHEN 'Apr' THEN 4
        WHEN 'May' THEN 5 WHEN 'Jun' THEN 6 WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8
        WHEN 'Sep' THEN 9 WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12
        ELSE 99
    END;

-- 6. Top selling drugs and commercial impact
SELECT
    Drug_Name,
    Manufacturer,
    COUNT(*) AS Transactions,
    SUM(Units_Sold) AS Total_Units_Sold,
    SUM(Revenue) AS Total_Revenue,
    AVG(Achievement_Pct) AS Avg_Achievement_Pct
FROM cleaned_sales
GROUP BY Drug_Name, Manufacturer
ORDER BY Total_Revenue DESC
LIMIT 20;

-- 7. Sales representative performance and achievement tracking
SELECT
    Sales_Representative,
    COUNT(*) AS Transactions,
    SUM(Units_Sold) AS Total_Units_Sold,
    SUM(Revenue) AS Total_Revenue,
    AVG(Achievement_Pct) AS Avg_Achievement_Pct,
    SUM(CASE WHEN Performance_Status = 'Achieved' THEN 1 ELSE 0 END) AS Achieved_Count
FROM cleaned_sales
GROUP BY Sales_Representative
ORDER BY Total_Revenue DESC
LIMIT 20;

-- 8. Executive KPIs
SELECT
    SUM(Revenue) AS Total_Revenue,
    SUM(Units_Sold) AS Total_Units_Sold,
    AVG(Achievement_Pct) AS Average_Achievement,
    (SELECT Region FROM cleaned_sales GROUP BY Region ORDER BY SUM(Revenue) DESC LIMIT 1) AS Top_Region,
    (SELECT Drug_Name FROM cleaned_sales GROUP BY Drug_Name ORDER BY SUM(Revenue) DESC LIMIT 1) AS Top_Selling_Drug
FROM cleaned_sales;
