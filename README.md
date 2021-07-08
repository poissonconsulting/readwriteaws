
## readwriteaws

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Overview

This package is designed for Poisson employees to easily access our
files within our AWS s3 buckets. The general workflow for this package
is:  
1. Get the list of files  
2. Download them to your local drive  
3. Use them as normal

## Installation

To install the latest version from
[GitHub](https://github.com/poissonconsulting/usepois)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/readwriteaws")
```

## Credentials

Credentials need to be set up properly so you have permission to access
AWS. It is recommended to put the credentials in your .Renviron file.
The names of the variables must match below or you will not be
authenticated. Both region arguments must be present.

    AWS_ACCESS_KEY_ID=GET_FROM_AWS_USER
    AWS_SECRET_ACCESS_KEY=GET_FROM_AWS_USER
    AWS_REGION=ca-central-1
    AWS_DEFAULT_REGION=ca-central-1

## Examples

## How to Contribute

Please report any
[issues](https://github.com/poissonconsulting/readwriteaws/issues).

[Pull requests](https://github.com/poissonconsulting/readwriteaws/pulls)
are always welcome.

Please note that the readwriteaws project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
