using OrderedCollections
function part1()
    io = open("input")
    parsing_ingredients = false
    id_ranges = []
    score = 0
    for line in readlines(io)
        if line == ""
            parsing_ingredients = true
            continue
        end
        in_range = false
        if parsing_ingredients
            num = parse(Int, line)
            for id_range in id_ranges
                if num in id_range
                    in_range = true
                end
            end
        else
            nums = split(line, '-')
            a = parse(Int, nums[1])
            b = parse(Int, nums[2])
            push!(id_ranges, a:b)
        end
        if in_range
            score += 1
        end
    end
    score
end

function merge_ranges(r1::UnitRange, r2::UnitRange)
    a, b = r1.start, r1.stop
    x, y = r2.start, r2.stop
    if a <= x <= b
        return (a:max(b, y), 0:-1)
    elseif x <= a <= y
        return (x:max(b, y), 0:-1)
    else
        return (r1, r2)
    end
end

function part2()
    io = open("input")

    # Parse input ranges
    id_ranges = [] #OrderedSet{UnitRange{Int64}}()
    for line in readlines(io)
        if line == ""
            break
        end
        nums = split(line, '-')
        a = parse(Int, nums[1])
        b = parse(Int, nums[2])
        push!(id_ranges, a:b)
    end
    sort!(id_ranges, by=x -> x.start)
    # Merge ranges
    new_ranges = [id_ranges[1]]
    for j in id_ranges[2:end]
        i = new_ranges[end]
        a, b = merge_ranges(i, j)
        if length(b) == 0
            pop!(new_ranges)
            push!(new_ranges, a)
        else
            push!(new_ranges, b)
        end
    end
    id_ranges = new_ranges

    score = 0
    for i in id_ranges
        score += length(i)
    end
    score
end

@show part1()
@show part2()
