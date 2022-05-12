using Plots
using DynamicalSystems

function main()

    arange = (0.75:0.0005:1.2)
    b = 0.4
    transiente = 1000
    u0 = zeros(2)
    iteradas = 1000
    orbits = zeros(length(arange),iteradas+1)
    diagbif = plot()
    for i in 1:length(arange)
        a = arange[i]
        henon = Systems.henon(u0; a, b)
        orbits[i,:] = Vector(trajectory(henon, iteradas; Ttr = transiente)[:,1])
    end
    scatter(arange, orbits, mc = :black, ms = 0.5, markeralpha = 0.5, label = false)
end

main()
