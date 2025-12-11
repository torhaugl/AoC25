function parse_input(io)
    """ccc: ddd eee fff"""
    g = Dict{String,Vector{String}}()
    for line in readlines(io)
        words = split(line)
        key = String(words[1][1:end-1])
        values = [String(x) for x in words[2:end]]
        g[key] = values
    end
    g
end

"""
Memoized recursive DFS search
"""
function search(start, goal, g)
    stack = Vector{String}
    explored = Dict{String, Int}()

    function dfs(current)
        if current == goal
            return 1
        end
        # Memoization
        if current in keys(explored)
            return explored[current]
        end
        count = 0
        for w in get(g, current, [])
            count += dfs(w)
        end
        explored[current] = count
        return count
    end

    count = dfs(start)
    count
end

function part1()
    g = parse_input("input")
    start = "you"
    goal = "out"
    score = search(start, goal, g)
    score
end

function part2()
    g = parse_input("input")
    score = 0
    score1 = search("svr", "fft", g)
    score2 = search("fft", "dac", g)
    score3 = search("dac", "out", g)
    score += score1 * score2 * score3
    score1 = search("svr", "dac", g)
    score2 = search("dac", "fft", g)
    score3 = search("fft", "out", g)
    score += score1 * score2 * score3
    score
end

@show part1()
@show part2()
