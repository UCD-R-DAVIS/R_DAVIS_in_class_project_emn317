x <- 1:10
x
c(1:10)

x + 3

x * 10
x / 10

y <- 100:109

x + y

z <- 1:2 # z will repeat to fill x or y because there are less values in z
z

x + c(1,2,1,2,1,2,1,2,1,2)

x + z

cbind(x,y,x+y)

z <- 1:3
x + z # 3 is not a vector of 10, still executes the function best it can

a <- x + z
a

x[c(TRUE, FALSE)] # recycling TRUE FALSE vector ; FALSE (F) means value is not used in data set
x[c(T,F,T,F,T,F,T,F,T,F)]
x

# ----


NA
NaN
# NA and NaN are the same
# 'NA' is just a string and not special value

heights <- c(2,4,4,NA,6)
mean(heights) # NA is result when NA is in value set
max(heights)  # NA is result when NA is in value set

mean(heights, na.rm = T) # removes all NA values
mean(heights, na.rm = F)

is.na # is this value NA or not
is.na(heights)
!is.na # is not

heights[is.na(heights)] # NA returns true
heights[!is.na(heights)] # inverts Ts and Fs

heights

# ---- 


# lists are a type of vector
# lists are combined objects

list(4, 6, 'dog')
list(4, letters, 'dog') # letters = all letters of alphabet

my_list <- list(4, letters, 'dog')
class(my_list) # class is type of list
str(my_list) # structure of list
length(my_list) # number of elements ; not the length of list elements themselves
length(my_list[[2]]) # double brackets extract individual elements ; length in this case will show number of elements in 2 which is number of letters in alphabet
my_list[[2]] # shows all of the individual values in 2



# data frames are columns of variables (R version of a spreadsheet)

letters
data.frame(letters) # shows alphabet in column 
# letters are no longer strings (not in quotations)

my_df <- data.frame(letters)
length(my_df) # columns
dim(my_df) # dim is dimension; rows , columns
my_df2 <- data.frame(letters, letters)
my_df2
dim(my_df2) # 26 rows , 2 columns
# number of rows listed on left does not count as a column

data.frame(letters, 1) # adds a column of 1s
data.frame(letters, 1:2) 
data.frame(letters, x = 1) # gives name to second column



# matrices are used for numbers, sometimes characters

matrix(nrow = 10, ncol = 10) #nrow is number of rows and #ncol is number of columns
matrix(1:10, nrow = 10, ncol = 10) # fills will numbers ; How?

matrix(c(2, 4), nrow = 10, ncol = 10)
my_matrix <- matrix(1:10, nrow = 10, ncol = 10)
my_matrix[1,]
my_matrix[2,1] # 2nd row, 1st column
my_matrix[c(2,1), c(2,1)]


# an array stores data in more dimensions than rows and columns ; add height

# array[x, y, z]
# array[,,]



# ----

response <- factor(c('no', 'yes', 'maybe', 'no', 'no', 'maybe', 'no'))
class(response)
levels(response) # gives you the different kinds of values
nlevels(response) # gives you number of different values
str(response) # class, nlevels, levels, number respective to each of the levels
typeof(response) # class is factor, typeof uses how R is thinking about this data
response <- factor(response, levels = c('no', 'yes', 'maybe'))
str(response)
response # not characters anymore

as.character(response) # considers the values as characters
year_fact <- factor(c(1900, 1983, 1977, 1998, 1900))
year_fact
as.numeric(year_fact)
as.numeric(as.character(year_fact))

levels(response)[1] <- "NO" # changed lowercase no to uppercase      
levels(response)

levels(response) <- c("NO", "YES", "MAYBE")
levels(response) # changes multiple values to uppercase


# ----


surveys <- read.csv("data/portal_data_joined.csv")
surveys
class(surveys) # data frame = spreadsheet
nrow(surveys)
ncol(surveys)
dim(surveys) # rows and columns

head(surveys) # index data frame from the top; all columns but 6 rows (6 is default)
head(surveys[1:6])
head(surveys, n=1) # shows just 1 row
tail(surveys) # bottom of values

View(surveys) # opens data frame as a spreadsheet ; not recommended

head(surveys)
colnames(surveys) # column names as strings
rownames(surveys) # set of numbers as strings

str(surveys)
summary(surveys) # generic function ; every column but processes rows by different functions like mean median


# ----


surveys <- read.csv('data/portal_data_joined.csv')
surveys[1, 1] # first row and first column
surveys[1, 6] # first row, 6th column
head(surveys, 1)

surveys[, 1] # everything in first column
surveys[1,] # everything in first row

surveys[1] # column NOT a row by default # rec dont do this

surveys[1:3, 7] # first 3 rows of 7th column

surveys[3,] #3rd row

head_surveys <- surveys[1:6, ]
head_surveys
surveys[-c(7:34786), ] # get rid of all rows except first 6 ; same as surveys [1:6,]

surveys[, -1] # everything except the first column


surveys["species_id"] # particular column selected
surveys[, "species_id"] # returns a vector, all values shown
surveys[["species_id"]] # same as above

surveys[c("species_id", "plot_type")] # 2 column data frame
surveys[[c("species_id", "plot_type")]] # doesnt work! ; double bracket means looking for specific item

surveys$species_id # vector of species IDs ; same as give us second column but specified by name and less confusing





