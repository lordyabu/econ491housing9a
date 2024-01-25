##-----------------------------------------------------------------------------
# ECON 491
# Illakkia Ranjani
# Part 1
##-----------------------------------------------------------------------------

rm(list = ls())
setwd("C:/Users/illak/OneDrive/Classes/spring 24/ECON 491")

housing <- read.csv("train.csv")

##-----------------------------------------------------------------------------

colSums(is.na(housing))

# Most variables have 0 missing values. 
# LotFrontage has 259
# Alley has 1369
# MasVnrType has 8
# MasVnrArea has 8
# BsmtQual has 37
# BsmtCond has 37
# BsmtExposure has 38
# BsmtFinType1 has 37
# BsmtFinType2 has 38
# FireplaceQu has 690
# GarageType has 81
# GarageYrBlt has 81
# GarageFinish has 81
# GarageQual has 81
# GarageCond has 81
# PoolQC has 1453
# Fence has 1179
# MiscFeature has 1406

#0s
#MasVnrArea
#BasementFinSF1
#BasementFinSF2
#BasementUnfSF
#TotalBsmntSF
#X2ndFlrSF
#LowQualFinSF

#Bin

Correlation between OverallQual and GarageCars: 0.60
Correlation between OverallQual and SalePrice: 0.79
Correlation between YearBuilt and GarageYrBlt: 0.83
Correlation between YearRemodAdd and GarageYrBlt: 0.64
Correlation between BsmtFinSF1 and BsmtFullBath: 0.65
Correlation between TotalBsmtSF and 1stFlrSF: 0.82
Correlation between TotalBsmtSF and SalePrice: 0.61
Correlation between 1stFlrSF and SalePrice: 0.61
Correlation between 2ndFlrSF and GrLivArea: 0.69
Correlation between 2ndFlrSF and HalfBath: 0.61
Correlation between 2ndFlrSF and TotRmsAbvGrd: 0.62
Correlation between GrLivArea and FullBath: 0.63
Correlation between GrLivArea and TotRmsAbvGrd: 0.83
Correlation between GrLivArea and SalePrice: 0.71
Correlation between BedroomAbvGr and TotRmsAbvGrd: 0.68
Correlation between GarageCars and GarageArea: 0.88
Correlation between GarageCars and SalePrice: 0.64
Correlation between GarageArea and SalePrice: 0.62
orrelation of TotalBsmtSF with SalePrice: 0.61
Correlation of 1stFlrSF with SalePrice: 0.61
Correlation of FullBath with SalePrice: 0.56
Correlation of TotRmsAbvGrd with SalePrice: 0.53
Correlation of YearBuilt with SalePrice: 0.52
Correlation of YearRemodAdd with SalePrice: 0.51
Correlation of GarageYrBlt with SalePrice: 0.49
Correlation of MasVnrArea with SalePrice: 0.48
Correlation of Fireplaces with SalePrice: 0.47
Correlation of BsmtFinSF1 with SalePrice: 0.39
Correlation of LotFrontage with SalePrice: 0.35
Correlation of WoodDeckSF with SalePrice: 0.32
Correlation of 2ndFlrSF with SalePrice: 0.32
Correlation of OpenPorchSF with SalePrice: 0.32
Correlation of HalfBath with SalePrice: 0.28
Correlation of LotArea with SalePrice: 0.26
Correlation of BsmtFullBath with SalePrice: 0.23
Correlation of BsmtUnfSF with SalePrice: 0.21
Correlation of BedroomAbvGr with SalePrice: 0.17
Correlation of ScreenPorch with SalePrice: 0.11
Correlation of PoolArea with SalePrice: 0.09
Correlation of MoSold with SalePrice: 0.05
Correlation of 3SsnPorch with SalePrice: 0.04
Correlation of BsmtFinSF2 with SalePrice: -0.01
Correlation of BsmtHalfBath with SalePrice: -0.02
Correlation of MiscVal with SalePrice: -0.02
Correlation of Id with SalePrice: -0.02
Correlation of LowQualFinSF with SalePrice: -0.03
Correlation of YrSold with SalePrice: -0.03
Correlation of OverallCond with SalePrice: -0.08
Correlation of MSSubClass with SalePrice: -0.08
Correlation of EnclosedPorch with SalePrice: -0.13
Correlation of KitchenAbvGr with SalePrice: -0.14
[ ]: