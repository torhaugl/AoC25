function parse_input(io)
    lines = readlines(io)
    mat = [c == '@' ? 1 : 0 for line in lines for c in line]
    mat = reshape(mat, length(lines[1]), length(lines))
    return mat
end

function check_neighbor(mat, i, j)
    # If nothing is there, exit early
    if mat[i,j] == 0
        return -1
    end

    # If something, check how many neighbors are rolls of paper
    v = findall(==(1), mat)
    # 8 adjacent neighbors
    neigh = [CartesianIndex(i+x,j+y) for x = -1:1 for y = -1:1 if (abs(x) + abs(y) > 0)]
    cnt = 0
    for n in neigh
        if n in v
            cnt += 1
        end
    end
    return cnt
end

function part1()
    #io = open("ex1")
    io = open("input")
    mat = parse_input(io)
    new_mat = [check_neighbor(mat, i, j) for i = 1:size(mat,1) for j = 1:size(mat,2)]
    new_mat = reshape(new_mat, size(mat,1), size(mat,2))
    score = length(findall(x-> (0 <= x < 4), new_mat))
    return score
end

function part2()
    #io = open("ex1")
    io = open("input")
    mat = parse_input(io)
    running = true
    score = 0
    while running
        new_mat = [check_neighbor(mat, i, j) for j = 1:size(mat,2) for i = 1:size(mat,1)]
        new_mat = reshape(new_mat, size(mat,1), size(mat,2))
        idx = findall(x-> (0 <= x < 4), new_mat)
        for i in idx
            mat[i] = 0
        end
        score += length(idx)
        if length(idx) == 0
            running = false
        end
    end
    return score
end

@show part1()
@show part2()
