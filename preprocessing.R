tcall_df <- read.delim("Train_call.txt")
tcall_df <- as.data.frame(tcall_df)
# Save metadata
metadata <- tcall_df[1:4]

# Make subset w/o metadata, transpose it, and make as dataframe
tcall_sub <- subset(tcall_df, select = -c(Chromosome, Start, End, Nclone))
tcall_sub <- t(tcall_sub)
tcall_sub <- as.data.frame(tcall_sub)

# Read "Train_clinical.txt" and convert to dataframe
tclin_df <- read.delim("Train_clinical.txt")
tclin_df <- as.data.frame(tclin_df)
# Create a new column "Sample" containing the arrays. Then merge both dataframes by Sample
tcall_sub['Sample'] <- rownames(tcall_sub)
combo <- merge(tclin_df, tcall_sub, by="Sample")

# Set row names and get rid of Sample column
row.names(combo) <- combo$Sample
combo$Sample <- NULL

rocVarImp <- filterVarImp(Combo[,2:2835],y)
meanImp<-apply(rocVarImp, 1, mean)
sortedImp<-sort(meanImp,decreasing = T)


write.csv(combo, file = "combo.csv", row.names = TRUE)
