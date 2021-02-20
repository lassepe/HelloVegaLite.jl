using VegaLite: @vlplot
using Random: MersenneTwister

rng = MersenneTwister(1)
data = [
        [(; x, y = sin(x) + rand(rng), class = "sin") for x in -3:0.01:3];
        [(; x, y = cos(x) + rand(rng), class = "cos") for x in -3:0.01:3];
       ]

data |>
@vlplot(
    width = 500,
    height = 500,
    x = {"x", type = "quantitative"},
    y = {type = "quantitative"},
    color = "class",
    transform = [
        {window = [{field = "y", op = "mean", as = "rolling_mean"}], frame = [-10, 10]},
        {window = [{field = "y", op = "ci0", as = "rolling_q1"}], frame = [-10, 10]},
        {window = [{field = "y", op = "ci1", as = "rolling_q3"}], frame = [-10, 10]},
    ],
) +
@vlplot(mark = {"point", tooltip = true, opacity = 0.1}, y = "y") +
@vlplot(mark = "line", y = "rolling_mean:q") +
@vlplot(mark = "errorband", y = "rolling_q1:q", y2 = "rolling_q3:q")
