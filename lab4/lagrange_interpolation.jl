# Lagrange interpolation implementation

# x_samples: A vector of x-coordinates where the function values are known.
# y_samples: A vector of function values corresponding to the x_samples.
# x: The argument for which we want to compute the interpolated function value.

# Returns: The function value at the point x, computed using Lagrange interpolation.

function lagrange_interpolation(x_samples, y_samples, x)
    n = length(x_samples)
    result = 0.0
    for i in 1:n
        L_i = 1.0
        for j in 1:n
            if i != j
                L_i *= (x - x_samples[j]) / (x_samples[i] - x_samples[j])
            end
        end
        result += y_samples[i] * L_i
    end
    return result
end