using Plots
gr()

n = 25

theta = [(2k - 1) * π / (2n) for k in 1:n]
x_nodes = theta
y_nodes = cos.(theta)

mid = div(n, 2)
top = n - mid

colors = [RGB(1, i, 0) for i in vcat(range(0.0, 1.0, length=mid), range(1.0, 0.0, length=top))]

xs = range(0, π, length=200)
plot(xs, cos.(xs), label="cos(x)", linewidth=2, color=:blue)

scatter!(x_nodes, y_nodes, label="", c=colors, ms=6)
for (x, y) in zip(x_nodes, y_nodes)
    plot!([0, π], [y, y], color=:black,lw=0.5, label="")
end

title!("Węzły Czebyszewa")
xlabel!("x")
ylabel!("cos(x)")
