use rand::Rng;

// generate random code between 0 to 10 of length  ->`length`
pub fn generate_random_code(length: i32) -> String {
    let mut original: String = "".to_owned();
    for _ in 0..length {
        let num = rand::thread_rng().gen_range(0..10);
        original.push_str(&*num.to_string());
    }
    return original;
}