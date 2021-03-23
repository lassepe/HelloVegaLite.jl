using VegaLite: @vlplot
using Random: MersenneTwister

rng = MersenneTwister(1)
data = [
    [(; x, y = sin(x) + rand(rng), class = "sin") for x in -3:0.025:3]
    [(; x, y = cos(x) + rand(rng), class = "cos") for x in -3:0.025:3]
]

data |>
@vlplot(
    width = 800,
    height = 800,
    x = {"x", type = "quantitative"},
    y = {type = "quantitative"},
    color = "class",
    transform = [
        {
            window = [
                {field = "y", op = "mean", as = "rolling_mean"},
                {field = "y", op = "ci0", as = "rolling_q1"},
                {field = "y", op = "ci1", as = "rolling_q3"},
            ],
            groupby = ["class"], # TODO: I think this is a bug. Should work without this!
            frame = [-10, 10],
        },
    ],
) +
@vlplot(mark = {"point", tooltip = true, opacity = 0.1}, y = "y") +
@vlplot(mark = "line", y = "rolling_mean:q") +
@vlplot(mark = "errorband", y = "rolling_q1:q", y2 = "rolling_q3:q")
