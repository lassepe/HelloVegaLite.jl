import VegaLite

VegaLite.@vlplot(
    data = [(; a = 1, b = 2)],
    params = [
        {name = "ϕ1", value = 0, bind = {input = "range", min = -pi, max = pi}},
        {name = "ϕ2", value = 0, bind = {input = "range", min = -pi, max = pi}},
    ],
    transform = [
        {calculate = "cos(ϕ1)", as = "px1"},
        {calculate = "sin(ϕ1)", as = "py1"},
        {calculate = "datum.px1 + cos(ϕ1 + ϕ2)", as = "px2"},
        {calculate = "datum.py1 + sin(ϕ1 + ϕ2)", as = "py2"},
    ]
) +
VegaLite.@vlplot(
    mark = :point,
    x = {"px1:q", scale = {domain = [-2, 2]}},
    y = {"py1:q", scale = {domain = [-2, 2]}},
) +
VegaLite.@vlplot(
    mark = :point,
    x = {"px2:q", scale = {domain = [-2, 2]}},
    y = {"py2:q", scale = {domain = [-2, 2]}},
) +
VegaLite.@vlplot(
    mark = :rule,
    x = {datum = 0, type = "quantitative"},
    y = {datum = 0, type = "quantitative"},
    x2 = "px1:q",
    y2 = "py1:q",
) +
VegaLite.@vlplot(mark = :rule, x = "px1:q", y = "py1:q", x2 = "px2:q", y2 = "py2:q",)
