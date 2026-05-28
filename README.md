# Pharma_Dashboard_Analysis

An interactive pharmaceutical sales analytics platform built with Python, Streamlit, and Plotly. Analyze real-world drug sales data with dynamic filters, executive KPIs, and performance metrics.

**Dataset Source:** https://www.kaggle.com/datasets/jewelzufo/sample-pharmaceutical-drug

## 📊 Project Overview

This project demonstrates enterprise-grade data analytics for the pharmaceutical industry, featuring:

- **Interactive Streamlit Dashboard** — Real-time filtering and exploration
- **Python Analytics Engine** — Data cleaning, transformation, and aggregation
- **Matplotlib/Seaborn Visualizations** — Publication-ready charts and dashboards
- **SQL Analytics Code** — Database-ready queries for commercial analytics
- **CSV Export Modules** — Summary tables for reporting

## 📁 Project Structure

```
Pharma_Dashboard_Analysis/
├── dashboard_streamlit.py          # Interactive Streamlit dashboard (MAIN)
├── pharma_analysis.py              # Python analytics & data processing
├── pharma_analysis.sql             # SQL queries for commercial analytics
├── dashboard_visual.png            # Static Matplotlib dashboard
├── dashboard_plot.html             # HTML preview with KPI cards
├── requirements.txt                # Python dependencies
├── Pharmaceutical_Drug_Sales.xlsx   # Source data (raw, cleaned, pivot, dashboard)
├── cleaned_data.csv                # Enriched dataset with KPIs
├── region_summary.csv              # Regional performance metrics
├── monthly_summary.csv             # Monthly revenue trends
├── sales_rep_summary.csv           # Sales representative rankings
├── product_summary.csv             # Product revenue analysis
└── README.md                       # This file
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- pip (Python package manager)

### Installation & Setup

1. **Clone the repository:**
```bash
git clone https://github.com/shalininath123/Pharma_Dashboard_Analysis.git
cd Pharma_Dashboard_Analysis
```

2. **Install dependencies:**
```bash
pip install -r requirements.txt
```

3. **Launch the interactive dashboard:**
```bash
streamlit run dashboard_streamlit.py
```

The dashboard will open at: `http://localhost:8501`

## 📈 Using the Streamlit Dashboard

The interactive dashboard provides:

### **4 Main Tabs:**

1. **Overview**
   - Monthly revenue trends (line chart)
   - Monthly units sold (bar chart)
   - Performance status distribution (pie chart)
   - Customer type breakdown (bar chart)

2. **Regional Analysis**
   - Revenue by region (horizontal bar)
   - Units sold by region (horizontal bar)
   - Summary table with achievement metrics

3. **Product Analysis**
   - Top 15 drugs by revenue
   - Top 15 drugs by units sold
   - Product performance summary table

4. **Performance**
   - Sales rep revenue vs achievement scatter plot
   - Top 10 sales representatives ranked
   - Target achievement distribution histogram

### **Dynamic Filters (Sidebar):**
- 🌍 Region selector
- 💊 Drug name filter
- 📅 Month selector
- 🎯 Performance status filter

Real-time filtering updates all charts and tables instantly.

## 📊 Analytics Outputs

### Static Dashboards
- **`dashboard_visual.png`** — 4-panel Seaborn dashboard (regional, monthly, product, status)
- **`dashboard_plot.html`** — Web-viewable HTML dashboard with KPI cards

### CSV Reports
Generated automatically by running `pharma_analysis.py`:
- `cleaned_data.csv` — 1000+ enriched transactions with KPIs
- `region_summary.csv` — Revenue, units, transaction counts by region
- `monthly_summary.csv` — Monthly seasonality analysis
- `sales_rep_summary.csv` — Top performers ranked by revenue and achievement
- `product_summary.csv` — Drug-level performance metrics

## 🐍 Python Analytics Pipeline

### Running the Core Analytics Script

```bash
python3 pharma_analysis.py
```

**Outputs:**
- Cleaned CSV dataset with enriched columns
- Regional, monthly, and product summaries
- Matplotlib/Seaborn dashboard visualization
- Console KPI summary

**Key Metrics Calculated:**
- Total Revenue: $26.08M
- Total Units Sold: 1,056,409
- Average Achievement %: 95.83%
- Top Region: South America ($6.25M)
- Top Drug: Drug B ($5.77M)

## 🔧 SQL Analytics

The `pharma_analysis.sql` file contains production-ready queries for:
- Regional revenue and performance aggregation
- Monthly seasonality trends
- Top selling drugs and manufacturers
- Sales representative performance ranking
- Executive KPI summary

**Use cases:**
- Load `raw_data` and `helper_table` into a database
- Execute queries for business intelligence
- Build reporting systems with SQL output

## 📋 Key Features

✅ **Interactive Filters** — Slice data by region, drug, month, and performance status  
✅ **Real-time Updates** — Charts update instantly as filters change  
✅ **Executive KPIs** — 5 key metrics at the top: Revenue, Units, Achievement %, Top Region, Top Drug  
✅ **Multiple Views** — 4 tabs covering overview, regional, product, and performance analysis  
✅ **Data Export** — CSV summaries for further analysis in Excel or BI tools  
✅ **Professional Styling** — Streamlit + Plotly for polished, interactive visualizations  

## 📊 Data Model

### Raw Data (1000 transactions)
- Drug Name, Manufacturer, Dosage Form, Strength, Package Size
- Units Sold, Revenue, Sale Date, Region
- Sales Representative, Customer Type (Hospitals, Clinics, Pharmacy)

### Enriched Columns (Calculated in Processing)
- Month, Quarter (extracted from Sale Date)
- Revenue Category (Low/Medium/High)
- Target Multiplier (from Helper Table, varies by region)
- Target Revenue (Revenue × Target Multiplier)
- Achievement % (Revenue / Target Revenue × 100)
- Performance Status (Achieved if ≥100%, else Below Target)

## 🎯 Business Insights Enabled

- **Regional Performance** — Identify best/worst performing regions for sales strategy
- **Seasonality** — Detect monthly trends for inventory and marketing planning
- **Product Mix** — Optimize portfolio based on drug-level revenue contribution
- **Sales Rep Accountability** — Track individual performance against targets
- **Target Achievement** — Monitor goal attainment across dimensions

## 👥 Use Cases

**For Sales Managers:** Track team and individual KPIs in real-time  
**For Product Managers:** Analyze drug performance and market position  
**For Finance:** Monitor regional revenue targets and achievement  
**For Executives:** Review high-level trends and strategic metrics  
**For Business Analysts:** Prepare detailed reports and deep-dive analyses  

## 🛠️ Technology Stack

| Component | Technology |
|-----------|-----------|
| Dashboard | Streamlit |
| Visualization | Plotly, Matplotlib, Seaborn |
| Data Processing | Pandas, NumPy |
| Data Source | Excel (openpyxl), CSV |
| Analytics | SQL, Python |
| Deployment | CLI / Streamlit Cloud-ready |

## 📝 Requirements

See `requirements.txt` for all dependencies:
```
openpyxl>=3.0.0      # Excel file handling
pandas>=2.0.0        # Data manipulation
matplotlib>=3.0.0    # Static plotting
seaborn>=0.12.0      # Statistical visualization
streamlit>=1.28.0    # Interactive dashboard
plotly>=5.0.0        # Interactive charts
```

## 🚢 Deployment

### Local Development
```bash
streamlit run dashboard_streamlit.py
```

### Production on Streamlit Cloud
1. Push code to GitHub
2. Deploy at https://streamlit.io
3. Share interactive link with stakeholders

### Docker (Optional)
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["streamlit", "run", "dashboard_streamlit.py", "--server.port=8501"]
```

## 📄 License & Attribution

Dataset: [Kaggle - Sample Pharmaceutical Drug](https://www.kaggle.com/datasets/jewelzufo/sample-pharmaceutical-drug)

## 👨‍💼 Getting Help

For questions or feature requests, open an issue on GitHub or reach out to the repository owner.

---

**Ready to explore the data?**  
Run `streamlit run dashboard_streamlit.py` and start analyzing pharmaceutical sales! 🚀
