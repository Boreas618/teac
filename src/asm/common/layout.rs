//! Struct layouts and type size/alignment utilities.
use crate::asm::error::Error;
use crate::ir;
use std::collections::HashMap;

/// Computed memory layout for a struct type.
#[derive(Debug, Clone)]
pub struct StructLayout {
    /// Total size in bytes.
    pub size: i64,
    /// Required alignment in bytes.
    pub align: i64,
    /// Byte offset of each field from the start of the struct.
    pub field_offsets: Vec<i64>,
}

/// Collection of struct layouts, keyed by struct name.
#[derive(Debug, Default, Clone)]
pub struct StructLayouts(HashMap<String, StructLayout>);

impl StructLayouts {
    /// Creates layouts from IR struct type definitions.
    ///
    /// Processes structs in definition order, assuming dependencies are defined
    /// before being used as members of other structs.
    pub fn from_struct_types(
        structs: &indexmap::IndexMap<String, ir::StructType>,
    ) -> Result<Self, Error> {
        let mut layouts = Self::default();
        for (name, st) in structs.iter() {
            let layout = layouts.compute_single_layout(st)?;
            layouts.insert(name.clone(), layout);
        }
        Ok(layouts)
    }

    pub fn get(&self, name: &str) -> Option<&StructLayout> {
        self.0.get(name)
    }

    fn insert(&mut self, name: String, layout: StructLayout) {
        self.0.insert(name, layout);
    }

    /// Returns (size, alignment) in bytes for a data type.
    ///
    /// # Errors
    ///
    /// Returns [`Error::UnsupportedDtype`] for unsupported types, or
    /// [`Error::MissingStructLayout`] if a struct layout is not found.
    pub fn size_align_of(&self, dtype: &ir::Dtype) -> Result<(i64, i64), Error> {
        match dtype {
            ir::Dtype::I32 => Ok((4, 4)),
            ir::Dtype::Pointer { .. } => Ok((8, 8)),
            ir::Dtype::Struct { type_name } => {
                let layout = self
                    .get(type_name)
                    .ok_or_else(|| Error::MissingStructLayout {
                        name: type_name.clone(),
                    })?;
                Ok((layout.size, layout.align))
            }
            _ => Err(Error::UnsupportedDtype {
                dtype: dtype.clone(),
            }),
        }
    }

    /// Returns (size, alignment) for a struct member field.
    ///
    /// This differs from `size_align_of` in how it handles pointers:
    /// - `length == 0`: pointer value (8 bytes)
    /// - `length > 0`: inline array of `length` elements
    fn size_align_of_member(&self, dtype: &ir::Dtype) -> Result<(i64, i64), Error> {
        match dtype {
            ir::Dtype::I32 => Ok((4, 4)),
            ir::Dtype::Pointer { inner, length } => match length {
                0 => Ok((8, 8)), // Pointer value
                n => {
                    // Array of elements
                    let (s, a) = self.size_align_of(inner.as_ref())?;
                    Ok(((*n as i64) * s, a))
                }
            },
            ir::Dtype::Struct { type_name } => self
                .get(type_name)
                .map(|l| (l.size, l.align))
                .ok_or_else(|| Error::MissingStructLayout {
                    name: type_name.clone(),
                }),
            other => Err(Error::UnsupportedDtype {
                dtype: other.clone(),
            }),
        }
    }

    /// Computes layout for a single struct type.
    ///
    /// All referenced struct types must already be present in `self`.
    fn compute_single_layout(&self, st: &ir::StructType) -> Result<StructLayout, Error> {
        let mut field_offsets = vec![0i64; st.elements.len()];
        let mut offset = 0i64;
        let mut max_align = 1i64;

        for (i, (_, member)) in st.elements.iter().enumerate() {
            let (size, align) = self.size_align_of_member(&member.dtype)?;

            offset = align_up(offset, align);
            max_align = max_align.max(align);
            field_offsets[i] = offset;
            offset += size;
        }

        Ok(StructLayout {
            size: align_up(offset, max_align),
            align: max_align,
            field_offsets,
        })
    }
}

/// Aligns a value up to the given alignment.
///
/// # Examples
///
/// ```ignore
/// assert_eq!(align_up(5, 4), 8);
/// assert_eq!(align_up(8, 4), 8);
/// assert_eq!(align_up(0, 16), 0);
/// ```
#[inline]
pub fn align_up(x: i64, align: i64) -> i64 {
    if align <= 1 {
        x
    } else {
        ((x + align - 1) / align) * align
    }
}

