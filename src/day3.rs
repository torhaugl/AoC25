use crate::{Day, TaskResult};

pub const PARTS: Day = [part1, part2];

fn find_highest_joltage(batteries: &[u8]) -> u8 {
    let (imax, a) = batteries
        .iter()
        .take(batteries.len() - 1)
        .enumerate()
        .rev() // max_by_key finds last max, reverse
        .max_by_key(|(_, battery)| *battery)
        .unwrap();
    let b = batteries.iter().skip(imax + 1).max().unwrap();
    let joltage = 10 * (a - b'0') + (b - b'0');
    return joltage;
}

fn part1(input: String) -> TaskResult {
    input
        .lines()
        .map(|l| l.as_bytes())
        .map(|x| find_highest_joltage(x) as u32)
        .sum::<u32>()
        .into()
}

fn find_highest_joltage2(batteries: &[u8]) -> u64 {
    let mut joltage = 0;
    let mut imax = 0;
    for j in 1..13 {
        let (i, a) = batteries
            .iter()
            .take(batteries.len() - 12 + j)
            .skip(imax)
            .enumerate()
            .rev() // max_by_key finds last max, reverse
            .max_by_key(|(_, battery)| *battery)
            .unwrap();
        imax = imax + i + 1;
        let num = (*a - b'0') as u64;
        joltage = 10 * joltage + num;
    }
    return joltage;
}

fn part2(input: String) -> TaskResult {
    input
        .lines()
        .map(|l| l.as_bytes())
        .map(|x| find_highest_joltage2(x) as u64)
        .sum::<u64>()
        .into()
}
