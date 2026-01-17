use pest::Parser;
use pest_derive::Parser;
use std::rc::Rc;

use crate::ast;

/// Parser for the TeaLang programming language.
/// Uses Pest parser generator with grammar defined in the teapl.pest file
#[derive(Parser)]
#[grammar = "teapl.pest"]
pub struct TeaLangParser;

type ParseResult<T> = Result<T, String>;
type Pair<'a> = pest::iterators::Pair<'a, Rule>;

pub fn parse(input: &str) -> ParseResult<Box<ast::Program>> {
    let pairs = TeaLangParser::parse(Rule::program, input)
        .map_err(|e| format!("Parse error: {}", e))?;
    
    let mut elements = Vec::new();
    
    for pair in pairs {
        if pair.as_rule() == Rule::program {
            for inner in pair.into_inner() {
                match inner.as_rule() {
                    Rule::program_element => {
                        if let Some(elem) = parse_program_element(inner)? {
                            elements.push(*elem);
                        }
                    }
                    Rule::EOI => {}
                    _ => {}
                }
            }
        }
    }
    
    Ok(Box::new(ast::Program { elements }))
}

fn get_pos(pair: &Pair) -> usize {
    pair.as_span().start()
}

fn parse_program_element(pair: Pair) -> ParseResult<Option<Box<ast::ProgramElement>>> {
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::var_decl_stmt => {
                return Ok(Some(Box::new(ast::ProgramElement {
                    inner: ast::ProgramElementInner::VarDeclStmt(parse_var_decl_stmt(inner)?),
                })));
            }
            Rule::struct_def => {
                return Ok(Some(Box::new(ast::ProgramElement {
                    inner: ast::ProgramElementInner::StructDef(parse_struct_def(inner)?),
                })));
            }
            Rule::fn_decl_stmt => {
                return Ok(Some(Box::new(ast::ProgramElement {
                    inner: ast::ProgramElementInner::FnDeclStmt(parse_fn_decl_stmt(inner)?),
                })));
            }
            Rule::fn_def => {
                return Ok(Some(Box::new(ast::ProgramElement {
                    inner: ast::ProgramElementInner::FnDef(parse_fn_def(inner)?),
                })));
            }
            _ => {}
        }
    }
    Ok(None)
}

fn parse_struct_def(pair: Pair) -> ParseResult<Box<ast::StructDef>> {
    let pos = get_pos(&pair);
    let mut identifier = String::new();
    let mut decls = Vec::new();
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::identifier => identifier = inner.as_str().to_string(),
            Rule::var_decl_list => decls = parse_var_decl_list(inner)?,
            _ => {}
        }
    }
    
    Ok(Box::new(ast::StructDef { pos, identifier, decls }))
}

fn parse_var_decl_list(pair: Pair) -> ParseResult<Vec<ast::VarDecl>> {
    let mut decls = Vec::new();
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::var_decl {
            decls.push(*parse_var_decl(inner)?);
        }
    }
    Ok(decls)
}

fn parse_var_decl(pair: Pair) -> ParseResult<Box<ast::VarDecl>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    let identifier = inner_pairs[0].as_str().to_string();
    
    // Check patterns based on number of elements
    match inner_pairs.len() {
        1 => {
            // identifier only - scalar without type
            Ok(Box::new(ast::VarDecl {
                pos,
                identifier,
                type_specifier: Rc::new(None),
                inner: ast::VarDeclInner::Scalar(Box::new(ast::VarDeclScalar { pos })),
            }))
        }
        3 => {
            // identifier : type_spec - scalar with type
            let type_specifier = parse_type_spec(inner_pairs[2].clone())?;
            Ok(Box::new(ast::VarDecl {
                pos,
                identifier,
                type_specifier,
                inner: ast::VarDeclInner::Scalar(Box::new(ast::VarDeclScalar { pos })),
            }))
        }
        4 => {
            // identifier [ num ] - array without type
            let len = parse_num(inner_pairs[2].clone())? as usize;
            Ok(Box::new(ast::VarDecl {
                pos,
                identifier,
                type_specifier: Rc::new(None),
                inner: ast::VarDeclInner::Array(Box::new(ast::VarDeclArray { pos, len })),
            }))
        }
        6 => {
            // identifier [ num ] : type_spec - array with type
            let len = parse_num(inner_pairs[2].clone())? as usize;
            let type_specifier = parse_type_spec(inner_pairs[5].clone())?;
            Ok(Box::new(ast::VarDecl {
                pos,
                identifier,
                type_specifier,
                inner: ast::VarDeclInner::Array(Box::new(ast::VarDeclArray { pos, len })),
            }))
        }
        _ => Err(format!("Invalid var_decl pattern with {} elements", inner_pairs.len()))
    }
}

fn parse_type_spec(pair: Pair) -> ParseResult<Rc<Option<ast::TypeSepcifier>>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::kw_int => {
                return Ok(Rc::new(Some(ast::TypeSepcifier {
                    pos,
                    inner: ast::TypeSpecifierInner::BuiltIn(ast::BuiltIn::Int),
                })));
            }
            Rule::identifier => {
                return Ok(Rc::new(Some(ast::TypeSepcifier {
                    pos,
                    inner: ast::TypeSpecifierInner::Composite(inner.as_str().to_string()),
                })));
            }
            _ => {}
        }
    }
    
    Ok(Rc::new(None))
}

fn parse_num(pair: Pair) -> ParseResult<i32> {
    pair.as_str().parse::<i32>()
        .map_err(|e| format!("Failed to parse number: {}", e))
}

fn parse_var_decl_stmt(pair: Pair) -> ParseResult<Box<ast::VarDeclStmt>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::var_def => {
                return Ok(Box::new(ast::VarDeclStmt {
                    pos,
                    inner: ast::VarDeclStmtInner::Def(parse_var_def(inner)?),
                }));
            }
            Rule::var_decl => {
                return Ok(Box::new(ast::VarDeclStmt {
                    pos,
                    inner: ast::VarDeclStmtInner::Decl(parse_var_decl(inner)?),
                }));
            }
            _ => {}
        }
    }
    
    Err("Invalid var_decl_stmt".to_string())
}

fn parse_var_def(pair: Pair) -> ParseResult<Box<ast::VarDef>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    let identifier = inner_pairs[0].as_str().to_string();
    
    // Determine pattern based on structure
    // Look for lbracket to detect array
    let has_bracket = inner_pairs.iter().any(|p| p.as_rule() == Rule::lbracket);
    let has_colon = inner_pairs.iter().any(|p| p.as_rule() == Rule::colon);
    
    if has_bracket {
        // Array definition
        let len = parse_num(inner_pairs.iter().find(|p| p.as_rule() == Rule::num)
            .ok_or("Missing array length")?.clone())? as usize;
        
        let type_specifier = if has_colon {
            parse_type_spec(inner_pairs.iter().find(|p| p.as_rule() == Rule::type_spec)
                .ok_or("Missing type specifier")?.clone())?
        } else {
            Rc::new(None)
        };
        
        let vals = parse_right_val_list(inner_pairs.iter().find(|p| p.as_rule() == Rule::right_val_list)
            .ok_or("Missing value list")?.clone())?;
        
        Ok(Box::new(ast::VarDef {
            pos,
            identifier,
            type_specifier,
            inner: ast::VarDefInner::Array(Box::new(ast::VarDefArray { pos, len, vals })),
        }))
    } else {
        // Scalar definition
        let type_specifier = if has_colon {
            parse_type_spec(inner_pairs.iter().find(|p| p.as_rule() == Rule::type_spec)
                .ok_or("Missing type specifier")?.clone())?
        } else {
            Rc::new(None)
        };
        
        let val = parse_right_val(inner_pairs.iter().find(|p| p.as_rule() == Rule::right_val)
            .ok_or("Missing value")?.clone())?;
        
        Ok(Box::new(ast::VarDef {
            pos,
            identifier,
            type_specifier,
            inner: ast::VarDefInner::Scalar(Box::new(ast::VarDefScalar { pos, val })),
        }))
    }
}

fn parse_right_val_list(pair: Pair) -> ParseResult<Vec<ast::RightVal>> {
    let mut vals = Vec::new();
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::right_val {
            vals.push(*parse_right_val(inner)?);
        }
    }
    Ok(vals)
}

fn parse_right_val(pair: Pair) -> ParseResult<Box<ast::RightVal>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::bool_expr => {
                return Ok(Box::new(ast::RightVal {
                    pos,
                    inner: ast::RightValInner::BoolExpr(parse_bool_expr(inner)?),
                }));
            }
            Rule::arith_expr => {
                return Ok(Box::new(ast::RightVal {
                    pos,
                    inner: ast::RightValInner::ArithExpr(parse_arith_expr(inner)?),
                }));
            }
            _ => {}
        }
    }
    
    Err("Invalid right_val".to_string())
}

fn parse_bool_expr(pair: Pair) -> ParseResult<Box<ast::BoolExpr>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    if inner_pairs.is_empty() {
        return Err("Empty bool_expr".to_string());
    }
    
    // Parse first AND term
    let mut expr = parse_bool_and_term(inner_pairs[0].clone())?;
    
    // Process OR operations
    let mut i = 1;
    while i < inner_pairs.len() {
        if inner_pairs[i].as_rule() == Rule::op_or {
            let right = parse_bool_and_term(inner_pairs[i + 1].clone())?;
            expr = Box::new(ast::BoolExpr {
                pos: expr.pos,
                inner: ast::BoolExprInner::BoolBiOpExpr(Box::new(ast::BoolBiOpExpr {
                    pos: expr.pos,
                    op: ast::BoolBiOp::Or,
                    left: expr,
                    right,
                })),
            });
            i += 2;
        } else {
            i += 1;
        }
    }
    
    Ok(expr)
}

fn parse_bool_and_term(pair: Pair) -> ParseResult<Box<ast::BoolExpr>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    if inner_pairs.is_empty() {
        return Err("Empty bool_and_term".to_string());
    }
    
    // Parse first atom
    let first_unit = parse_bool_unit_atom(inner_pairs[0].clone())?;
    let mut expr = Box::new(ast::BoolExpr {
        pos: first_unit.pos,
        inner: ast::BoolExprInner::BoolUnit(first_unit),
    });
    
    // Process AND operations
    let mut i = 1;
    while i < inner_pairs.len() {
        if inner_pairs[i].as_rule() == Rule::op_and {
            let right_unit = parse_bool_unit_atom(inner_pairs[i + 1].clone())?;
            let right_expr = Box::new(ast::BoolExpr {
                pos: right_unit.pos,
                inner: ast::BoolExprInner::BoolUnit(right_unit),
            });
            
            expr = Box::new(ast::BoolExpr {
                pos: expr.pos,
                inner: ast::BoolExprInner::BoolBiOpExpr(Box::new(ast::BoolBiOpExpr {
                    pos: expr.pos,
                    op: ast::BoolBiOp::And,
                    left: expr,
                    right: right_expr,
                })),
            });
            i += 2;
        } else {
            i += 1;
        }
    }
    
    Ok(expr)
}

fn parse_bool_unit_atom(pair: Pair) -> ParseResult<Box<ast::BoolUnit>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    // Check for NOT operation: op_not ~ bool_unit_atom
    if inner_pairs.len() == 2 && inner_pairs[0].as_rule() == Rule::op_not {
        let cond = parse_bool_unit_atom(inner_pairs[1].clone())?;
        return Ok(Box::new(ast::BoolUnit {
            pos,
            inner: ast::BoolUnitInner::BoolUOpExpr(Box::new(ast::BoolUOpExpr {
                pos,
                op: ast::BoolUOp::Not,
                cond,
            })),
        }));
    }
    
    // Otherwise, it's a bool_unit_paren
    for inner in inner_pairs {
        if inner.as_rule() == Rule::bool_unit_paren {
            return parse_bool_unit_paren(inner);
        }
    }
    
    Err("Invalid bool_unit_atom".to_string())
}

fn parse_bool_unit_paren(pair: Pair) -> ParseResult<Box<ast::BoolUnit>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    // Filter out parentheses
    let filtered: Vec<_> = inner_pairs.into_iter()
        .filter(|p| p.as_rule() != Rule::lparen && p.as_rule() != Rule::rparen)
        .collect();
    
    // Check if it's a bool_expr or a comparison
    if filtered.len() == 1 && filtered[0].as_rule() == Rule::bool_expr {
        return Ok(Box::new(ast::BoolUnit {
            pos,
            inner: ast::BoolUnitInner::BoolExpr(parse_bool_expr(filtered[0].clone())?),
        }));
    }
    
    // Otherwise it's expr_unit ~ comp_op ~ expr_unit
    if filtered.len() == 3 {
        let left = parse_expr_unit(filtered[0].clone())?;
        let op = parse_comp_op(filtered[1].clone())?;
        let right = parse_expr_unit(filtered[2].clone())?;
        
        return Ok(Box::new(ast::BoolUnit {
            pos,
            inner: ast::BoolUnitInner::ComExpr(Box::new(ast::ComExpr {
                pos,
                op,
                left,
                right,
            })),
        }));
    }
    
    Err(format!("Invalid bool_unit_paren with {} filtered elements", filtered.len()))
}

fn parse_comp_op(pair: Pair) -> ParseResult<ast::ComOp> {
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::op_lt => return Ok(ast::ComOp::Lt),
            Rule::op_gt => return Ok(ast::ComOp::Gt),
            Rule::op_le => return Ok(ast::ComOp::Le),
            Rule::op_ge => return Ok(ast::ComOp::Ge),
            Rule::op_eq => return Ok(ast::ComOp::Eq),
            Rule::op_ne => return Ok(ast::ComOp::Ne),
            _ => {}
        }
    }
    Err("Invalid comp_op".to_string())
}

fn parse_arith_expr(pair: Pair) -> ParseResult<Box<ast::ArithExpr>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    if inner_pairs.is_empty() {
        return Err("Empty arith_expr".to_string());
    }
    
    // Parse first term
    let mut expr = parse_arith_term(inner_pairs[0].clone())?;
    
    // Process add/sub operations
    let mut i = 1;
    while i < inner_pairs.len() {
        if inner_pairs[i].as_rule() == Rule::arith_add_op {
            let op = parse_arith_add_op(inner_pairs[i].clone())?;
            let right = parse_arith_term(inner_pairs[i + 1].clone())?;
            
            expr = Box::new(ast::ArithExpr {
                pos: expr.pos,
                inner: ast::ArithExprInner::ArithBiOpExpr(Box::new(ast::ArithBiOpExpr {
                    pos: expr.pos,
                    op,
                    left: expr,
                    right,
                })),
            });
            i += 2;
        } else {
            i += 1;
        }
    }
    
    Ok(expr)
}

fn parse_arith_term(pair: Pair) -> ParseResult<Box<ast::ArithExpr>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    if inner_pairs.is_empty() {
        return Err("Empty arith_term".to_string());
    }
    
    // Parse first unit
    let first_unit = parse_expr_unit(inner_pairs[0].clone())?;
    let mut expr = Box::new(ast::ArithExpr {
        pos: first_unit.pos,
        inner: ast::ArithExprInner::ExprUnit(first_unit),
    });
    
    // Process mul/div operations
    let mut i = 1;
    while i < inner_pairs.len() {
        if inner_pairs[i].as_rule() == Rule::arith_mul_op {
            let op = parse_arith_mul_op(inner_pairs[i].clone())?;
            let right_unit = parse_expr_unit(inner_pairs[i + 1].clone())?;
            let right = Box::new(ast::ArithExpr {
                pos: right_unit.pos,
                inner: ast::ArithExprInner::ExprUnit(right_unit),
            });
            
            expr = Box::new(ast::ArithExpr {
                pos: expr.pos,
                inner: ast::ArithExprInner::ArithBiOpExpr(Box::new(ast::ArithBiOpExpr {
                    pos: expr.pos,
                    op,
                    left: expr,
                    right,
                })),
            });
            i += 2;
        } else {
            i += 1;
        }
    }
    
    Ok(expr)
}

fn parse_arith_add_op(pair: Pair) -> ParseResult<ast::ArithBiOp> {
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::op_add => return Ok(ast::ArithBiOp::Add),
            Rule::op_sub => return Ok(ast::ArithBiOp::Sub),
            _ => {}
        }
    }
    Err("Invalid arith_add_op".to_string())
}

fn parse_arith_mul_op(pair: Pair) -> ParseResult<ast::ArithBiOp> {
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::op_mul => return Ok(ast::ArithBiOp::Mul),
            Rule::op_div => return Ok(ast::ArithBiOp::Div),
            _ => {}
        }
    }
    Err("Invalid arith_mul_op".to_string())
}

fn parse_expr_unit(pair: Pair) -> ParseResult<Box<ast::ExprUnit>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    // Filter out delimiters for parenthesized expressions
    let filtered: Vec<_> = inner_pairs.iter()
        .filter(|p| !matches!(p.as_rule(), Rule::lparen | Rule::rparen))
        .cloned()
        .collect();
    
    // Handle negative number: op_sub ~ num
    if filtered.len() == 2 && filtered[0].as_rule() == Rule::op_sub && filtered[1].as_rule() == Rule::num {
        let num = parse_num(filtered[1].clone())?;
        return Ok(Box::new(ast::ExprUnit {
            pos,
            inner: ast::ExprUnitInner::Num(-num),
        }));
    }
    
    // Handle parenthesized expression: lparen ~ arith_expr ~ rparen
    if filtered.len() == 1 && filtered[0].as_rule() == Rule::arith_expr {
        return Ok(Box::new(ast::ExprUnit {
            pos,
            inner: ast::ExprUnitInner::ArithExpr(parse_arith_expr(filtered[0].clone())?),
        }));
    }
    
    // Handle function call
    if filtered.len() >= 1 && filtered[0].as_rule() == Rule::fn_call {
        return Ok(Box::new(ast::ExprUnit {
            pos,
            inner: ast::ExprUnitInner::FnCall(parse_fn_call(filtered[0].clone())?),
        }));
    }
    
    // Handle simple number
    if filtered.len() == 1 && filtered[0].as_rule() == Rule::num {
        let num = parse_num(filtered[0].clone())?;
        return Ok(Box::new(ast::ExprUnit {
            pos,
            inner: ast::ExprUnitInner::Num(num),
        }));
    }
    
    // Handle identifier with optional suffixes
    if inner_pairs.len() >= 1 && inner_pairs[0].as_rule() == Rule::identifier {
        let id = inner_pairs[0].as_str().to_string();
        
        // Build base left_val
        let mut base = Box::new(ast::LeftVal {
            pos,
            inner: ast::LeftValInner::Id(id),
        });
        
        // Process suffixes
        let mut i = 1;
        while i < inner_pairs.len() {
            match inner_pairs[i].as_rule() {
                Rule::expr_suffix => {
                    base = parse_expr_suffix_to_left_val(base, inner_pairs[i].clone())?;
                    i += 1;
                }
                _ => break,
            }
        }
        
        // Convert final left_val to expr_unit
        return left_val_to_expr_unit(base);
    }
    
    Err(format!("Invalid expr_unit with {} parts, filtered: {}", inner_pairs.len(), filtered.len()))
}

fn parse_expr_suffix_to_left_val(base: Box<ast::LeftVal>, suffix: Pair) -> ParseResult<Box<ast::LeftVal>> {
    let pos = base.pos;
    
    for inner in suffix.into_inner() {
        match inner.as_rule() {
            Rule::lbracket => continue,
            Rule::rbracket => continue,
            Rule::dot => continue,
            Rule::index_expr => {
                // Array indexing
                let idx = parse_index_expr(inner)?;
                return Ok(Box::new(ast::LeftVal {
                    pos,
                    inner: ast::LeftValInner::ArrayExpr(Box::new(ast::ArrayExpr {
                        pos,
                        arr: base,
                        idx,
                    })),
                }));
            }
            Rule::identifier => {
                // Member access
                let member_id = inner.as_str().to_string();
                return Ok(Box::new(ast::LeftVal {
                    pos,
                    inner: ast::LeftValInner::MemberExpr(Box::new(ast::MemberExpr {
                        pos,
                        struct_id: base,
                        member_id,
                    })),
                }));
            }
            _ => {}
        }
    }
    
    Ok(base)
}

fn left_val_to_expr_unit(lval: Box<ast::LeftVal>) -> ParseResult<Box<ast::ExprUnit>> {
    let pos = lval.pos;
    
    match &lval.inner {
        ast::LeftValInner::Id(id) => {
            Ok(Box::new(ast::ExprUnit {
                pos,
                inner: ast::ExprUnitInner::Id(id.clone()),
            }))
        }
        ast::LeftValInner::ArrayExpr(arr_expr) => {
            Ok(Box::new(ast::ExprUnit {
                pos,
                inner: ast::ExprUnitInner::ArrayExpr(arr_expr.clone()),
            }))
        }
        ast::LeftValInner::MemberExpr(mem_expr) => {
            Ok(Box::new(ast::ExprUnit {
                pos,
                inner: ast::ExprUnitInner::MemberExpr(mem_expr.clone()),
            }))
        }
    }
}

fn parse_index_expr(pair: Pair) -> ParseResult<Box<ast::IndexExpr>> {
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::num => {
                let num = parse_num(inner)? as usize;
                return Ok(Box::new(ast::IndexExpr {
                    pos: 0,
                    inner: ast::IndexExprInner::Num(num),
                }));
            }
            Rule::identifier => {
                return Ok(Box::new(ast::IndexExpr {
                    pos: 0,
                    inner: ast::IndexExprInner::Id(inner.as_str().to_string()),
                }));
            }
            _ => {}
        }
    }
    Err("Invalid index_expr".to_string())
}

fn parse_fn_call(pair: Pair) -> ParseResult<Box<ast::FnCall>> {
    let pos = get_pos(&pair);
    let mut name = String::new();
    let mut vals = Vec::new();
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::identifier => name = inner.as_str().to_string(),
            Rule::right_val_list => vals = parse_right_val_list(inner)?,
            _ => {}
        }
    }
    
    Ok(Box::new(ast::FnCall { pos, name, vals }))
}

fn parse_left_val(pair: Pair) -> ParseResult<Box<ast::LeftVal>> {
    let pos = get_pos(&pair);
    let inner_pairs: Vec<_> = pair.into_inner().collect();
    
    if inner_pairs.is_empty() {
        return Err("Empty left_val".to_string());
    }
    
    let id = inner_pairs[0].as_str().to_string();
    
    // Build base left_val
    let mut base = Box::new(ast::LeftVal {
        pos,
        inner: ast::LeftValInner::Id(id),
    });
    
    // Process suffixes
    let mut i = 1;
    while i < inner_pairs.len() {
        match inner_pairs[i].as_rule() {
            Rule::left_val_suffix => {
                base = parse_left_val_suffix(base, inner_pairs[i].clone())?;
                i += 1;
            }
            _ => break,
        }
    }
    
    Ok(base)
}

fn parse_left_val_suffix(base: Box<ast::LeftVal>, suffix: Pair) -> ParseResult<Box<ast::LeftVal>> {
    let pos = base.pos;
    
    for inner in suffix.into_inner() {
        match inner.as_rule() {
            Rule::lbracket => continue,
            Rule::rbracket => continue,
            Rule::dot => continue,
            Rule::index_expr => {
                // Array indexing
                let idx = parse_index_expr(inner)?;
                return Ok(Box::new(ast::LeftVal {
                    pos,
                    inner: ast::LeftValInner::ArrayExpr(Box::new(ast::ArrayExpr {
                        pos,
                        arr: base,
                        idx,
                    })),
                }));
            }
            Rule::identifier => {
                // Member access
                let member_id = inner.as_str().to_string();
                return Ok(Box::new(ast::LeftVal {
                    pos,
                    inner: ast::LeftValInner::MemberExpr(Box::new(ast::MemberExpr {
                        pos,
                        struct_id: base,
                        member_id,
                    })),
                }));
            }
            _ => {}
        }
    }
    
    Ok(base)
}

// Function declarations and definitions

fn parse_fn_decl_stmt(pair: Pair) -> ParseResult<Box<ast::FnDeclStmt>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::fn_decl {
            return Ok(Box::new(ast::FnDeclStmt {
                pos,
                fn_decl: parse_fn_decl(inner)?,
            }));
        }
    }
    
    Err("Invalid fn_decl_stmt".to_string())
}

fn parse_fn_decl(pair: Pair) -> ParseResult<Box<ast::FnDecl>> {
    let pos = get_pos(&pair);
    let mut identifier = String::new();
    let mut param_decl = None;
    let mut return_dtype = Rc::new(None);
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::identifier => identifier = inner.as_str().to_string(),
            Rule::param_decl => param_decl = Some(parse_param_decl(inner)?),
            Rule::type_spec => return_dtype = parse_type_spec(inner)?,
            _ => {}
        }
    }
    
    Ok(Box::new(ast::FnDecl {
        pos,
        identifier,
        param_decl,
        return_dtype,
    }))
}

fn parse_param_decl(pair: Pair) -> ParseResult<Box<ast::ParamDecl>> {
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::var_decl_list {
            return Ok(Box::new(ast::ParamDecl {
                decls: parse_var_decl_list(inner)?,
            }));
        }
    }
    Err("Invalid param_decl".to_string())
}

fn parse_fn_def(pair: Pair) -> ParseResult<Box<ast::FnDef>> {
    let pos = get_pos(&pair);
    let mut fn_decl = None;
    let mut stmts = Vec::new();
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::fn_decl => fn_decl = Some(parse_fn_decl(inner)?),
            Rule::code_block_stmt => stmts.push(*parse_code_block_stmt(inner)?),
            _ => {}
        }
    }
    
    Ok(Box::new(ast::FnDef {
        pos,
        fn_decl: fn_decl.ok_or("Missing fn_decl in fn_def")?,
        stmts,
    }))
}

// Statement parsing

fn parse_code_block_stmt(pair: Pair) -> ParseResult<Box<ast::CodeBlockStmt>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::var_decl_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::VarDecl(parse_var_decl_stmt(inner)?),
                }));
            }
            Rule::assignment_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Assignment(parse_assignment_stmt(inner)?),
                }));
            }
            Rule::call_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Call(parse_call_stmt(inner)?),
                }));
            }
            Rule::if_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::If(parse_if_stmt(inner)?),
                }));
            }
            Rule::while_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::While(parse_while_stmt(inner)?),
                }));
            }
            Rule::return_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Return(parse_return_stmt(inner)?),
                }));
            }
            Rule::continue_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Continue(Box::new(ast::ContinueStmt { pos })),
                }));
            }
            Rule::break_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Break(Box::new(ast::BreakStmt { pos })),
                }));
            }
            Rule::null_stmt => {
                return Ok(Box::new(ast::CodeBlockStmt {
                    pos,
                    inner: ast::CodeBlockStmtInner::Null(Box::new(ast::NullStmt { pos })),
                }));
            }
            _ => {}
        }
    }
    
    Err("Invalid code_block_stmt".to_string())
}

fn parse_assignment_stmt(pair: Pair) -> ParseResult<Box<ast::AssignmentStmt>> {
    let pos = get_pos(&pair);
    let mut left_val = None;
    let mut right_val = None;
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::left_val => left_val = Some(parse_left_val(inner)?),
            Rule::right_val => right_val = Some(parse_right_val(inner)?),
            _ => {}
        }
    }
    
    Ok(Box::new(ast::AssignmentStmt {
        pos,
        left_val: left_val.ok_or("Missing left_val")?,
        right_val: right_val.ok_or("Missing right_val")?,
    }))
}

fn parse_call_stmt(pair: Pair) -> ParseResult<Box<ast::CallStmt>> {
    let pos = get_pos(&pair);
    
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::fn_call {
            return Ok(Box::new(ast::CallStmt {
                pos,
                fn_call: parse_fn_call(inner)?,
            }));
        }
    }
    
    Err("Invalid call_stmt".to_string())
}

fn parse_return_stmt(pair: Pair) -> ParseResult<Box<ast::ReturnStmt>> {
    let pos = get_pos(&pair);
    let mut val = None;
    
    for inner in pair.into_inner() {
        if inner.as_rule() == Rule::right_val {
            val = Some(parse_right_val(inner)?);
        }
    }
    
    Ok(Box::new(ast::ReturnStmt { pos, val }))
}

fn parse_if_stmt(pair: Pair) -> ParseResult<Box<ast::IfStmt>> {
    let pos = get_pos(&pair);
    let mut bool_unit = None;
    let mut if_stmts = Vec::new();
    let mut else_stmts = None;
    let mut in_else = false;
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::bool_unit_paren => {
                bool_unit = Some(parse_bool_unit_paren(inner)?);
            }
            Rule::code_block_stmt => {
                if in_else {
                    if else_stmts.is_none() {
                        else_stmts = Some(Vec::new());
                    }
                    else_stmts.as_mut().unwrap().push(*parse_code_block_stmt(inner)?);
                } else {
                    if_stmts.push(*parse_code_block_stmt(inner)?);
                }
            }
            Rule::kw_else => {
                in_else = true;
            }
            _ => {}
        }
    }
    
    Ok(Box::new(ast::IfStmt {
        pos,
        bool_unit: bool_unit.ok_or("Missing bool_unit")?,
        if_stmts,
        else_stmts,
    }))
}

fn parse_while_stmt(pair: Pair) -> ParseResult<Box<ast::WhileStmt>> {
    let pos = get_pos(&pair);
    let mut bool_unit = None;
    let mut stmts = Vec::new();
    
    for inner in pair.into_inner() {
        match inner.as_rule() {
            Rule::bool_unit_paren => {
                bool_unit = Some(parse_bool_unit_paren(inner)?);
            }
            Rule::code_block_stmt => {
                stmts.push(*parse_code_block_stmt(inner)?);
            }
            _ => {}
        }
    }
    
    Ok(Box::new(ast::WhileStmt {
        pos,
        bool_unit: bool_unit.ok_or("Missing bool_unit")?,
        stmts,
    }))
}

