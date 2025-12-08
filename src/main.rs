// Inspired by https://github.com/MarcusTL12/AdventOfCode2025Rust
use home::home_dir;
use std::{env, fmt::Display, fs::read_to_string, time::Instant};

mod day1;
mod day2;
mod day3;
mod day8;

enum TaskResult {
    Number(i64),
    Generic(Box<dyn Display>),
}

impl Display for TaskResult {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Number(n) => n.fmt(f),
            Self::Generic(s) => s.fmt(f),
        }
    }
}

impl TaskResult {
    fn generic<T: Display + 'static>(x: T) -> TaskResult {
        Self::Generic(Box::new(x))
    }
}

impl<T: TryInto<i64> + Clone + Display + 'static> From<T> for TaskResult
where
    T::Error: std::fmt::Debug,
{
    fn from(value: T) -> Self {
        if let Ok(n) = value.clone().try_into() {
            Self::Number(n)
        } else {
            Self::generic(value)
        }
    }
}

type Day = [fn(String) -> TaskResult; 2];

const DAYS: &[Day] = &[
    day1::PARTS,
    day2::PARTS,
    day3::PARTS,
    day8::PARTS,
    //day5::PARTS,
    //day3::PARTS,
];

fn load_input(day: usize, example: usize) -> String {
    let path = home_dir()
        .unwrap()
        .join("projects/aoc25")
        .join(format!("days/{day}"))
        .join(if example == 0 {
            "input".to_string()
        } else {
            format!("ex{example}")
        });

    read_to_string(path).unwrap()
}

fn main() {
    let mut args = env::args();

    args.next();

    let quest: usize = args
        .next()
        .expect("Give day number as first cli argument")
        .parse()
        .expect("Day number not numeric");

    let part: usize = args
        .next()
        .expect("Give part as second cli argument")
        .parse()
        .expect("Part not numeric");

    let example: usize = args.next().map(|s| s.parse().unwrap()).unwrap_or(0);

    let t = Instant::now();

    let input = load_input(quest, example);

    let t_load = t.elapsed();

    println!("Loading input took: {t_load:?}");

    let t = Instant::now();

    //let result = DAYS[quest - 1][part - 1](input);
    let result = DAYS[3][1](input);

    let t_solve = t.elapsed();

    println!("{result}");

    println!("Solving took: {t_solve:?}");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day1_part1_ex1() {
        let quest = 1;
        let part = 1;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 3),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
    #[test]
    fn day1_part2_ex1() {
        let quest = 1;
        let part = 2;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 6),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
    #[test]
    fn day2_part1_ex1() {
        let quest = 2;
        let part = 1;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 1227775554),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
    #[test]
    fn day2_part2_ex1() {
        let quest = 2;
        let part = 2;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 4174379265),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
    #[test]
    fn day3_part1_ex1() {
        let quest = 3;
        let part = 1;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 357),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
    #[test]
    fn day3_part2_ex1() {
        let quest = 3;
        let part = 2;
        let input = load_input(quest, 1);
        match DAYS[quest - 1][part - 1](input) {
            TaskResult::Number(x) => assert_eq!(x, 3121910778619),
            TaskResult::Generic(x) => panic!("'{x}' should not be generic"),
        }
    }
}
