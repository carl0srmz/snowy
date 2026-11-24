//! Names for scripts that are too involved for the plain `Op` set. Each name is
//! implemented natively in the game (see `game/src/behaviors.rs`).

/// `flat` is the decompiled script with all whitespace collapsed.
pub fn name_for(flat: &str) -> Option<&'static str> {
    let table: &[(&str, &str)] = &[];
    for (needle, name) in table {
        if flat.contains(needle) {
            return Some(name);
        }
    }
    None
}
