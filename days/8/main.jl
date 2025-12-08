using LinearAlgebra

function parse_input(io)
    data = []
    for line in readlines(io)
        xyz = split(line, ",")
        x = parse(Int, xyz[1])
        y = parse(Int, xyz[2])
        z = parse(Int, xyz[3])
        push!(data, [x,y,z])
    end
    data = reduce(vcat, data')
    data = reshape(data, (length(data)÷3,3))
    data
end

function dist_matrix(data)
    M = zeros(Float64, (size(data,1), size(data,1)))
    for (i,d1) in enumerate(eachrow(data)), (j,d2) in enumerate(eachrow(data))
        if i == j
            M[i,j] = typemax(Float64)
        else
            M[i,j] = norm(d1 - d2)
        end
    end
    M
end

function length_connected(connected2, i)
    explored = Set{Int}()
    stack = [i]
    for j in stack
        push!(explored, j)
        for k in connected2[j]
            if k ∉ explored
                push!(stack, k)
            end
        end
    end
    length(explored)
end

function part1()
    local data
    N_connections = 1000
    open("input", "r") do io
        data = parse_input(io)
    end
    connected2 = Dict{Int,Set{Int}}()
    for (i,_) in enumerate(eachrow(data))
        connected2[i] = Set(i)
    end

    M = dist_matrix(data)
    for _ = 1:N_connections
        i = argmin(M)
        push!(connected2[i[1]], i[2])
        push!(connected2[i[2]], i[1])
        M[i[1], i[2]] = typemax(Float64)
        M[i[2], i[1]] = typemax(Float64)
    end
    len = [length_connected(connected2, i) for i = 1:size(data,1)]
    len = reverse(sort(len))

    # Avoid extra counting
    len2 = Vector{Int}()
    i = 1
    while i < length(len)
        push!(len2, len[i])
        i += len[i]
    end
    prod(len2[1:3])
end


function part2()
    local data
    open("input", "r") do io
        data = parse_input(io)
    end
    connected2 = Dict{Int,Set{Int}}()
    for (i,_) in enumerate(eachrow(data))
        connected2[i] = Set(i)
    end

    M = dist_matrix(data)


    len = length_connected(connected2, 1)
    N_connections = 0
    keep_going = true
    output = 0
    i = ()
    while len != size(data, 1)
        N_connections += 1
        i = argmin(M)
        push!(connected2[i[1]], i[2])
        push!(connected2[i[2]], i[1])
        M[i[1], i[2]] = typemax(Float64)
        M[i[2], i[1]] = typemax(Float64)

        if N_connections % 1000 == 0
            println(N_connections)
        end
        len = length_connected(connected2, 1)
        if len == size(data, 1)
            @show N_connections
            x1 = data[i[1], 1]
            x2 = data[i[2], 1]
            output = x1 * x2
        end
    end
    output
end


@show part1()
@show part2()
