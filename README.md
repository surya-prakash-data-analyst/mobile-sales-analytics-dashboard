# Mobile Sales Analytics Project

**Auto-generated project package** — contains data, sample visuals, a PDF report, and example files to showcase a Mobile Sales Analytics project suitable for recruiters.

## Project structure
- `data/` - original uploaded files and CSV exports of Excel sheets. Includes the Power BI `.pbix` file if provided.
- `images/` - PNG visualizations generated from the data.
- `reports/` - a compiled PDF report: `Mobile_Sales_Analytics_Report.pdf`.
- `notebooks/` - placeholder Jupyter notebook (sample instructions).
- `scripts/` - example script to reproduce visuals.
- `README.md` - this file.

## How I generated this package
- Read the provided Excel file: `Mobile Sales Data.xlsx` (sheets: Sheet1).
- Created basic visualizations (monthly trend, sales by region, top products, quantity distribution) where possible.
- Compiled visuals into a PDF report.

## Quick start (reproduce locally)
```bash
# Requirements (example)
pip install pandas matplotlib reportlab

# Run the example script to reproduce visuals
python scripts/generate_visuals.py --input data/"Mobile Sales Data.xlsx"
```

## Notes for recruiters
- This package is intended as a starter showcase. For a full deliverable, include a cleaned notebook (`.ipynb`), Power BI exported images, and detailed methodology in `reports/`.

---
Generated automatically.
