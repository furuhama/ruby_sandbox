#[no_mangle]
pub extern fn fib(n: i32) -> i32 {
    if n <= 1 {
        return 1;
    }

    fib(n-1) + fib(n-2)
}
