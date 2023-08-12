# `useQueryBuilder`

useQueryBuilder


## Description

Make a call to `useQueryBuilder` in your ui code to load the
 required dependencies for the queryBuilder and optionally specify the
 bootstrap version to use.


## Usage

```r
useQueryBuilder(bs_version = c("3", "4", "5"))
```


## Arguments

Argument      |Description
------------- |----------------
`bs_version`     |     The version of bootstrap to use with the builder. Possible values are "3", "4" or "5"


## Value

list. html dependency for queryBuilderBinding.
 See [`htmltools::htmlDependency()`](https://rstudio.github.io/htmltools/reference/htmlDependency.html) for further information.


