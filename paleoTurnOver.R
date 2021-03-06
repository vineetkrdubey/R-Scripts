library(paleobioDB)
library(codyn)

## dados = paleobioDB::pbdb_occurrences(limit="all",vocab="pbdb",base_name="Mammalia",show=c("phylo","indent"))
## dados2 = dados[dados[,c('taxon_name')]!='Delphinidae indet.',]
## riq = paleobioDB::pbdb_richness (dados,rank='species', res=1, temporal_extent=c(0,3))


data.delph <-  pbdb_occurrences (limit="all", vocab="pbdb",base_name="Cetacea", show=c("phylo","coords","ident"))
#data.delph2 = data.delph[data.delph$taxon_name!='Delphinidae indet.',] 
pbdb_richness (data.delph, rank="species", res=3, temporal_extent=c(0,66))
pbdb_orig_ext (data.delph, rank="genus", temporal_extent=c(0,66), res=2,orig_ext=1)
pbdb_orig_ext (data.delph, rank="genus", temporal_extent=c(0,66), res=2,orig_ext=2)

pbdb_map_richness(data.delph,rank='genus', res=10)

x =  data.delph[ data.delph$late_age<25 & data.delph$late_age>20,]
y =  data.delph[ data.delph$late_age<20,]
z =  data.delph[ data.delph$early_age>50,]

pbdb_map_richness(z,rank='genus', res=10)

x.esp
x.ext


canidae<-  pbdb_occurrences (limit="all", vocab="pbdb",base_name="Canidae", show=c("phylo", "ident"))
canidae<-  pbdb_occurrences (limit="all", vocab="pbdb",base_name="Canidae", show=c("phylo", "ident"))


pbdb_orig_ext (canidae, rank="genus", temporal_extent=c(0, 10),res=1, orig_ext=1)
pbdb_orig_ext (canidae, rank="species", temporal_extent=c(0, 10),res=1, orig_ext=2)

data.delph[data.delph[,"early_age"]>25,c("genus","early_age")]


###
data.delph <-  pbdb_occurrences (limit="all", vocab="pbdb",base_name="Cetacea", show=c("phylo", "ident"))
data2 = data.frame(genus=data.delph$genus,early_age=data.delph$early_age)
data2 = data2[complete.cases(data2),]

data.new = data.frame()
nomesUnicos = unique(data2$genus)

for (i in 1:length(nomesUnicos)){
    nomesUnicos[i]
    x = data2[data2$genus==nomesUnicos[i],]
    x.first = x[x$early_age==max(x$early_age),]
    data.new = rbind(data.new,x.first[1,])
}



data.new = data.frame()
nomesUnicos = unique(data2$genus)
for (i in 1:length(nomesUnicos)){
    nomesUnicos[i]
    x = data2[data2$genus==nomesUnicos[i],]
    x.first = x[x$early_age==min(x$early_age),]
    data.new = rbind(data.new,x.first[1,])
}



