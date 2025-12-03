use crate::{Day, TaskResult};

pub const PARTS: Day = [part1, part2];

fn is_invalid(id: i32) -> bool {
    let id_str = id.to_string();
    let n_digits = id_str.len();
    if n_digits % 2 == 1 {
        return false;
    } else {
        let n = n_digits / 2;
        return id_str[0..n] == id_str[n..2 * n];
    }
}

fn part1(input: String) -> TaskResult {
    let mut score = 0;
    for line in input.trim().split(',') {
        let (a, b) = line.split_once('-').unwrap();
        let ai: i32 = a.parse().unwrap();
        let bi: i32 = b.parse().unwrap();
        let range = ai..bi + 1;
        for id in range {
            if is_invalid(id) {
                score += id;
            }
        }
    }
    return score.into();
}

fn is_invalid2(id: i64) -> bool {
    let id_str = id.to_string();
    let id_vec: Vec<u32> = id
        .to_string()
        .chars()
        .map(|x| x.to_digit(10).unwrap())
        .collect();
    let n_digits = id_str.len();

    for i in 1..1 + n_digits / 2 {
        let mut x = id_vec.chunks_exact(i);
        if x.len() * i != n_digits {
            continue;
        }
        // all equal
        let first = x.next().unwrap();
        let invalid = x.all(|item| item == first);
        if invalid {
            return true;
        }
    }
    return false;
}

fn part2(input: String) -> TaskResult {
    let mut score: i64 = 0;
    for line in input.trim().split(',') {
        let (a, b) = line.split_once('-').unwrap();
        let ai: i64 = a.parse().unwrap();
        let bi: i64 = b.parse().unwrap();
        let range = ai..bi + 1;
        for id in range {
            if is_invalid2(id) {
                score += id;
            }
        }
    }
    return score.into();
}
