library(datasets)
library(purrr)
library(dplyr)
library(glue)


var_summary <- function(data, var, ...) {
  cnt_auxiliar = count(data)
  res <- data %>%
    group_by(...) %>%
    summarise(
      "{{var}}_part" := n(),
      "{{var}}_part_perc" := n()/cnt_auxiliar,
      "{{var}}_min" := min({{ var }}),
      "{{var}}_max" := max({{ var }}),
      "{{var}}_avg" := mean({{ var }})
    )

  return(res)
}

res_width <- var_summary(iris, Petal.Width, Species)
res_length <- var_summary(iris, Petal.Length, Species)
