library(readxl)

Hawthorne <- read_excel("data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx",
                        sheet = "Hawthorne", skip = 1)

Steel <- read_excel("data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx",
                        sheet = "Steel", skip = 1)

Tilikum <- read_excel("data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx",
                        sheet = "Tilikum", skip = 1)

#BLAHBLAHBLAH
