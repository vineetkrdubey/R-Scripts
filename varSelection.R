library(raster)
library(MaxentVariableSelection)

projectFolder = '/home/anderson/Documentos/Minha produção bibliográfica/Sps artificiais/varSelection/'
sampleFolder = '/home/anderson/Documentos/Minha produção bibliográfica/Sps artificiais/Amostras/' #caminho para pasta onde as planilhas com os pontos amostrados sera salva
spOccData = list.files(path=sampleFolder, full.names=T, pattern='.csv') #lista com os enderecos dos mapas de distribuicao da sp
envVarFolder = "/home/anderson/PosDoc/dados_ambientais/dados_projeto/000" #pasta com as variaveis ambientais

# Load the occurrence records
occurrencelocations <-read.csv(spOccData[1],header=TRUE)
LonLatData <- occurrencelocations[,c(1,2)]
names(LonLatData) = c('lon','lat')
write.csv(LonLatData,file=paste(projectFolder,'spOcc.csv',sep=''),row.names=F)

predictors = stack(list.files(envVarFolder,pattern='asc')) #carregando as variaveis ambientais
predictors = mask(predictors,AmSulShape) #recortando as variaveis ambientais

VariablesAtOccurrencelocations <- extract(predictors,LonLatData)

Outfile <-as.data.frame(cbind("Fucusdistichus", LonLatData,VariablesAtOccurrencelocations))
colnames(Outfile) <-c("species","longitude","latitude",colnames(VariablesAtOccurrencelocations))



###


maxentPath = ("/home/anderson/R/x86_64-pc-linux-gnu-library/3.3/dismo/java/maxent.jar")

outdir = ("/home/anderson/Documentos/Minha produção bibliográfica/Sps artificiais/varSelection/res")

gridfolder = ("/home/anderson/PosDoc/dados_ambientais/dados_projeto/000")

occurrencelocations = (paste(projectFolder,'spOcc.csv',sep=''))

#criando ausencias para o background
#ausencias
pseudoausencia1 <- randomPoints(mask=predictors[[1]], n=nrow(LonLatData), p=LonLatData, excludep=TRUE) #este sera usado no loop para gerar ausencias de teste, la embaixo
pseudoausencia2 <- round(pseudoausencia1, digits=4)
pseudoausencia3<-pseudoausencia2[!duplicated(pseudoausencia2),]
pseudoausencia4<-pseudoausencia3[complete.cases(pseudoausencia3),]
pseudoausencia<-data.frame(pseudoausencia4)
colnames(pseudoausencia) <- c("longitude", "latitude")
write.csv(pseudoausencia,file=paste(projectFolder,'bg.csv',sep=''),row.names=F)
bg = (paste(projectFolder,'bg.csv',sep=''))

additionalargs="nolinear, noquadratic, noproduct, nothreshold, noautofeature"

contributionthreshold = 5

correlationthreshold = 0.7

betamultiplier = seq(1,10,2)

VariableSelection(maxent=maxent, outdir=outdir,gridfolder=gridfolder,occurrencelocations=occurrencelocations,backgroundlocations=bg,additionalargs=additionalargs,contributionthreshold=contributionthreshold,correlationthreshold=correlationthreshold,betamultiplier=betamultiplier)


##########EXEMPLO DO TUTORIAL###################

maxentPath = ("/home/anderson/R/x86_64-pc-linux-gnu-library/3.3/dismo/java/maxent.jar")
gridfolder <- ("/home/anderson/Downloads/BioOracle_9090RV")
occurrencelocations <- system.file("extdata", "Occurrencedata.csv",package="MaxentVariableSelection")
backgroundlocations <- system.file("extdata", "Backgrounddata.csv",package="MaxentVariableSelection")
additionalargs="nolinear noquadratic noproduct nothreshold noautofeature"
contributionthreshold <- 5
correlationthreshold <- 0.9
betamultiplier=seq(2,6,0.5)

VariableSelection(maxent,
                  outdir,
                  gridfolder,
                  occurrencelocations,
                  backgroundlocations,
                  additionalargs,
                  contributionthreshold,
                  correlationthreshold,
                  betamultiplier
                  )
