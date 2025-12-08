use crate::{Day, TaskResult};

pub const PARTS: Day = [part1, part2];

#[derive(Debug)]
struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(v: usize) -> Self {
        DSU { parent: vec![0; v] }
    }
    fn make_set(&mut self, v: usize) -> () {
        self.parent[v] = v;
    }
    fn find_set(&self, v: usize) -> usize {
        if self.parent[v] == v {
            v
        } else {
            self.find_set(self.parent[v])
        }
    }

    fn union_set(&mut self, a: usize, b: usize) -> () {
        let a_root = self.find_set(a);
        let b_root = self.find_set(b);
        if a_root != b_root {
            self.parent[b_root] = a_root;
        }
    }
}

fn parse_input(input: String) -> Vec<Vec<i64>> {
    input
        .lines()
        .map(|l| l.split(',').map(|x| x.parse().unwrap()).collect())
        .collect()
}

// Square distance (no need to square-root to compare distances)
fn dist_matrix(coords: &Vec<Vec<i64>>) -> Vec<(usize, usize, i64)> {
    let mut dist_matrix = vec![];
    for i in 0..coords.len() {
        for j in i + 1..coords.len() {
            let dx = coords[i][0] - coords[j][0];
            let dy = coords[i][1] - coords[j][1];
            let dz = coords[i][2] - coords[j][2];
            let dist = dx * dx + dy * dy + dz * dz;
            dist_matrix.push((i, j, dist));
        }
    }
    dist_matrix
}

fn part1(input: String) -> TaskResult {
    // For input, N_CONNECTIONS = 1000. For test, 10
    const N_CONNECTIONS: usize = 1000;

    // Coordinates of each junction
    let coords = parse_input(input);

    // Squared euclidean distance vector (i, j, dist)
    let mut dist = dist_matrix(&coords);
    dist.sort_by(|(_, _, d1), (_, _, d2)| d1.cmp(d2));

    // Initialize DSU
    let mut dsu = DSU::new(coords.len());
    for i in 0..coords.len() {
        dsu.make_set(i);
    }

    // Connect sets in DSU from minimum to maximum distance
    for n in 0..N_CONNECTIONS {
        let (i, j, _) = dist[n];
        dsu.union_set(i, j)
    }

    // Return product of 3 largest circuit groups
    let mut sizes = count_circuits(&dsu);
    sizes.sort();
    let ans: usize = sizes.iter().rev().take(3).product();
    ans.into()
}

fn count_circuits(dsu: &DSU) -> Vec<usize> {
    // Count number of components in each circuit (root node)
    let n = dsu.parent.len();
    let mut sizes: Vec<usize> = vec![0; n];
    for i in 0..n {
        let root = dsu.find_set(i);
        sizes[root] += 1;
    }
    sizes
}

fn part2(input: String) -> TaskResult {
    // Coordinates of each junction
    let coords = parse_input(input);

    // Squared euclidean distance vector (i, j, dist)
    let mut dist = dist_matrix(&coords);
    dist.sort_by(|(_, _, d1), (_, _, d2)| d1.cmp(d2));

    // Initialize DSU
    let mut dsu = DSU::new(coords.len());
    for i in 0..coords.len() {
        dsu.make_set(i);
    }

    // Connect sets in DSU from minimum to maximum distance
    let mut n = 0;
    let mut sizes = count_circuits(&dsu);
    sizes.sort();

    let mut i = 0;
    let mut j = 0;
    while sizes[sizes.len() - 1] != coords.len() {
        (i, j, _) = dist[n];
        dsu.union_set(i, j);
        sizes = count_circuits(&dsu);
        sizes.sort();
        n += 1;
    }
    let ans = coords[i][0] * coords[j][0];
    ans.into()
}
