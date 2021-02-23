using VegaLite: @vlplot
import VegaDatasets

data = VegaDatasets.dataset("cars")
data |> @vlplot(
    mark = "line",
    x = {"Horsepower:q", aggregate = "mean"},
    y = {"Displacement:q", aggregate = "mean"},
    order = "Acceleration:q"
)
