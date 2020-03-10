use std::collections::HashMap;

// fn main() {
//     // println!("Hello, world!");
//     // println!("{}", fibonacci(40))
//     // println!("{}", fib_memo(&mut HashMap::new(), 40))
// }

// #[no_mangle]
// pub extern fn fibonacci(n: i32) -> i32 {
//     match n {
//          1 => 1,
//          2 => 1,
//          _ => fibonacci(n - 1) + fibonacci(n - 2)
//     }
// }

#[no_mangle]
pub extern fn fib_memo (cache: &mut HashMap<u32, u32>, arg: u32) -> u32 {
    match cache.get(&arg).map(|entry| entry.clone()) {
        Some(result) => result,
        None => {
            let result = match arg {
                0 => 0,
                1 => 1,
                n => fib_memo(cache, n - 1) + fib_memo(cache, n - 2),
            };
            cache.insert(arg, result.clone());
            result
        }
    }
}