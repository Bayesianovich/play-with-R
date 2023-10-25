library(tidyverse)
df <- tibble(
    ID = 1:10,
    真实类别 = c(
        "Pos", "Pos", "Pos", "Neg", "Pos",
        "Neg", "Neg", "Neg", "Pos", "Neg"
    ),
    预测概率 = c(
        0.95, 0.86, 0.69, 0.65, 0.59, 0.52,
        0.39, 0.28, 0.15, 0.06
    )
)
knitr::kable(df)
c <- 0.85
df1 <- df %>%
    mutate(
        预测类别 = ifelse(预测概率 > c, "Pos", "Neg"),
        预测类别 = factor(预测类别, levels = c("Pos", "Neg")),
        真实类别 = factor(真实类别, levels = c("Pos", "Neg"))
    )

knitr::kable(df1)

cm <- table(df1$预测类别, df1$真实类别)

cm


cm["Pos", ] / colSums(cm)

cal_ROC <- function(df, c) {
    df <- df %>%
        mutate(
            预测类别 = ifelse(预测概率 > c, "Pos", "Neg"),
            预测类别 = factor(预测类别, levels = c("Pos", "Neg")),
            真实类别 = factor(真实类别, levels = c("Pos", "Neg"))
        )
    cm <- table(df$预测类别, df$真实类别)
    t <- cm["Pos", ] / colSums(cm)
    list(TPR = t[[1]], FPR = t[[2]])
}

cal_ROC(df, 0.85)

c <- seq(1, 0, -0.02)
rocs <- map_dfr(c, cal_ROC, df = df)
head(rocs)

rocs %>%
    ggplot(aes(FPR, TPR)) +
    geom_line(size = 2, color = "red") +
    geom_point(shape = "diamond", size = 4, color = "green") +
    theme_bw()



head(mtcars, 3)

model <- lm(mpg ~ disp, data = mtcars)
summary(model)


### 向量化编程

y <- c(rep("是", 8), rep("否", 9))
y

table(y)

p <- table(y) / length(y) 
p
log(p)

p*log(p)

-sum(p * log(p))

