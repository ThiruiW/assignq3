## code to prepare `bank` dataset goes here

usethis::use_data(bank, overwrite = TRUE)
# Load the bank dataset
bank <- read.csv("data/bank.csv", header = TRUE)

# Save the prepared dataset into the package's data folder
usethis::use_data(bank, overwrite = TRUE)
