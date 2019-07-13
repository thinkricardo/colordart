func safeguardOddNumber(_ value: Int) -> Int {
    if value % 2 == 0 {
        return value + 1;
    }

    return value;
}
