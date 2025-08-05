---@diagnostic disable: undefined-global, missing-parameter

-- local shareable = require('luasnippets.functions.shareable_snippets')

local function assembly(index)
    return sn(
        index,
        fmt(
            [[
    asm volatile (
        {AssemblyCode}
        : {OutputOperands}
        : {InputOperands}
        : {ClobberedRegisters}
    );
  ]],
            {
                AssemblyCode = i(1, '"mov $0, %%rax;"        // sys_read system call number (0)'),
                OutputOperands = i(2, '/* No output operands */'),
                InputOperands = i(3, '"r"(buffer)           // Input operand: Address of the buffer'),
                ClobberedRegisters = i(4, '"%rax", "%rdi", "%rsi", "%rdx" // Clobbered registers'),
            }
        )
    )
end

local snippets = {
    ms(
        {
            { trig = 'x86-64_string_loop', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    // Assembly to increment each character in the string until null terminator
    asm volatile (
        "mov %0, %%rsi;"         // Move the address of the string into rsi (pointer to the string)
        "start:"
        "movb (%%rsi), %%al;"    // Load the byte (character) at the address pointed by rsi into al
        "test %%al, %%al;"       // Test if the character is the null terminator (end of string)
        "jz end;"                // If it's null terminator, jump to the end
        "inc %%al;"              // Increment the value in al (the character)
        "movb %%al, (%%rsi);"    // Store the incremented value back into the string at the current position
        "inc %%rsi;"             // Move the pointer to the next character in the string
        "jmp start;"             // Jump back to the start of the loop
        "end:"
        : // No output operands
        : "r"(string)  // Input: address of the string
        : "%memory", "%rsi", "%al"  // Clobber memory, rsi (pointer), and al (accumulator register)
    );
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'assembly assembly', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{ASM}]], {
            ASM = assembly(1),
        })
    ),
    ms(
        {
            { trig = 'assembly_read_stdin', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    #define LENGTH 32
    char buffer[LENGTH];
    asm volatile("mov $0, %%rax;"                 // sys_read system call number (0)
                 "mov $0, %%rdi;"                 // File descriptor 0 (stdin)
                 "mov %0, %%rsi;"                 // Address of buffer
                 "mov %1, %%rdx;"                 // Max number of bytes to read (leaving room for '\0')
                 "syscall;"                       // Invoke system call
                 :                                /* no output operands */
                 : "r"(buffer), "i"(LENGTH)       // Input buffer, and input const length
                 : "%rax", "%rdi", "%rsi", "%rdx" // Clobbered registers
    );
    buffer[LENGTH] = '\0';
    printf("%.*s\n", LENGTH, buffer);
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'assembly_print', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    asm volatile("movq $1, %%rax;" // syscall number for write (1)
                 "movq ${Output}, %%rdi;" // file descriptor (stdout=1, stderr=2)
                 "movq %0, %%rsi;" // address of the string
                 "movq %1, %%rdx;" // length of the string
                 "syscall;"        // make the syscall
                 :
                 : "r"({buffer}), "i"({length})   // input operands: message address and length
                 : "rax", "rdi", "rsi", "rdx" // clobbered registers
    );
        ]],
            {
                Output = c(1, {
                    t('1'),
                    t('2'),
                }),
                buffer = i(2, 'buffer'),
                length = i(3, 'string_length'),
            }
        )
    ),

    ms(
        {
            { trig = 'assembly_full_check_if_number_is_power_of_2', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    // Declare "true" and "false" messages as static constants
    const char true_msg[] = "true\n";
    const char false_msg[] = "false\n";

    asm volatile(
        // Check if the number is 0
        "test %0, %0;"  // Test n with itself (check if n == 0)
        "jz zero_case;" // Jump to zero_case if n == 0

        // Check if n is a power of 2
        "mov %0, %%eax;"      // Copy n to eax (32-bit register)
        "dec %%eax;"          // Calculate n - 1
        "and %0, %%eax;"      // Perform n & (n - 1)
        "jnz not_power_of_2;" // Jump if result is non-zero

        // Print "true" (n is a power of 2)
        "mov $1, %%rax;"          // syscall: write
        "mov $1, %%rdi;"          // file descriptor: stdout
        "lea %[true_msg], %%rsi;" // address of "true" message
        "mov $5, %%rdx;"          // message length (5 bytes: "true\n")
        "syscall;"                // make the system call
        "jmp end;"                // Skip remaining cases

        // Print "false" (n is not a power of 2)
        "not_power_of_2:"
        "mov $1, %%rax;"           // syscall: write
        "mov $1, %%rdi;"           // file descriptor: stdout
        "lea %[false_msg], %%rsi;" // address of "false" message
        "mov $6, %%rdx;"           // message length (6 bytes: "false\n")
        "syscall;"                 // make the system call
        "jmp end;"                 // Skip zero_case

        // Print "false" (n is 0)
        "zero_case:"
        "mov $1, %%rax;"           // syscall: write
        "mov $1, %%rdi;"           // file descriptor: stdout
        "lea %[false_msg], %%rsi;" // address of "false" message
        "mov $6, %%rdx;"           // message length (6 bytes: "false\n")
        "syscall;"                 // make the system call

        // End of the program
        "end:"
        :
        : "r"(n), [true_msg] "m"(true_msg), [false_msg] "m"(false_msg) // Inputs
        : "rax", "rdi", "rsi", "rdx", "eax"                            // Clobbered registers
    );
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'assembly_x86-64_modulus_division', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    // Need 64 bit numbers for using 64 bit assembly
    long number = 801;
    long divisor = 4;
    long remainder = 0;

    // Perform division using inline assembly
    asm volatile("movq %[num], %%rax;"                   // Load the number into RAX (64-bit)
                 "xor %%rdx, %%rdx;"                     // Clear RDX (64-bit)
                 "movq %[div], %%rcx;"                   // Load the divisor into RCX (64-bit)
                 "div %%rcx;"                            // Perform division: RDX:RAX / RCX
                 "movq %%rdx, %[rem];"                   // Store remainder from RDX (lower 32 bits of RDX: RAX)
                 : [rem] "=r"(remainder)                 // Output
                 : [num] "r"(number), [div] "r"(divisor) // Inputs
                 : "%rax", "%rdx", "%rcx"                // Clobbered registers
    );

    fprintf(stderr, "Number: %ld, Divisor: %d, Remainder: %d\n", number, divisor, remainder);
        ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
