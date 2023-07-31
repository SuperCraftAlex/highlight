module main

import os
import term

fn find_unescaped(str string, tofind u8) int {
	mut prv2 := u8(0)
	mut prv := u8(0)

	mut it := 0
	for c in str {
		if c == tofind && ((prv == c'\\' && prv2 == c'\\') || prv != c'\\') {
			return it
		}
		prv2 = prv
		prv = c
		it ++
	}

	return -1
}

fn strspn(str string, u string) string {
	mut o := ""
	for c in str {
		if !u.contains_u8(c) {
			break
		}
		o += c.ascii_str()
	}
	return o
}

fn rendsw(txt string, w string) bool {
	return txt.trim_string_right("\n").all_after_last("\n").all_before("//").all_after_last("\"").all_after_last("\'").trim_space().contains(w)
}

enum Lang {
	c
	cpp
	v
}

fn ends_with_lowercase (i string) bool {
	for b in lowercase.map(fn [i] (x string) bool {return i.ends_with(x)}) {
		if b == true {
			return true
		}
	}
	return false
}

fn highlight(txt string, lang Lang) string {
	mut left := txt
	mut out := ""

	for left.len > 0 {
		if left[0] == c' ' || left[0] == c'\n' {
			out += left[0].ascii_str()
			left = left[1..]
			continue
		}
		if left.starts_with("//") {
			t := left.all_before("\n")
			out += term.gray(t)
			left = left[t.len..]
			continue
		}
		if left.starts_with("/*") {
			t := left[2..].all_before("*/")
			out += term.gray(t)
			left = left[t.len..]
			continue
		}
		if lang == .c || lang == .cpp || lang == .v {
			if left.starts_with("#") || rendsw(out, "\\") {
				t := left.all_before("\n")
				if t.len == 0 {
					left = left[1..]
					out += "\n"
					continue
				}
				out += term.bright_yellow(t)
				left = left[t.len..]
				continue
			}
		}
		if left.starts_with("\"") {
			end := find_unescaped(left[1..], c'\"')
			if end < 0 {
				out += term.bright_green(left)
				left = ""
			}
			else {
				out += term.bright_green(left[..end+2])
				left = left[end+2..]
			}
			continue
		}
		if left.starts_with("\'") {
			end := find_unescaped(left[1..], c'\'')
			if end < 0 {
				out += term.bright_green(left)
				left = ""
			}
			else {
				out += term.bright_green(left[..end+2])
				left = left[end+2..]
			}
			continue
		}

		mut found := false

		if lang == .c || lang == .cpp || lang == .v {
			for x in c_symbols {
				if left.starts_with(x) {
					left = left[x.len..]
					out += term.white(x)
					found = true
					break
				}
			}
			if found { continue }

			for x in c_ops {
				if left.starts_with(x) {
					left = left[x.len..]
					out += term.magenta(x)
					found = true
					break
				}
			}
			if found { continue }
			if out.len == 0 || !ends_with_lowercase(out) {
				for x in c_nums {
					if left.starts_with(x) {
						left = left[x.len..]
						out += term.cyan(x)
						found = true
						break
					}
				}
				if found { continue }
			}
		}

		if out.len == 0 || term.reset(out[out.len-1].ascii_str()) !in c_normal {
			mut types := []string {}
			unsafe {
				match lang {
					.c { types = c_types }
					.cpp { types = cpp_types }
					.v { types = v_types }
				}
			}
			for x in types {
				if left.starts_with(x) && left[x.len..][0].ascii_str() !in c_normal {
					left = left[x.len..]
					out += term.green(x)
					found = true
					break
				}
			}
			if found { continue }

			mut keywords := []string {}
			unsafe {
				match lang {
					.c { keywords = c_statements }
					.cpp { keywords = cpp_keywords }
					.v { keywords = v_keywords }
				}
			}
			for x in keywords {
				if left.starts_with(x) && left[x.len..][0].ascii_str() !in c_normal {
					left = left[x.len..]
					out += term.blue(x)
					found = true
					break
				}
			}
			if found { continue }

			mut hfuncs := []string {}
			unsafe {
				match lang {
					.c { hfuncs = c_hfuncs }
					.cpp { hfuncs = c_hfuncs }
					.v { hfuncs = v_hfuncs }
				}
			}
			for x in hfuncs {
				if left.starts_with(x) && left[x.len..][0].ascii_str() !in c_normal {
					left = left[x.len..]
					out += term.bold(x)
					found = true
					break
				}
			}
			if found { continue }

			if lang in [.c, .cpp] {
				a := strspn(left, c_const)
				if a.len > 0 {
					if left[a.len].ascii_str() !in c_normal && (out.len == 0 || !ends_with_lowercase(out)) {
						out += term.yellow(a)
					}
					else {
						out += term.bright_white(a)
					}
					left = left[a.len..]
					continue
				}
			}
		}

		out += term.bright_white(left[0].ascii_str())
		left = left[1..]
	}

	return out
}

fn main() {
	if os.args.len < 3 {
		println("Invalid usage! Usage: highl -l[language] (-f|-s) text")
		return
	}

	lang := os.args[1][2..]
	typ := os.args[2]
	x := os.args[3]

	mut text := ""

	if typ == "-f" {
		text = os.read_file(x) or {
			println("Error reading file!")
			return
		}
	}
	else if typ == "-s" {
		text = x
	}
	else {
		println("Invalid type!")
		return
	}

	match lang {
		"C", "c" { println(highlight(text, .c)) }
		"C++", "CPP", "cpp" { println(highlight(text, .cpp)) }
		"v", "V" { println(highlight(text, .v)) }
		else {
			println("No syntax highlighting for language!\nSupported: c, v, cpp")
		}
	}
}