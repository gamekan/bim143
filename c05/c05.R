#' ---
#' title: "class 05 Intro to R graphics"
#' author: "Hong bo Che"
#' date: "Jan 24th, 2019"
#' utput: github_document
#' ---

#' class 05 R graphics intro

# my first box plot 

x <-  rnorm(1000,0) 

boxplot(x)
foo <- rnorm(10000, 0)
boxplot(foo) 
summary(x)
hist(x)
#+ fig.width=5, fig.height=5 
#affect below graph for next graph (WRONG place)
boxplot(x, horizontal = TRUE)
#' I have generated x and it has `r length(x)``

#' A script comment that includes **markdown** formatting.

#trouble summary statistics 

#the visual display of quantitative information 
  #good book!  
weight <- read.table("bimm143_05_rstats/weight_chart.txt", sep = '\t',header = TRUE)
weight
plot(weight$Age, weight$Weight, typ = "o",pch=15,cex =1.5, lwd = 2,ylim = c(2,10),xlab="Age(months)",
     ylab="Weight(kg)", main = 'Maine lab')
plot(weight$Age, weight$Weight, typ="o", 
     pch=15, cex=1.5:5.5, lwd=2, ylim=c(2,10), 
     xlab="Age (months)", ylab="Weight (kg)", 
     main="Baby weight with age", col = c('red','pink','yellow')) 
#ces recycles size without annotation, gimmicky
mouse <- read.table("bimm143_05_rstats/feature_counts.txt", sep = "\t" ,header = TRUE)
mouse
par(mar=c(3.1, 2.1, 4.1, 2)) # for margins , bott, left, top, right( 4 directions)
barplot(mouse$Count, ylab = "a", horiz = TRUE, names.arg = mouse$Feature, main="feature Count", las = 1)
par()$mar # ck


out <- c(rnorm(10000),rnorm(10000)+4)
hist(out, breaks = 100)
# color plots

maleFemale <- read.table("bimm143_05_rstats/male_female_counts.txt", sep = "\t", header = TRUE)
maleFemale
barplot(maleFemale$Count, names.arg= maleFemale$Sample, ylab = 'count', col=rainbow(nrow(maleFemale)), las = 2)

barplot(maleFemale$Count, names.arg= maleFemale$Sample, ylab = 'count', col = c("purple2","pink2"), las = 2)


# color by value

genes <- read.table("bimm143_05_rstats/up_down_expression.txt", sep = "\t", header = TRUE)
table(genes$State)
palette(c("blue", "gray","red"))
plot(genes$Condition1, genes$Condition2, col = genes$State, xlab = "con 1", ylab = "cond 2" )


#dynamic use coloring
meth <- read.table("bimm143_05_rstats/expression_methylation.txt", sep = "\t", header = TRUE)
dcols<- densCols( meth$gene.meth,meth$expression) 
plot (meth$gene.meth, meth$expression, ylab = "expression", xlab = "meth",  col = dcols, pch = 20)

gZeroExp <- meth$expression > 0
dcolsGZero <- densCols( meth$gene.meth[gZeroExp], meth$expression[gZeroExp])
plot (meth$gene.meth[gZeroExp],meth$expression[gZeroExp] , col = dcolsGZero, pch=20, ylab = "expression", xlab = "meth")

#ck ans
gZeroExp <- meth$expression > 0
dcols <- densCols(meth$gene.meth[gZeroExp], meth$expression[gZeroExp])
plot(meth$gene.meth[gZeroExp], meth$expression[gZeroExp], col = dcols, pch = 20)

#colramp
gZeroExp <- meth$expression > 0
dcols.custom <-  densCols(meth$gene.meth[gZeroExp], meth$expression[gZeroExp],
                          colramp = colorRampPalette(c("blue2",
                                                       "green2",
                                                       "red2",
                                                       "yellow")) )
plot(meth$gene.meth[gZeroExp], meth$expression[gZeroExp], 
     col = dcols.custom, pch = 20)


#color extension promotoer meth, gene meth
par(mar=c(3.1, 3.1, 4.1, 2))
plot(meth$promoter.meth, meth$gene.meth, xlab = "gene methylation", ylab = "promoter methylation")


plot(meth$promoter.meth, meth$gene.meth, ylab="Gene Methylation", xlab="Promoter Methylation")

# methylation stuff
source("bimm143_05_rstats/color_to_value_map.r")

mycols=map.colors(meth$expression, 
                  c(max(meth$expression), min(meth$expression)), 
                  colorRampPalette(c("blue","red"))(100))

plot(meth$promoter.meth, meth$gene.meth, 
     ylab="Gene Methylation", 
     xlab="Promoter Methylation", 
     col=mycols)

