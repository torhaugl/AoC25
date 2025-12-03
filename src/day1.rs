use crate::{Day, TaskResult};

pub const PARTS: Day = [part1, part2];

fn part1(input: String) -> TaskResult {
    let mut score = 0;
    let mut dial = 50;
    for line in input.lines() {
        let dir: char = line.chars().next().unwrap();
        let num: i64 = line[1..].parse().unwrap();
        match dir {
            'L' => dial = (dial + num) % 100,
            'R' => dial = (dial - num) % 100,
            _ => println!("ERROR dir must be LR"),
        }
        if dial == 0 {
            score += 1
        }
    }
    return score.into();
}

fn part2(input: String) -> TaskResult {
    let mut score = 0;
    let mut dial = 50;
    for line in input.lines() {
        let dir: char = line.chars().next().unwrap();
        let num: i64 = line[1..].parse().unwrap();
        for _ in 0..num {
            match dir {
                'L' => dial = (dial + 1) % 100,
                'R' => dial = (dial - 1) % 100,
                _ => println!("ERROR dir must be LR"),
            }
            if dial == 0 {
                score += 1
            }
        }
    }
    return score.into();
}
