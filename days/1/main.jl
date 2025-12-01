test = """L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"""

function part1(io)
    cnt = 0
    num = 50
    for line in readlines(io)
        dir = line[1]
        add = parse(Int, line[2:end])
        if dir == 'L'
            num = mod(num - add, 100)
        elseif dir == 'R'
            num = mod(num + add, 100)
        end
        cnt += (num == 0)
        @show num
    end
    return cnt
end


function part2(io)
    cnt = part1(io)
    seekstart(io)
    num = 50
    for line in readlines(io)
        dir = line[1]
        add = parse(Int, line[2:end])
        while add > 0
            if dir == 'L'
                num = mod(num - 1, 100)
            elseif dir == 'R'
                num = mod(num + 1, 100)
            end
            add -= 1
            cnt += (num == 0)
        end
        @show num
    end
    return cnt
end

#io = IOBuffer(test)
io = open("input")
@show part1(io)
@show part2(io)
