using Plots
using DynamicalSystems

function main()

    rrange = (0:0.005:4)
    transiente = 1000
    x0 = 0.5
    iteradas = 1000
    orbits = zeros(length(rrange),iteradas+1)
    diagbif = plot()
    for i in 1:length(rrange)
        r = rrange[i]
        logistico = Systems.logistic(x0; r)
        orbits[i,:] = Vector(trajectory(logistico, iteradas; Ttr = transiente)[:,1])
    end
    scatter(rrange, orbits, mc = :black, ms = 0.5, label = false)
end

main()
