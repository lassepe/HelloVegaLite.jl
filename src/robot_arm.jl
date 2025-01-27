import VegaLite

arm_motion_data = [(; ϕ1 = cos(t), ϕ2 = sin(t), t) for t in 0:0.01:2pi]

arm_motion_data |>
VegaLite.@vlplot(
    width = 500,
    height = 500,
    params = [{name = "selectedTime", bind = {input = "range", min = 0, max = 2pi, step = 0.01}}],
    transform = [
        {calculate = "cos(datum.ϕ1)", as = "px1"},
        {calculate = "sin(datum.ϕ1)", as = "py1"},
        {calculate = "datum.px1 + cos(datum.ϕ2)", as = "px2"},
        {calculate = "datum.py1 + sin(datum.ϕ2)", as = "py2"},
    ],
    opacity = {condition = {test = "datum.t == selectedTime", value = 1}, value = 0.1}
) +
VegaLite.@vlplot(
    mark = :rule,
    x = {datum = 0, scale = {domain = [0, 2.8]}},
    y = {datum = 0, scale = {domain = [-1.4, 1.4]}},
    x2 = "px1:q",
    y2 = "py1:q"
) +
VegaLite.@vlplot(mark = :point, x = "px1:q", y = "py1:q") +
VegaLite.@vlplot(mark = :rule, x = "px1:q", y = "py1:q", x2 = "px2:q", y2 = "py2:q") +
VegaLite.@vlplot(mark = :point, x = "px2:q", y = "py2:q")
