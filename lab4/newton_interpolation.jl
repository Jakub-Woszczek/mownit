# Newton Interpolation method

# NewtonInterpolation computes the Newton's Divided Difference Table for the given set of sample points.
# x_samples: A vector of x-coordinates where the function values are known.
# y_samples: A vector of function values corresponding to the x_samples.

function NewtonInterpolation(x_samples, y_samples)
    n = length(x_samples)
    T = zeros(n, n)

    for i in 1:n
        T[i, 1] = y_samples[i]
    end

    for col in 2:n
        for row in col:n
            T[row, col] = 
                (T[row, col-1] - T[row-1, col-1]) / 
                (x_samples[row] - x_samples[row-col+1])
        end
    end

    return T
end

# This function evaluates the Newton interpolated polynomial at a specific point x using Horner's method.
# newt: The Newton's Divided Difference Table
# x: The point at which we want to evaluate the Newton polynomial.
# x_samples: A vector of x-coordinates where the function values are known.

function NewtonHorner(newt, x, x_samples)
    n = size(newt, 1)
    result = newt[n, n]
    for i in (n-1):-1:1
        result = result * (x - x_samples[i]) + newt[i, i]
    end
    return result
end