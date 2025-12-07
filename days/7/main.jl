global n_split = 0
function iterate(lasers, splitters)
    new_lasers = []
    for l in lasers
        new = (l[1], l[2]-1)
        if new in lasers
            continue
        end
        if new in splitters
            global n_split += 1
            push!(new_lasers, (new[1] - 1, new[2]))
            push!(new_lasers, (new[1] + 1, new[2]))
        else
            push!(new_lasers, new)
        end
    end
    unique(new_lasers)
end

function part1()
    io = open("input", "r")
    splitters = []
    start = ()
    n_lines = 0
    for (i, line) in enumerate(readlines(io))
        n_lines += 1
        for (j, c) in enumerate(line)
            if c == 'S'
                start = (j,-i)
            end
            if c == '^'
                push!(splitters, (j,-i))
            end
        end
    end
    lasers = [(start[1], start[2] - 1),]
    for _ = 1:n_lines
        lasers = iterate(lasers, splitters)
    end
    @show n_split
end

"""
Memoized recursive function
"""
global memory = Dict()
function recursive_iterate(position, splitters)
    if position in keys(memory)
        return memory[position]
    end
    global n_lines
    if position[2] < - n_lines
        return 1
    elseif position in splitters
        new_pos1 = (position[1]-1, position[2])
        a = recursive_iterate(new_pos1, splitters)
        memory[new_pos1] = a
        new_pos2 = (position[1]+1, position[2])
        b = recursive_iterate(new_pos2, splitters)
        memory[new_pos2] = b
        return a + b
    else
        new_pos = (position[1], position[2] - 1)
        return recursive_iterate(new_pos, splitters)
    end
end

function part2()
    io = open("input", "r")
    splitters = Set{Tuple{Int,Int}}()
    start = (0, 0)
    global n_lines = 0
    for (i, line) in enumerate(readlines(io))
        n_lines += 1
        for (j, c) in enumerate(line)
            if c == 'S'
                start = (j,-i)
            end
            if c == '^'
                push!(splitters, (j,-i))
            end
        end
    end
    score = recursive_iterate(start, splitters)
    @show score
end

part1()
part2()
