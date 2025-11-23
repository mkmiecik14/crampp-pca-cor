# Computing zero-order correlations for the CRAMPP PCA Project

This repository details the instructions for computing zero-order correlations
for the measures used in the principal component analysis (PCA) in the publication:

Kmiecik, M. J., Tu, F. F., Clauw, D. J., & Hellman, K. M. (2023). 
Multimodal Hypersensitivity Derived from Quantitative Sensory Testing Predicts 
Pelvic Pain Outcome: an Observational Cohort Study. _PAIN, 164_(9), 270-283. 
http://dx.doi.org/10.1097/j.pain.0000000000002909

## Step 1

clone this git repository:

```
git clone https://github.com/mkmiecik14/crampp-pca-cor.git
```

## Step 2

Copy data with the `*-pca-data.csv` suffix from The Open Science Framework project:
https://osf.io/gd2z3/files and place in the `data/` directory.

## Step 3

Source the R script `compute-corr.R` to generate data files in `output/` with 
correlations, data, etc.

```
Rscript src/compute-corr.R
```

