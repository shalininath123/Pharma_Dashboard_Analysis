# Pharma_Dashboard_Analysis

This project analyzes pharmaceutical sales using a sample dataset from Kaggle:
https://www.kaggle.com/datasets/jewelzufo/sample-pharmaceutical-drug

The repository includes:
- `Pharmaceutical_Drug_Sales.xlsx`: the Excel workbook with raw data, cleaned data, helper tables, pivot tables, and dashboard layout.
- `pharma_analysis.py`: Python analytics script that reads the workbook, creates a cleaned dataset, and generates summary CSV reports.
- `pharma_analysis.sql`: SQL analytics code for creating cleaned views and generating key commercial metrics.
- `requirements.txt`: dependency list for the Python script.

## Project summary
This work demonstrates how to turn raw pharmaceutical sales data into meaningful business insights. It includes:
- regional revenue and performance analysis
- monthly seasonality tracking
- product and sales representative performance summaries
- target achievement calculation using helper multipliers
- executive KPI reporting for dashboard-ready insights

## How to run
1. Install Python dependencies:
```bash
pip install -r requirements.txt
```
2. Run the Python analytics script:
```bash
python3 pharma_analysis.py
```
3. Review generated output files:
- `cleaned_data.csv`
- `region_summary.csv`
- `monthly_summary.csv`
- `sales_rep_summary.csv`
- `product_summary.csv`

## Notes for a new user
- Keep the original Excel file `Pharmaceutical_Drug_Sales.xlsx` in the repository root.
- The Python script reads the workbook and writes cleaned analytics output in CSV format.
- If you want to use the data in a database, load `raw_data` and `helper_table` from the Excel file first, then run the SQL queries in `pharma_analysis.sql`.
- For a deeper dashboard, use the generated summary CSV files in Tableau, Power BI, or Excel.
