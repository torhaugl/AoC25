"""
Check if invalid ID.
All invalid ID are two repeated numbers, e.g., 123123 (repeated number is 123).
"""
function isinvalid(id)

    ndigits = floor(Int, log10(id)) + 1

    # Number is repeated twice, cannot be odd length
    if isodd(ndigits)
        return false
    end

    # Split numbers into first and second part
    a = id ÷ 10^(ndigits ÷ 2)
    b = id - a * 10^(ndigits ÷ 2)

    return a == b
end

"""
Check if invalid ID.
All invalid ID are x repeated numbers, e.g., 123123 (repeated number is 123).
121212 (repeated number is 12).
"""
function isinvalid_v2(id)
    str_id = string(id)
    ndigits = length(str_id)

    # First split into 1-1-1-1
    # Then 2-2-2
    # Then 3-3 etc
    # range(ndigits) should be only products of prime factors of ndigits
    cnt = 0
    for i in 1:ndigits-1
        try
            x = [str_id[j:j+i-1] for j in range(1,ndigits,step=i)]
            if length(x) * i ≠ ndigits
                continue
            end
            cnt += allequal(x)
        catch
            continue
        end
    end

    return cnt > 0
end

function part1(io)
    a = read(io, String)
    b = split(a, ',')
    c = [parse.(Int,split(x, '-')) for x in b]
    d = [x[1]:x[2] for x in c]
    cnt = 0
    for x in d
        for r in x
            if isinvalid(r)
                cnt += r
            end
        end
    end
    return cnt
end


function part2(io)
    a = read(io, String)
    b = split(a, ',')
    c = [parse.(Int,split(x, '-')) for x in b]
    d = [x[1]:x[2] for x in c]
    cnt = 0
    for x in d
        for r in x
            if isinvalid_v2(r)
                cnt += r
            end
        end
    end
    return cnt
end

io = open("input")
@show part1(io)
seekstart(io)
@show part2(io)
