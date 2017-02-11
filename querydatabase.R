#   THIS IS A SHORT SCRIPT TO QUERY STRINGS IN ONE DATA FRAME AGAINST A LARGER DATABASE AND RETREIVE 
#   CORRESPONDING VALUES FROM A DIFFERENT COLUMN IN THE DATAFRAME
#   THIS EXAMPLE EXTRACTS SIGNIFICANT COOCURRING OTUS FROM A LARGER SET OF OTUS

#IMPORT DATA INTO R ENVIORNMENT
#TABLE IS THE DATABASE
#NAME IS THE QUERY NAMES

otu_database <-read.table("otu_names_taxonomy.txt",header=T, sep="\t")
otu_query <-read.table("test_name.txt",header=T, sep="\t")

#SET COUNTING VARIABLES TO 0

x = 0
y = 0

#CREATE EMPTY MATRIX WITH TWO COLOUMNS AND AS MANY ROWS AS THERE ARE QUERIES
matrix(nrow = length(otu_query$Name), ncol = 2) -> otu_query_taxonomy

#EMBEDDED FOR LOOPS WITH AN IF STATEMENT SEQUENTIALLY TESTING IF THE QUERY STRING IS IN THE DATABASE

for(i in otu_query$Name){
  y = y+1
  x = 0
  for(a in otu_database$OTU.ID){
    x = x+1
    if(as.character(i) == as.character(otu_database$OTU.ID[x])){
      otu_query_taxonomy[y,1] <- i
      otu_query_taxonomy[y,2] <- as.character(otu_database$taxonomy[x])

    } 
      
  }
}

#EXPORT TABLE

write.table(otu_query_taxonomy, file = "otu_query_taxonomy.txt", sep = "\t")

