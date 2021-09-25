##the below code creates everal objects with specified values these objects are vectors with one element or one dimension
a=2+2
a
b=8-5
b
d=a*b
d
r=3
r^2
pi*r^2

##this creates a vector
v1=c(12,5,6,10,8,24,36,10,18,3)
v1
v2=c('yellow perch','largemout bass','rainbow trout',
     'lake whitefish','northern pike')
v2
##to create sequences of numbers
years=1990:2007
years
#or
v4=seq(1990,2007)
v4
# can create sequences with different increments third argument is increment of 2
v5=seq(1,20,2)
v8=seq(1,10)
#to create a repeat of a sequence ex 1,2,3,4,5
v6=rep(1:5,3)
v=6
##if you want to repeat each elemnt of sequence 3 times
v7=rep(1:5,each=3)
v7

#matricies with numbers 1-2 4 rows and 5 columns
m1=matrix(1:20,nrow=4,ncol=5)
m1
##if you want on by row basis vs column basis
m2=matrix(1:20,nrow=4,ncol=5,byrow=T)
m2
#to bind matricies together
m3=cbind(v5,v5)
m3
## to bind across rows
m4=rbind(v5,v5)
m4

## to create an array with 3 rows 2 colums and 4 matricies
a1=array(1:24,dim=c(3,2,4))
a1

##to create a data frame
df1=data.frame(v2,v8,v5)
df1
df2=data.frame(species=v2,ID=v8,count=v5)
df2
ls1=list(species=v2,ID=v8,count=v5)
ls1

##if you want to pull out certain certain data like row 3 and column 5
v1[3:5]
##all rows of 3rd column
m1[,3]
###array want 3rd row of 4th dimension
a1[,,4]

##if you want first column of data fram
df1.name[,1]
df1.name$species
df1.name['species']

#to add a new string of numbers to a data frame
df1.name$new=1:10
df1.name$logcount=log(df1.name$count)

##import data
##spaces in header names will have . in place of space. also look out for multiple decimal places 
##missing data is signified by NA if you need to remove missing data, na.strings='.'
##in() you can put the directory in to reference the file but you have to change backslashes to forward slashes and also include file name at the end and 
##you can hit command F to find and replace 
##setwd() will create a working directory
##you can can also set working directory through session at the top
setwd(Macintosh HD/Users/chrissmith/Desktop/Graduate School/Spring 2021/Quantatitive Techniques/Labs/Lab 1)
df.lakes=read.csv('df.lakes.csv',na.strings='.')
df.lakes
##say you just want a couple of rows
df.lakes[4:6,]
##if you want to put in condition of depth greater than 3
df.lakes[df.lakes$s.depth>3,]
#depth greater than 3 and phosphorous greater than 20
df.lakes[df.lakes$s.depth>3&df.lakes$P<20,]
##3this is to search for an or situation searching with depth >3 or county is 2 this will be a bigger net
df.lakes[df.lakes$s.depth>3|df.lakes$county==2,]
##depth greater than 3 or county =1 and phosphorous less than 20
df.lakes[df.lakes$s.depth>3|df.lakes$county==1&df.lakes$P<20,]
#creating a subset and dont need $ because you are telling r where to look withP<20 can also include code above for any of the subsets tou want to pull out
subset(df.lowPlakes,P<20)

##headder info
names(df.lakes)
##how many rows
length(df.lakes$s.depth)
#dimensons tells you rows and columns
dim(df.lakes)
##mean
mean(df.lakes$s.depth)
##variance
var(df.lakes$s.depth)
##summary output of info
summary(df.lakes)
##missing values can be an issue and in our P data there is something missing so use na.rm=T
mean(df.lakes$P,na.rm=T)
##if you want a mean P on a county by county basis. first argument is what item you want mean of, second is what grouping you want, and 3rd argument is what test you want e.g mean 
tapply(df.lakes$P, df.lakes$county,mean,na.rm=T)
##other way of doing this and creating a dataframe for it
aggregate(df.lakes['P'],list(county=df.lakes$county),mean,na.rm=T)

##doing this through dplyr
df.lakes%>%group_by(county)%>%summarize(mean=mean(P,na.rm=T))%>%as.data.frame()

######user defined functions x is placeholder variable name this is what you will need for homework
sqr=function(x){x^2}
sqr(v1)
sum_sqr=function(x){
  s=x*x
  sum(s)
}

######looping is when you want to repeat a line of code i is what you want to loop stay away from variable name youre already using then put values for how many times you want to run 1:10 is 10 times
for (i in 1:10) {
  print(i^2)
}
##to save these to the console code is saying create numeric vector with 10 spots
output=numeric(10)
for (i in 1:10) {
  output[i]=i^2
}
output


##say you have fish lengths 50-200 and you want to classify by size is less than 125 than its small if larger than its big. this works on vectors where will run through and apply statement
lengths=50:200
lengths
ifelse(lengths<125,'small','big')

#single value is test equals 1 print to console add else if you want to cover both possibilities
test=0
if(test==1)print('test equals1') else print('test not equal to 1')

##plotting
graphing=read.csv(file.choose())
##to create a pop-out window; h and w control how large the output chart is so you can adjust for a paper; quartz is the function for a popoput
###the output for just graphing$x is just raw output
quartz(h=9,w=6.5)
plot(graphing$x)

quartz()
plot(graphing$x,graphing$y)
##another way of running it
plot(y~x, data=graphing)

##if you have a categorical variable (first code not working)
quartz()
plot(x~group,data=graphing)

quartz()
boxplot(x~group, data=graphing)

##histogram
hist(graphing$x)

##barplot
barplot(graphing$x)
##tapply gives means
group_means=tapply(graphing$x,graphing$group,mean)
barplot(group_means)
## to add box around plot
box()

##this code is to change area of the plot; ylim first # min y axis range second is max
barplot(group_means, ylim=c(0,15))
box()

##this will show all possible combinations, but will not work with categorical variables to have to remove; [] first argumet second is columns
quartz()
pairs(graphing[,1:3])

##to change labels
plot(y~x, data=graphing,xlab='X Label Here', ylab='Y Label Here', main='Figure Title',ylim=c(0,100),xlim=c(-10,40))
##to add a line
abline(h=group_means)

###to be able to identify which group youre looking at in the chart you add another argument pch is the character style you want to plot. repeat function repeats vector c(1,19) that you create and each defines how many times you want to repeat  
plot(y~x, data=graphing,xlab='X Label Here', ylab='Y Label Here', main='Figure Title', pch=rep(c(1,19),each=25))
y_means=tapply(graphing$y,graphing$group,mean)
##to add a line
abline(h=y_means)

##you can also group by
plot(y~x, data=graphing,xlab='X Label Here', ylab='Y Label Here', main='Figure Title', pch=graphing$group)

###if else is saying if group is =a then ; this works to select data points and color them based on their title 
plot(y~x, data=graphing,xlab='X Label Here', ylab='Y Label Here', main='Figure Title', pch=ifelse(graphing$group=='a',1,19))
y_means=tapply(graphing$y,graphing$group,mean)
##to add a line
abline(h=y_means)
##this is taking your x data and squaring it and adding a line
lines(0:20,0.2*(0:20)^2)
##to add text first line x second y
text(9,40,'text')
points(0:20,0.2*(0:20)^2,pch=15)

## to create a box with mutiple plots in it ; 2,2 is the columns by rows so 2:2
quartz()
par(mfrow=c(2,2))
plot(graphing$x)
plot(graphing$z,graphing$y)
boxplot(graphing$x~graphing$group)
hist(graphing$x)

##more flexible way of doing this; have to create a matrix and tell it where to put plots; so this is a 4 spot matrix with 2 rows and 2 columns
quartz()
layout(matrix(1:4,nrow=2,ncol=2,byrow=T))
plot(graphing$x)
plot(graphing$z,graphing$y)
boxplot(graphing$x~graphing$group)
hist(graphing$x)

##to add more columns can control where these figures go 1,1,2,2 is top row
quartz()
layout(matrix(c(1,1,2,2,0,3,3,0),nrow=2,ncol=4,byrow=T))
plot(graphing$x)
plot(graphing$z,graphing$y)
boxplot(graphing$x~graphing$group)


rnorm
