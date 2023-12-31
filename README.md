# play-with-R-
作为统计学专业第一门接触数据分析语言，虽然目前在玩python,但是R语言的优雅还是久久不能忘记

下面是最火的R包 数据科学工作流
`tidyverse` 是 R 语言中一组相关的包的集合，专为数据科学设计。tidyverse 包括一系列包，这些包具有共同的数据和函数设计哲学。其中最核心的概念是“tidy data”，即每一列代表一个变量，每一行代表一个观测值的数据结构。

以下是 `tidyverse` 中一些主要的包和它们的功能：

1. **ggplot2**: 数据可视化
   - 提供了一个统一的、声明式的接口来创建多种类型的图表。
   - 支持复杂的分面绘图。

2. **dplyr**: 数据操作
   - 提供了一组方便的函数来过滤、排序、摘要、创建新变量以及其他常见的数据操作任务。
   - 常用函数有 `filter()`, `arrange()`, `select()`, `mutate()`, `summarise()` 和 `group_by()`。

3. **tidyr**: 数据整理
   - 将宽格式的数据转换为长格式，反之亦然。
   - 主要函数如 `spread()`, `gather()`, `pivot_wider()`, `pivot_longer()`。

4. **readr**: 数据导入
   - 用于快速有效地从 CSV、TSV 和其他 delimited 格式中读取数据。
   
5. **purrr**: 函数式编程
   - 提供一系列的函数来帮助您对列表、数据框或其他向量进行迭代计算。

6. **tibble**: 数据框增强
   - 扩展了 R 的基础数据框功能，提供了更友好和更现代的数据框对象。

7. **stringr**: 字符串操作
   - 提供了简单且一致的接口来处理字符串。

8. **forcats**: 因子（分类变量）操作
   - 简化了因子的创建和处理。

9. **lubridate**: 日期和时间操作
   - 提供了方便的函数来解析、操作和格式化日期和时间。

如何使用 `tidyverse` 进行数据科学：

1. **数据导入**: 使用 `readr` 中的函数（如 `read_csv()`）导入数据。

2. **数据清洗**: 使用 `dplyr` 和 `tidyr` 进行数据过滤、选择、变换和整理。

3. **数据分析**: 利用 `dplyr` 进行数据摘要和聚合，使用 `purrr` 进行迭代和函数式编程操作。

4. **数据可视化**: 使用 `ggplot2` 创建各种可视化图表。

5. **数据输出**: 使用 `readr` 的写出函数（如 `write_csv()`）或其他相关包输出数据。

总体来说，`tidyverse` 提供了一整套工具，从数据导入到可视化再到导出，都为数据科学工作流提供了方便。如果你使用 R 进行数据分析，学习和掌握 `tidyverse` 是非常有价值的。

--------------------------------------------------------------

`mlr3verse` 是 R 语言中的一个包集合，其主要目的是为机器学习任务提供一套统一、扩展性强、高效的框架。它是 `mlr`（Machine Learning in R）项目的第三个主要版本，与之前的版本相比，`mlr3` 提供了更简洁的API、更高的效率和更丰富的功能。

以下是 `mlr3verse` 中一些核心包及其功能：

1. **mlr3**：核心框架。
    - 提供了任务、学习器和评估的抽象。
    - 使用户能够简洁地定义和执行机器学习任务。

2. **mlr3learners**：包含各种常见机器学习算法的接口。
    - 这使得用户可以使用统一的 `mlr3` API 来训练和评估各种不同的模型。

3. **mlr3tuning**：超参数调优。
    - 提供了各种搜索策略和优化算法，以帮助用户找到最佳的模型超参数。

4. **mlr3pipelines**：用于数据预处理和模型组合。
    - 允许用户定义复杂的预处理流程，如特征选择、特征构造等。
    - 支持模型集成，如堆叠和bagging。

5. **mlr3viz**：可视化和结果展示。
    - 提供了一系列的工具来可视化机器学习任务的结果，如性能指标、学习曲线等。

6. **mlr3filters**：特征选择和过滤。
    - 提供了一套方法来评估和选择数据集中最相关的特征。

7. **mlr3proba**：概率预测和风险建模。
    - 扩展了 `mlr3`，使其支持概率预测和风险建模任务。

8. 其他扩展包：除了上面列出的包，`mlr3` 生态系统还包括许多其他包，用于各种特定的任务和扩展功能。

总的来说，`mlr3verse` 提供了一个完整的机器学习工作流，从数据预处理到模型评估和可视化都有涉及。它的设计理念是模块化、扩展性强、易于使用，使得 R 用户能够在一个统一的框架下进行机器学习任务。

