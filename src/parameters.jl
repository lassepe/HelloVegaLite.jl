import VegaLite
import VegaDatasets

dataset = VegaDatasets.dataset("cars")

dataset |> VegaLite.@vlplot(
    height = 400,
    params = [
        {name = "width", bind = {input = "range", min = 400, max = 1000, step = 1}},
        {name = "maxval", bind = {input = "range", min = 10, max = 50, step = 1, value = 50}},
    ],
    transform =
        [{density = "Miles_per_Gallon", bandwidth = 1}, {filter = "datum.value < maxval"}],
    mark = :area,
    x = "value:q",
    y = "density:q"
)
