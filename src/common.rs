pub trait Translate<S> {
    /// The type to translate to.
    type Target;

    /// The error type.
    type Error;

    /// Translate `source` to `Self::Target`.
    fn translate(&mut self, source: &S) -> Result<Self::Target, Self::Error>;
}