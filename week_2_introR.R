numSamples <- 50
num_samples <- 40
rm(num_samples)
rm(list = ls())
ls()
?ls
ls(numSamples)
ls(num_samples)
?rm

log("a_word")
log_of_word <- log("a_word")

# challenge

elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg * 2.2
elephant1_lb


elephant2_lb > elephant1_lb

# c means you are creating a vector; a length of cells with all the things

myelephants <- c(elephant1_lb, elephant2_lb)
myelephants

#which value is greater (in order)

which(myelephants == max(myelephants))
