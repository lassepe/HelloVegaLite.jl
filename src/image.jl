using VegaLite: @vlplot

data = [(; x = 0, y, heading = 45) for y in 0:0.075:1]

# Note: Unfortunately, the vega-lite image encoding does not support rotation.
# Note: An alternative may be to use a point mark with custom svg as shape. There, however, we need
# to hand the SVG as a string to the `@vlplot` macro
data |> @vlplot(
    width = 500,
    height = 500,
    mark = {"image", width = 50, height = 50},
    x = "x",
    y = "y",
    opacity = {"y", legend = nothing},
    angle = "heading",
    url = {value = "/home/lassepe/worktree/HelloVegaLite.jl/media/car.svg"}
)
