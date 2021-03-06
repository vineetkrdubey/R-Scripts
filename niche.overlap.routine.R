niche.overlap.routine = function(predictors1,predictors2,spOcc1,spOcc2,me){

    clim1 = na.exclude(as.data.frame(predictors1,xy=TRUE)) #em que predictors e um stack com as variaveis bioclim01 e bioclim12 para 10 kyrBP
    clim2 = na.exclude(as.data.frame(predictors2,xy=TRUE)) #em que predictors e um stack com as variaveis bioclim01 e bioclim12 para 10 kyrBP
    clim12 = rbind(clim1,clim2) #dados ambientais para todo o espaco estudado
    spOcc1 = spOcc1 #pontos de ocorrencia com dados para as variaveis ambientais
    spOcc2 = spOcc2 #pontos de ocorrencia com dados para as variaveis ambientais
    
    scores.clim12.MAXENT <- data.frame(dismo::predict(object=me@models[[1]], x=clim12[,-c(1,2)]))
    scores.clim1.MAXENT <- data.frame(dismo::predict(object=me@models[[1]], x=clim1[,-c(1,2)]))
    scores.clim2.MAXENT <- data.frame(dismo::predict(object=me@models[[1]], x=clim2[,-c(1,2)]))
    scores.sp1.MAXENT <- data.frame(dismo::predict(object=me@models[[1]], x=spOcc1[,c("bioclim_01","bioclim_12")]))
    scores.sp2.MAXENT <- data.frame(dismo::predict(object=me@models[[1]], x=spOcc2[,c("bioclim_01","bioclim_12")]))
    
    R=100
    
    z1<- grid.clim(scores.clim12.MAXENT,scores.clim1.MAXENT,scores.sp1.MAXENT,R)
    z2<- grid.clim(scores.clim12.MAXENT,scores.clim2.MAXENT,scores.sp2.MAXENT,R)
    a<-niche.equivalency.test(z1,z2,rep=100)# test of niche equivalency and similarity according to Warren et al. 2008
    b<-niche.similarity.test(z1,z2,rep=100)
    b2<-niche.similarity.test(z2,z1,rep=100)

    return(list('equivalency'=a,'similarity1'=b,'similarity'=b2))
    
}
