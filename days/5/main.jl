using DelimitedFiles

function part1()
    data = readdlm("input")
    syms = [only(String(c)) for c in data[end, :]]
    nums = [col[1:end-1] for col in eachcol(data)]

    score = 0
    for (s, v) in zip(syms, nums)
        if s == '*'
            score += reduce(*, v)
        elseif s == '+'
            score += reduce(+, v)
        else
            error("did not recognize $s")
        end
    end
    score
end
function part2()
    # Read nums
    data = readdlm("input")
    nums = [col[1:end-1] for col in eachcol(data)]
    colwidth = 2 .+ (floor.(Int, log10.(maximum.(nums))))
    #@show colwidth

    io = open("input", "r")
    data = [l for l in readlines(io)]

    close(io)
    k = 1

    nums = []
    curr = 0
    for k = 1:length(colwidth)
        v = []
        for j = 1:colwidth[k]-1
            #num = prod(data[i][j] for i in 1:length(data)-1)
            num = parse(Int, strip(prod(data[i][curr + j] for i in 1:length(data)-1)))
            push!(v, num)
        end
        push!(nums, v)
        curr += colwidth[k]
    end
    @show nums


    #display(data)
    #exit()

    # Continue from part1
    data = readdlm("input")
    syms = [only(String(c)) for c in data[end, :]]

    score = 0
    for (s, v) in zip(syms, nums)
        if s == '*'
            score += reduce(*, v)
        elseif s == '+'
            score += reduce(+, v)
        else
            error("did not recognize $s")
        end
    end
    score
end
@show part1()
@show part2()
