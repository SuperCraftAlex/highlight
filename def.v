module main
//

import term

const (
	lowercase = "abcdefghijklmnopqrstuvwxyz0123456789_".split("").map(fn (x string) string {return term.bright_white(x)})
)

// C
const (
	c_types = ["void", "int", "char", "unsigned", "struct", "signed", "short", "long", "float", "double", "size_t", "uint8_t", "int8_t", "uint16_t", "int16_t", "uint32_t", "int32_t", "uint64_t", "int64_t", "bool", "const", "static", "register", "ssize_t",
	"FILE"]
	c_statements = ["struct", "typedef", "for", "goto", "while", "continue", "break", "if", "else", "return", "case", "switch", "default", "do", "enum", "extern", "union", "volatile", "__asm", "__asm__", "asm"]
	c_symbols = ["[", "]", "{", "}", "(", ")", ";", ","]
	c_ops = ["<", ">", "=", "+", "-", "*", "/", "&", "!", "~", "^", "*", "&", "?", ":", "->", ".", "|", "$", "%"]
	c_nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ".", "true", "false", "0x"]
	c_hfuncs = ["strspn", "strcspn", "strcpy", "memcpy", "memset", "malloc", "calloc", "free", "sizeof", "strlen",
	"printf", "sprintf", "atoi", "atof", "scanf", "fgets", "fputs", "getchar", "putchar", "strcmp", "realloc",
	"fseek", "ftell", "rewind", "fopen", "fclose"]
	c_const = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789"
	c_normal = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_".split("")
)

// V
const (
	v_types = ["u8", "u16", "u32", "u64", "i8", "i16", "i32", "i64", "f32", "f64", "int", "char", "array", "string", "bool"]
	// uses c symbols, nums, ops and normals
	v_keywords = ["struct", "typedef", "for", "goto", "continue", "break", "if", "else", "return", "match", "enum", "volatile", "__asm", "__asm__", "asm", "fn", "module", "import", "mut", "unsafe"]
	v_hfuncs = ["malloc", "free", "realloc", "println", "print"]
)

// C++
const (
	cpp_types = [
		"int_fast8_t", "int_fast16_t", "int_fast32_t", "int_fast64_t",
		"int_least8_t", "int_least16_t", "int_least32_t", "int_least64_t",
		"intmax_t", "intptr_t",
		"uint_fast8_t", "uint_fast16_t", "uint_fast32_t", "uint_fast64_t",
		"uint_least8_t", "uint_least16_t", "uint_least32_t", "uint_least64_t",
		"uintmax_t", "uintptr_t",
		"wchar_t", "char16_t", "char32_t", "char8_t",
		"float16_t", "float32_t", "float64_t", "float128_t", "bfloat16_t"
	]
	cpp_keywords = [
		"alignas", "alignof", "and", "and_eq", "asm", "auto", "bitand", "bitor", "bool",
		"break", "case", "catch", "char", "char16_t", "char32_t", "class", "compl",
		"concept", "const", "const_cast", "consteval", "constexpr", "continue", "co_await",
		"co_return", "co_yield", "decltype", "default", "delete", "do", "double",
		"dynamic_cast", "else", "enum", "explicit", "export", "extern",
		"float", "for", "friend", "goto", "if", "import", "inline", "int", "long", "module",
		"mutable", "namespace", "new", "noexcept", "not", "not_eq", "nullptr", "operator",
		"or", "or_eq", "private", "protected", "public", "reflexpr", "register",
		"reinterpret_cast", "requires", "return", "short", "signed", "sizeof", "static",
		"static_assert", "static_cast", "struct", "switch", "synchronized", "template",
		"this", "thread_local", "throw", "try", "typedef", "typeid", "typename",
		"union", "unsigned", "using", "virtual", "void", "volatile", "wchar_t", "while",
		"xor", "xor_eq"
	]
)