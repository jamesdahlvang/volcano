#creating volcano plot for biolegend screen pre and post expansion
#started by jd 2/26/22 at 4:49 pm
#ended by jd 3/27/22 at 2:52 pm

library(ggplot2)
library(ggrepel)
setwd("~/Desktop/ADCC Paper")

#read in data
data <- read.csv("d0d13_biolegend.csv", header = TRUE)

# add a column of NAs
data$diffexpressed <- "No Change"
# if log2Foldchange > 0.6 and pvalue < 0.05, set as "UP" 
data$diffexpressed[data$Log2FC > 0 & data$NegLog10AdjP > 1.0301] <- "Up"
# if log2Foldchange < -0.6 and pvalue < 0.05, set as "DOWN"
data$diffexpressed[data$Log2FC < 0 & data$NegLog10AdjP > 1.0301] <- "Down"

#add column of NA
data$delabel <- NA
#comment out code below to show only significant marker names
# data$delabel <- data$Marker
# comment out code below to show all marker names
data$delabel[data$diffexpressed != "No Change"] <- data$Marker[data$diffexpressed != "No Change"]

# Finally, we can organize the labels nicely using the "ggrepel" package and the geom_text_repel() function
# plot adding up all layers we have seen so far
ggplot(data=data, aes(x=Log2FC, y=NegLog10AdjP, col=diffexpressed, label=delabel)) + 
  geom_point() + 
  theme(legend.key = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), panel.background = element_blank(),
        axis.line = element_line(colour = "black")) +
  geom_text(size = 0.1) +
  geom_text_repel(max.overlaps = Inf) +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_hline(yintercept=1.0301, col="red")
