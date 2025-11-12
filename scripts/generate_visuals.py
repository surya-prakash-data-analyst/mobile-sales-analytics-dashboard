# sample script: scripts/generate_visuals.py
# Usage: python generate_visuals.py --input "../data/Mobile Sales Data.xlsx"
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

def main(path_str):
    path = Path(path_str)
    xls = pd.ExcelFile(path)
    df = xls.parse(xls.sheet_names[0])
    # Minimal example: total sales by product (if columns exist)
    df.to_csv('data/sample_export.csv', index=False)
    print('Saved sample_export.csv')

if __name__ == '__main__':
    import sys
    inp = sys.argv[1] if len(sys.argv)>1 else '../data/Mobile Sales Data.xlsx'
    main(inp)
