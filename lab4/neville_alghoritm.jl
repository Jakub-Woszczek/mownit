# Neville algorithm

# sample_x: A vector of x-coordinates where the function values are known.
# sample_y: A vector of function values corresponding to the x_points.
# x: The point at which we want to evaluate the Newton polynomial.

function nevilleAlgo(sample_x,sample_y,x)
    n = length(sample_y)
    pyramid = zeros(n, n)

    for i in 1:n
        pyramid[1,i] = sample_y[i]
    end

    for row in 2:n
        for col in 1:(n-row+1)
            xi = sample_x[col]
            xj = sample_x[col+row-1]
            numerator = (pyramid[row-1,col]*(x-xj) + pyramid[row-1,col+1]*(x-xi))
            denominator = xi - xj
            pyramid[row,col] = numerator / denominator
        end
    end
    return pyramid[n,1]
end    

