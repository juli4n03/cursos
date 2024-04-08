library("here")

require("here")

if (!require("here")) {
  print("A")
  # install.packages("here")
}

print("A")

library(datasets)
data(iris)
summary(iris)