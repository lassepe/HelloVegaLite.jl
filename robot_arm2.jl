import VegaLite

VegaLite.@vlplot(
    data = [(; a = 1, b = 2)],
    params = [{name = "a", value = 0, bind = {input = "range", min = -pi, max = pi}}],
) +
VegaLite.@vlplot(
    mark = :point,
    x = {datum = {expr = "cos(a)"}, type = "quantitative", scale = {domain = [-2, 2]}},
    y = {datum = {expr = "sin(a)"}, type = "quantitative", scale = {domain = [-2, 2]}},
) +
VegaLite.@vlplot(
    mark = :point,
    x = {datum = {expr = "cos(a) + sin(a)"}, type = "quantitative", scale = {domain = [-2, 2]}},
    y = {datum = {expr = "sin(a) + cos(a)"}, type = "quantitative", scale = {domain = [-2, 2]}},
)
