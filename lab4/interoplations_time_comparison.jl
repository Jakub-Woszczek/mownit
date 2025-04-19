function interpolations_time_comparision()
    x_test_vals = []
    y_test_lagrange_avg = []
    y_test_lagrange_std = []

    y_test_newton_prep_avg = []
    y_test_newton_prep_std = []

    y_test_newton_eval_avg = []
    y_test_newton_eval_std = []

    y_test_newton_full_avg = []
    y_test_newton_full_std = []

    y_test_poly_prep_avg = []
    y_test_poly_prep_std = []

    y_test_poly_eval_avg = []
    y_test_poly_eval_std = []

    y_test_poly_full_avg = []
    y_test_poly_full_std = []

    original_function(x) = sin(x)*exp(-x)*10
    jit_warmup()
        
    for samples_amount in 1500:500:5000 #    <-- jest git
    # for samples_amount in 150:50:500
        push!(x_test_vals, samples_amount)

        # tymczasowe listy do przechowywania 10 wyników
        times_lagrange = Float64[]
        times_newton_prep = Float64[]
        times_newton_eval = Float64[]
        times_poly_prep = Float64[]
        times_poly_eval = Float64[]

        for j in 1:11
            x_min = 0
            x_max = samples_amount

            x_samples_time = sort(rand(samples_amount) * (x_max - x_min) .+ x_min)
            y_samples = original_function.(x_samples_time)
            x_vals_time = range(x_min, x_max, length=100)

            # Newton - przygotowanie
            time = @elapsed newt = NewtonInterpolation(x_samples_time, y_samples)
            j > 1 && push!(times_newton_prep, time)

            # Newton - obliczanie wartości
            time = @elapsed _ = [NewtonHorner(newt, x, x_samples_time) for x in x_vals_time]
            j > 1 && push!(times_newton_eval, time)

            # Polynomials - przygotowanie
            time = @elapsed p = Polynomials.fit(Polynomial, x_samples_time, y_samples)
            j > 1 && push!(times_poly_prep, time)

            # Polynomials - obliczanie wartości
            time = @elapsed _ = [p(x) for x in x_vals_time]
            j > 1 && push!(times_poly_eval, time)

            # Lagrange
            time = @elapsed _ = [lagrange_interpolation(x_samples_time, y_samples, x) for x in x_vals_time]
            j > 1 && push!(times_lagrange, time)
        end

        # Liczenie średnich i std dev i dodawanie do finalnych list
        push!(y_test_lagrange_avg, mean(times_lagrange))
        push!(y_test_lagrange_std, std(times_lagrange))

        push!(y_test_newton_prep_avg, mean(times_newton_prep))
        push!(y_test_newton_prep_std, std(times_newton_prep))

        push!(y_test_newton_eval_avg, mean(times_newton_eval))
        push!(y_test_newton_eval_std, std(times_newton_eval))

        push!(y_test_poly_prep_avg, mean(times_poly_prep))
        push!(y_test_poly_prep_std, std(times_poly_prep))

        push!(y_test_poly_eval_avg, mean(times_poly_eval))
        push!(y_test_poly_eval_std, std(times_poly_eval))
    end
    return y_test_lagrange_avg, y_test_lagrange_std,
           y_test_newton_prep_avg, y_test_newton_prep_std,
           y_test_newton_eval_avg, y_test_newton_eval_std,
           y_test_poly_prep_avg, y_test_poly_prep_std,
           y_test_poly_eval_avg, y_test_poly_eval_std,x_test_vals
end


function jit_warmup()
    original_function(x) = sin(x) * exp(-x) * 10

    x_min = 0
    x_max = 5
    x_samples = sort(rand(15) * (x_max - x_min) .+ x_min)
    y_samples = original_function.(x_samples)
    x_vals_jit = range(x_min, x_max, length=100)

    # Lagrange (wywołanie samej funkcji interpolacyjnej)
    _ = [lagrange_interpolation(x_samples, y_samples, x) for x in x_vals_jit]

    # Newton
    newt = NewtonInterpolation(x_samples, y_samples)
    _ = [NewtonHorner(newt, x, x_samples) for x in x_vals_jit]

    # Polynomials.jl
    p = Polynomials.fit(Polynomial, x_samples, y_samples)
    _ = [p(x) for x in x_vals_jit]

    return nothing
end