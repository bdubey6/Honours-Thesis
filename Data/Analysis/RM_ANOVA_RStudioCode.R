library(tidyverse)
library(ggpubr)
library(rstatix)

data <- read.csv("C:/Users/bhuva/Downloads/Honour Program/Data/Analysis/Outcomes_Ext.csv")

# Success Rate ------------------------------------------------------

data %>% group_by(Condition) %>% get_summary_stats(SuccessRate, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "SuccessRate", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(SuccessRate)
data %>% group_by(Condition) %>% shapiro_test(SuccessRate)
ggqqplot(data, "SuccessRate", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = SuccessRate, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(SuccessRate ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# Elbow angle Ext ------------------------------------------------------

data %>% group_by(Condition) %>% get_summary_stats(ElbAng_Ext, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "ElbAng_Ext", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(ElbAng_Ext)
data %>% group_by(Condition) %>% shapiro_test(ElbAng_Ext)
ggqqplot(data, "ElbAng_Ext", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = ElbAng_Ext, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(ElbAng_Ext ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# Movement Time ------------------------------------------------------

data %>% group_by(Condition) %>% get_summary_stats(MoveTime, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "MoveTime", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(MoveTime)
data %>% group_by(Condition) %>% shapiro_test(MoveTime)
ggqqplot(data, "MoveTime", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = MoveTime, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(MoveTime ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# Biceps SLR ------------------------------------------------------

data %>% group_by(Condition) %>% get_summary_stats(BB_SLR, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "BB_SLR", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(BB_SLR)
data %>% group_by(Condition) %>% shapiro_test(BB_SLR)
ggqqplot(data, "BB_SLR", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = BB_SLR, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(BB_SLR ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# Biceps LLR ------------------------------------------------------
data %>% group_by(Condition) %>% get_summary_stats(BB_LLR, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "BB_LLR", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(BB_LLR)
data %>% group_by(Condition) %>% shapiro_test(BB_LLR)
ggqqplot(data, "BB_LLR", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = BB_LLR, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(BB_LLR ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# TLong SLR ------------------------------------------------------
data %>% group_by(Condition) %>% get_summary_stats(TLong_SLR, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "TLong_SLR", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(TLong_SLR)
data %>% group_by(Condition) %>% shapiro_test(TLong_SLR)
ggqqplot(data, "TLong_SLR", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = TLong_SLR, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(TLong_SLR ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)

# TLong LLR ------------------------------------------------------
data %>% group_by(Condition) %>% get_summary_stats(TLong_LLR, type = "mean_sd")

bxp <- ggboxplot(data, x = "Condition", y = "TLong_LLR", add = "point")
bxp

data %>% group_by(Condition) %>% identify_outliers(TLong_LLR)
data %>% group_by(Condition) %>% shapiro_test(TLong_LLR)
ggqqplot(data, "TLong_LLR", facet.by = "Condition")

res.aov <- anova_test(data = data, dv = TLong_LLR, wid = ID, within = Condition)
get_anova_table(res.aov)

pwc <- data %>% pairwise_t_test(TLong_LLR ~ Condition, paired = TRUE, p.adjust.method = "holm")
pwc
print(pwc,n=50)