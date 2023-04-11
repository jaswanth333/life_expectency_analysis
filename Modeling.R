library(tidyverse)
library(psych)
library(ggcorrplot)
library(plotly)
library(leaps)
library(caret)
library(car)
library(reshape2)    
library(GGally)
library(grid)
library(ellipse)

df <- read.csv(file = "finaldata2.csv")
main_data=subset(df, select=-c(Country,Status))
main_data2 <- df[,c(4,3,5:20)]

varNum <- function(x){
  val <- 1:ncol(x)
  names(val) <- colnames(x)
  return(val)
}
varNum(main_data)

plot(cor(main_data))


offDiag <- function(x,y,...){
  panel.grid(h = -1,v = -1,...)
  panel.hexbinplot(x,y,xbins = 15,...,border = gray(.7),
                   trans = function(x)x^.5)
  #  panel.loess(x , y, ..., lwd=2,col='red')
}

onDiag <- function(x, ...){
  yrng <- current.panel.limits()$ylim
  d <- density(x, na.rm = TRUE)
  d$y <- with(d, yrng[1] + 0.95 * diff(yrng) * y / max(y) )
  panel.lines(d,col = rgb(.83,.66,1),lwd = 2)
  diag.panel.splom(x, ...)
}

splom(main_data2,as.matrix = TRUE,
      xlab = '',main = "Life Expectancy: Selected Variables",
      pscale = 0, varname.cex = 0.8,axis.text.cex = 0.6,
      axis.text.col = "purple",axis.text.font = 2,
      axis.line.tck = .5,
      panel = offDiag,
      diag.panel = onDiag
)



ggscatmat(main_data2,alpha=0.3)

ggscatmat(main_data, color="Status", alpha=0.8) +
  ggtitle("Correlation") + 
  theme(axis.text.x = element_text(angle=-40, vjust=1, hjust=0, size=10))

ggcorrplot(cor(main_data), hc.order = TRUE,show.diag = FALSE,type="lower",lab=TRUE,
           insig = "blank",digits = 2,lab_size=3)+ labs(title = "Correlation Matrix")

offDiag <- function(x,y,...){
  panel.grid(h = -1,v = -1,...)
  panel.hexbinplot(x,y,xbins = 15,...,border = gray(.7),
                   trans = function(x)x^.5)
  panel.loess(x , y, ..., lwd = 2,col = 'blue')
}

offDiag <- function(x,y,...){
  panel.grid(h = -1,v = -1,...)
  panel.hexbinplot(x,y,xbins = 15,...,border = gray(.7),
                   trans = function(x)x^.5)
  panel.loess(x , y, ..., lwd = 2,col = 'red')
}

splom(main_data, as.matrix = TRUE,
      xlab = '',main = "Density and Scatterplot Matrix",
      pscale = 0, varname.cex = 0.8,axis.text.cex = 0.6,
      axis.text.col = "purple",axis.text.font = 2,
      axis.line.tck = .5,
      panel = offDiag,
      diag.panel = onDiag
)

splom(main_data, as.matrix = TRUE,
      xlab = '',main = "Life Expectancy: Determining Variables",
      pscale = 0, varname.cex = 0.8,axis.text.cex = 0.6,
      axis.text.col = "purple",axis.text.font = 2,
      axis.line.tck = .5,
      panel = offDiag,
      diag.panel = onDiag
)

density(main_data2)
ggpairs(main_data)
fig2 <- plot_ly(
  df, x = ~Life.expectancy, y = ~Adult.Mortality ,type="scatter",mode="markers",color=~Status,size =~Adult.Mortality ) %>%layout(title = 'Relationship b/w Mathscores and TeacherPay <br> w.r.t to Percenttaking and population') 
fig2 



panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...) {
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  Cor <- abs(cor(x, y)) # Remove abs function if desired
  txt <- paste0(prefix, format(c(Cor, 0.123456789), digits = digits)[1])
  if(missing(cex.cor)) {
    cex.cor <- 0.4 / strwidth(txt)
  }
  text(0.5, 0.5, txt,
       cex = 1 + cex.cor * Cor) # Resize the text by level of correlation
}

# Plotting the correlation matrix
pairs(main_data,
      upper.panel = panel.cor,    # Correlation panel
      lower.panel = panel.smooth) # Smoothed regression lines


library(PerformanceAnalytics)

chart.Correlation(main_data, histogram = TRUE, method = "pearson")


pairs.panels(main_data,
             smooth = TRUE,      # If TRUE, draws loess smooths
             scale = FALSE,      # If TRUE, scales the correlation text font
             density = TRUE,     # If TRUE, adds density plots and histograms
             ellipses = TRUE,    # If TRUE, draws ellipses
             method = "pearson", # Correlation method (also "spearman" or "kendall")
             pch = 21,           # pch symbol
             lm = FALSE,         # If TRUE, plots linear fit rather than the LOESS (smoothed) fit
             cor = TRUE,         # If TRUE, reports correlations
             jiggle = FALSE,     # If TRUE, data points are jittered
             factor = 2,         # Jittering factor
             hist.col = 4,       # Histograms color
)



#Lasso
x=model.matrix(Life.expectancy~., main_data)[,-1]
y=main_data$Life.expectancy
grid=10^seq(10,-2,length=100)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]
ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid, thresh =1e-12)
set.seed (1)
cv.out=cv.glmnet(x[train ,],y[train],alpha=0)
bestlam=cv.out$lambda.min
ridge.pred=predict(ridge.mod,s=bestlam ,newx=x[test,])
out=glmnet(x,y,alpha=0,lambda=grid)
ridge.coef=predict(out,type="coefficients",s=bestlam)[1:9,]
ridge.coef



lasso.mod=glmnet(x[train,], y[train], alpha=1, lambda=grid)
set.seed (1)
cv.out=cv.glmnet(x[train,],y[train],alpha=1)
bestlam=cv.out$lambda.min
lasso.pred=predict(lasso.mod,s=bestlam ,newx=x[test,])
lasso=glmnet(x,y,alpha=1,lambda=grid)
lasso.coef=predict(lasso,type="coefficients",s=bestlam)[1:9,]
lasso.coef[lasso.coef!=0]
