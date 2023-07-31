#ifdef __GNUC__
#define unreachable __builtin_unreachable()
#else
#define unreachable do {} while (0)
#endif
#define exit(value) do { _exit0(value, _exit4_##value); unreachable; } while (0)
#define _exit0(value, ...) _exit1(value, __VA_ARGS__)
#define _exit1(value, ...) _exit2(__VA_ARGS__, _exit3(value), ~)
#define _exit2(a, b, ...) b
#define _exit3(value) asm("mov $" #value ", %di\n xor %rax, %rax\n mov $60, %al\n syscall")
#define _exit4_0 ~,asm("xor %rdi, %rdi\n xor %rax, %rax\n mov $60, %al\n syscall")
#define _exit4_1 ~,asm("xor %rdi, %rdi\n inc %rdi\n xor %rax, %rax\n mov $60, %al\n syscall")

asm(
        "write:\n"             // write syscall wrapper; the calling convention is pretty much ok as is
        "   movq $1,%rax\n"         // 1 = write syscall on x86_64
        "   syscall\n"
        "   ret\n");
int write(int fd, const void *buf, unsigned count);