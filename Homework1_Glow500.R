#install packages needed and input them to the lib for R to reference
#NOTE: aplore3 is a package that has all datasets used from the Hosmer book
install.packages("aplore3")
library(aplore3)

#print out the first 20 obs to make sure our data looks correct
head(glow500, n=5)

#bringing our variables in to environment
raterisk <- glow500$raterisk
fracture <- glow500$fracture

#create new variables of raterisk and fractures, then factor to binary
raterisk2 <- factor(with(glow500, ifelse((raterisk == "Same"), 1, 0)))
raterisk3 <- factor(with(glow500, ifelse((raterisk == "Greater"), 1, 0)))
fractureY <- factor(with(glow500, ifelse((fracture == "Yes"), 1, 0)))

#print out raterisk variables and fracture variables
print(raterisk)
print(raterisk2)
print(raterisk3)
print(fracture)
print(fractureY)

#create logistic regression model of fracture based on the raterisk variables
#set the family to binomial as a logit model for our categorical variables
fracture.gm <- glm(fractureY ~ raterisk2 + raterisk3, family = binomial(link=logit))

#print out a summary of our output
summary(fracture.gm)

#likelihood method of confidence intervals (off slightly from the Hosmer book)
confint(fracture.gm)

#Wald method of confidence intervals (exact with the Hosmer book)
confint.default(fracture.gm)

#time stamp of work
Sys.time()