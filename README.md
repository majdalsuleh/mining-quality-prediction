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
  between real results). These hours are flagged and never used as model answers.
  The model only sees the last *real* lab result, because a straight-line fill uses a
  future value to draw the line.
- **Ore feed quality is only updated about every 13 hours**, so it is not a live reading.
- **% Iron Concentrate is excluded**, because it is measured by the lab at the same time
  as silica and would leak the answer.

## From raw data to model data
| Step | Rows | Why |
|---|---|---|
| Raw sensor readings | 737,453 | One row every 20 seconds |
| Averaged per hour | 4,097 | The lab reports silica hourly, so the model works hourly |
| Removed data before the 13-day gap | 3,948 | Time-based features must not jump across missing days |
| Kept only hours with a real next-hour result | 3,508 | Filled-in lab values are not used as answers |
| Removed first 23 hours | 3,485 | 24-hour averages need 24 hours of history |

## Findings so far
- **Quality changes by season.** Hours with high silica (above 2.82%, the worst 25%)
  were 32–34% of hours in April–May, only 14% in June, then rose again to 26–31% in
  August–September.
- **Bad quality comes in episodes**, often lasting a day or more, not single bad hours.
- **In high-silica hours**, tank levels in columns 4–5 are about 7% lower and amina flow
  is about 6.5% higher. These are associations, not causes: higher amina is likely
  operators reacting to rising silica.
- **No single sensor strongly predicts silica** (all within ±0.21 correlation), so a
  model has to combine many of them.

## Model setup
- **Task:** at the end of each hour, predict next hour's lab silica using only
  information available at that time.
- **Split by time, never shuffled:** train 29 March–30 June, validation July,
  test 1 August–9 September (about 810 hours, used once at the end).
- **Baseline to beat:** "same as the last known lab result". On the validation month it
  is off by 0.51 percentage points on average (MAE), versus 0.87 for always guessing
  the average.

## Project structure
```
notebooks/   01_explore, 02_sql, 03_features, 04_model
sql/         SQL queries, one business question per file
reports/     charts and the final one-page report
dashboard/   dashboard screenshots
```
The data files are not in the repo. Download the CSV from Kaggle into `data/` and run
the notebooks in order.

## Project status
- [x] Data exploration (`notebooks/01_explore.ipynb`)
- [x] SQL analysis (`notebooks/02_sql.ipynb`, `sql/`)
- [ ] Tableau dashboard (in progress: daily silica and monthly charts done)
- [ ] Prediction model (features and baseline done)
- [ ] Report