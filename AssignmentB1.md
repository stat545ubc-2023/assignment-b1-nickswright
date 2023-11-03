AssignmentB1_Markdown
================
Nick
2023-11-03

### Function

``` r
#Function
data_summary <- function(data, x, y, nar.rm=TRUE) {
  numeric_var <- deparse(substitute(y))
   if(!is.numeric(data[[numeric_var]])) {
     stop('Sorry this function does not work if Y is not numeric')
   }
    data |>
    group_by({{x}}) |>
    summarize(
      mean = mean({{y}}, na.rm = TRUE),
      sd = sd({{y}}, na.rm = TRUE),
      IQR = IQR({{y}}, na.rm = TRUE))
}

#' Data Summary Function
#' Description: This function groups a numeric variable "y" by a different variable "x" and then provides the mean, standard deviation, and interquartile range of "y" for each category or value of "x". This function removes NA values and will produce an error message if "y" is not numeric data. This function is useful for quickly generating several important summary statistics for data exploration. 
#' @param data A data frame with at least 2 columns.
#' @param x A variable of any class.
#' @param y A numeric variable.
#' @param nar.rm NA points will not cause an error, but they will be removed. 
#'
#' @return the mean, standard deviation, and interquartile range of variable y, grouped by variable x.
#' 
#' @export
#'
#' @examples
example_data <-  data.frame(Group = c("A", "A", "B", "B"),
    Value = c(10, 20, 20, 40))
data_summary(example_data, Group, Value)
```

    ## # A tibble: 2 × 4
    ##   Group  mean    sd   IQR
    ##   <chr> <dbl> <dbl> <dbl>
    ## 1 A        15  7.07     5
    ## 2 B        30 14.1     10

#### Examples

``` r
data_summary(flow_sample, extreme_type, flow)
```

    ## # A tibble: 2 × 4
    ##   extreme_type   mean     sd   IQR
    ##   <chr>         <dbl>  <dbl> <dbl>
    ## 1 maximum      212.   61.7   80   
    ## 2 minimum        6.27  0.965  1.26

This function is grouping the flow_sample data by extreme type
(categorical variable) and then providing summary statistics of the
flows (numerical variable) within each category.

``` r
data_summary(penguins, species, body_mass_g)
```

    ## # A tibble: 3 × 4
    ##   species    mean    sd   IQR
    ##   <fct>     <dbl> <dbl> <dbl>
    ## 1 Adelie    3701.  459.  650 
    ## 2 Chinstrap 3733.  384.  462.
    ## 3 Gentoo    5076.  504.  800

This function is grouping the penguins data by penguin species
(categorical variable) and then providing summary statistics of the body
mass in grams (numeric variable) within each category.

``` r
data_summary(mtcars, cyl, wt)
```

    ## # A tibble: 3 × 4
    ##     cyl  mean    sd   IQR
    ##   <dbl> <dbl> <dbl> <dbl>
    ## 1     4  2.29 0.570 0.737
    ## 2     6  3.12 0.356 0.618
    ## 3     8  4.00 0.759 0.481

This function is grouping the mtcars data by number of cylinders
(numerical variable) and then providing summary statistics of the weight
(numerical variable).

``` r
#data_summary(penguins, species, islands)

#When I run this function I receive this message "Error in data_summary(penguins, species, islands) :
#Sorry this function does not work if Y is not numeric"
```

I attempted to run this function with a categorical variable (islands)
for Y and received the expected error message.

### Testing

I created a data frame for testing.

``` r
  df <- data.frame(
    Group = c("A", "A", "B", "B", "C", "C"),
    Value = c(10, 20, 5, 15, 30, NA)
  )
```

Testing categorical variable for x and numeric variable for y, expecting
3 rows.

``` r
test_that("Testing valid data", {
  result <- data_summary(df, Group, Value)
  expect_is(result, "data.frame")
  expect_equal(nrow(result), 3)
})
```

    ## Test passed 🥇

Testing categorical variable for x and numeric variable for y with NA
values, expecting 3 rows.

``` r
test_that("Testing valid data with NA", {
  result <- data_summary(df, Group, Value)
  expect_is(result, "data.frame")
  expect_equal(nrow(result), 3)
})
```

    ## Test passed 🎉

Testing categorical variable for X and categorical variable for Y,
expecting an error. To do this I created a new data frame with only
categorical variables.

``` r
test_that("data_summary handles non-numeric 'y'", {
  df2 <- data.frame(
    Group = c("A", "A", "B", "B", "C", "C"),
    Value = c("X", "Y", "Y", "X", "Z", "Y")
  )
  expect_error(data_summary(df2, Group, Value))
})
```

    ## Test passed 😸
