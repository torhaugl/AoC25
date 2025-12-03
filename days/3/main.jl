function part1(io)
    cnt = 0
    for line in eachline(io)
        x = [parse(Int, s) for s in line]
        a = maximum(x[1:end-1])
        i = findfirst(==(a), x)
        b = maximum(x[i+1:end])
        num = a*10 + b
        cnt += num
    end
    return cnt
end

function part2(io)
    cnt = 0
    nint = 12
    for line in eachline(io)
        x = [parse(Int, s) for s in line]
        idx = [0,]
        num = 0
        for j = 1:12
            a = maximum(x[idx[end]+1:end-nint+j])
            i = findfirst(==(a), x[idx[end]+1:end-nint+j])
            append!(idx, idx[end] + i)
            num = num*10 + a
        end
        cnt += num
    end
    return cnt
end

@show part1(open("test"))
@show part1(open("input"))
@show part2(open("test"))
@show part2(open("input"))
