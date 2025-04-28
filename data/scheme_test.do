EUI-YouGov individual.dta
* Stata Question 4 - EUI YouGov Dataset
clear all
set more off

* Open dataset
use "EUI-YouGov individual.dta", clear

* Explore variables
describe
codebook immig_responsibility age gender education income trust_eu pol_interest
summarize immig_responsibility age gender education income trust_eu pol_interest

* Install and set scheme
net install schemepack, from("https://raw.githubusercontent.com/asjadnaqvi/stata-schemepack/main/") replace
set scheme cleanplots

* Logistic regression
logistic immig_responsibility age gender education income trust_eu pol_interest
estimate store EUIModel

* Coefficient plot
coefplot EUIModel, drop(_cons) xtitle(Odds Ratio) title(Immigration Responsibility - YouGov Data) levels(90) keep(age gender education income trust_eu pol_interest) xline(1) eform msymbol(S)

* Create regression table
ssc install outreg2
outreg2 using eui_results.doc, replace ctitle(EUI Logistic Regression) label

* Marginal effects
margins, dydx(*)
