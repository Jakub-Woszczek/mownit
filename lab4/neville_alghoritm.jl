# Neville algorithm

# sample_x: A vector of x-coordinates where the function values are known.
# sample_y: A vector of function values corresponding to the x_points.
# x: The point at which we want to evaluate the Newton polynomial.

# function nevilleAlgo(sample_x,sample_y,x)
#     n = length(sample_y)
#     pyramid = zeros(n, n)

#     for i in 1:n
#         pyramid[1,i] = sample_y[i]
#     end

#     for row in 2:n
#         for col in 1:(n-row+1)
#             xi = sample_x[col]
#             xj = sample_x[col+row-1]
#             numerator = (pyramid[row-1,col]*(x-xj) + pyramid[row-1,col+1]*(x-xi))
#             denominator = xi - xj
#             pyramid[row,col] = numerator / denominator
#         end
#     end
#     return pyramid[n,1]
# end    

function nevilleAlgo(sample_x::Vector{Float64}, sample_y::Vector{Float64}, x::Float64)
    n = length(sample_x)
    P = zeros(Float64, n, n)

    for i in 1:n
        P[i, i] = sample_y[i]
    end

    for j in 1:n-1
        for i in 1:(n-j)
            xi = sample_x[i]
            xj = sample_x[i + j]
            P[i, i + j] = ((x - xj) * P[i, i + j - 1] + (xi - x) * P[i + 1, i + j]) / (xi - xj)
        end
    end

    return P[1, n]
end
