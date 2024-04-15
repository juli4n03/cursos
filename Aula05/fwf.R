require("readr")
require("here")

write_lines(
"
Fisher  R.A.      1890 1962
Pearson Karl      1857 1936
Cox     Gertrude  1900 1978
Yates   Frank     1902 1994
Smith   Kirstine  1878 1939",
file = "./exemplo_fwf_01.txt")

exemplo01 <- "./exemplo_fwf_01.txt"

# exemplo01 <- here("Aula05", "dados/exemplo_fwf.txt")
print(exemplo01)

exemplo_01_fwf <- read_fwf(
    exemplo01,
    fwf_empty(
        exemplo_01_fwf,
        col_names = c("Last_Name", "First_Name", "Birth_Date", "Death_Date")
    )
)

print(exemplo_01_fwf)


exemplo_02_fwf <- read_fwf(
    exemplo01,
    fwf_cols(
        Last_Name = 8,
        First_Name = 12,
        Birth_Date = 5,
        Death_Date = 8
    )
)

print(exemplo_02_fwf)
