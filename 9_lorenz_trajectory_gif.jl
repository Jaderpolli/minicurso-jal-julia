using DynamicalSystems, Plots, LaTeXStrings, Plots.PlotMeasures

# Vamos criar um gif que simule a evolução do atrator de lorenz ao variar r
# observando quatro condições iniciais indo aos seus estados assintóticos

function main()
    cores = [:red, :blue, :orange, :green] # uma cor pra plotar cada trajetória
    tf = 100.0 # tempo final de integração
    σ = 10.0
    r = (1.0:0.1:28) # r varia de 5 a 28 com passo = 0.1
    L = length(r) # limite superior do contador
    β = 8/3
    ϵ = 0.25 # parâmetro para definir condições iniciais

    pasta  = "lorenz"
    mkpath(pasta) # cria uma pasta onde salvaremos o gif

    anim = @animate for i = 1:L
        println("% $(i/L)%")
        # existem três pontos de equilíbrio no sistema:
        # (0,0,0)
        # (sqrt(b(r-1)),sqrt(b(r-1)),r-1)
        # (-sqrt(b(r-1)),-sqrt(b(r-1)),r-1)
        # para estudar como a estabilidade dos pontos de equilíbrio varia
        # vamos iniciar três condições iniciais nos arredores dos pontos
        # de equilíbrio e ver como as trajetórias evoluem!
        u0s = [[ϵ, ϵ, ϵ], # primeira c.i. ao redor de (0,0,0)
                [-1.4, 2.3, 9.3],
                [(β*(r[i]-1))^(1/2)+ϵ,(β*(r[i]-1))^(1/2)+ϵ,r[i]-1+ϵ],
                [-(β*(r[i]-1))^(1/2)+ϵ,-(β*(r[i]-1))^(1/2)+ϵ,r[i]-1+ϵ]
            ]
        j=1
        plt = plot()
        for u0 in u0s
            ds = Systems.lorenz(u0, σ = σ, ρ = r[i], β = β)
            tr = Matrix(trajectory(ds, tf, dt = 0.1))
            plt = plot!(tr[:,1], tr[:,2], tr[:,3],
                xlabel = L"x(t)",
                ylabel = L"y(t)",
                zlabel = L"z(t)",
                lw = 5,
                xlims = (-20.0,20.0), ylims = (-25.0,25.0), zlims = (0.0,50.0),
                color = cores[j],
                size = (1320,700),
                label = false,
                titlefontsize = 20,
                tickfontsize = 20,
                guidefontsize = 20,
                title = L"r = %$(r[i])",
                left_margin = 10mm
            )
            j = j+1
        end
    end
    gif(anim, string(pasta, "/trajetorias_lorenz.gif"), fps = 60)
end

main()
