# mining-quality-prediction
# Predicting Silica Impurity in a Mining Flotation Plant

## Business question
A flotation plant separates iron ore from silica (sand). The lab measures silica in the
final product only once an hour, so by the time operators see bad quality, that batch
is already made.

1. **Can we predict next hour's silica from live plant sensors**, accurately enough to
   beat the simple guess "next hour = this hour"?
2. **Which plant settings are linked to higher or lower silica?**

**Why it matters:** high silica lowers the value of the product. An early warning lets
operators adjust before a bad batch is finished.

## Data
[Quality Prediction in a Mining Process](https://www.kaggle.com/datasets/edumagalhaes/quality-prediction-in-a-mining-process)
(Kaggle): about 737,000 sensor readings every 20 seconds, March to September 2017,
from a real plant.

## Key data issues found
- **13-day gap** with no data (16–29 March 2017). Only the continuous period after it is used.
- **About 11% of lab results look filled in** (copied forward or drawn as straight lines
  between real results). These hours are flagged and left out of model training and testing.
- **Ore feed quality is only updated about every 13 hours**, so it is not a live reading.
- **% Iron Concentrate is excluded**, because it is measured by the lab at the same time
  as silica and would leak the answer.

## Project status
- [x] Data exploration (`notebooks/01_explore.ipynb`)
- [ ] SQL analysis
- [ ] Power BI dashboard
- [ ] Prediction model
- [ ] Report