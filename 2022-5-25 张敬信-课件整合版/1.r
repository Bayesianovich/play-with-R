library(tidyverse)
df <- tibble(
    ID = 1:10,
    ��ʵ��� = c(
        "Pos", "Pos", "Pos", "Neg", "Pos",
        "Neg", "Neg", "Neg", "Pos", "Neg"
    ),
    Ԥ����� = c(
        0.95, 0.86, 0.69, 0.65, 0.59, 0.52,
        0.39, 0.28, 0.15, 0.06
    )
)
knitr::kable(df)
c <- 0.85
df1 <- df %>%
    mutate(
        Ԥ����� = ifelse(Ԥ����� > c, "Pos", "Neg"),
        Ԥ����� = factor(Ԥ�����, levels = c("Pos", "Neg")),
        ��ʵ��� = factor(��ʵ���, levels = c("Pos", "Neg"))
    )

knitr::kable(df1)

cm <- table(df1$Ԥ�����, df1$��ʵ���)

cm


cm["Pos", ] / colSums(cm)

cal_ROC <- function(df, c) {
    df <- df %>%
        mutate(
            Ԥ����� = ifelse(Ԥ����� > c, "Pos", "Neg"),
            Ԥ����� = factor(Ԥ�����, levels = c("Pos", "Neg")),
            ��ʵ��� = factor(��ʵ���, levels = c("Pos", "Neg"))
        )
    cm <- table(df$Ԥ�����, df$��ʵ���)
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


### ���������

y <- c(rep("��", 8), rep("��", 9))
y

table(y)

p <- table(y) / length(y) 
p
log(p)

p*log(p)

-sum(p * log(p))

