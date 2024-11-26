---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        ; {NameRep}
        ; {Description}
        ; Inputs:
        ; (arg 1) RDI : {InputRegister}
        ; (arg 2) RSI :
        ; (arg 3) RDX :
        ; (arg 4) RCX :
        ; (arg 5) R8  :
        ; (arg 6) R9  :
        ;
        ; Outputs: RAX : {OutputRegister}
        {Name}:
            {Code}
            ret
        ]],
            {
                NameRep = rep(1),
                Name = i(1, 'assembly_suboutine'),
                Description = i(2, 'This function does ....'),
                InputRegister = i(3, 'The input register contains ....'),
                OutputRegister = i(4, 'The output register contains ....'),
                Code = i(5),
            }
        )
    ),
    ms(
        {
            { trig = 'move', snippetType = 'snippet' },
            { trig = 'move move', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        mov {}, {}
        ]],
            {
                i(1, 'rdi'),
                i(2, 'rax'),
            }
        )
    ),

    ms(
        {
            { trig = 'x86-64_modulus', snippetType = 'snippet', condition = nil },
            { trig = 'x86-64_div', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    ; Modulus division
    mov rax, 400                ; Load the number to be divided
    xor rdx, rdx                ; Clear rdx
    mov rcx, {Divisor}                  ; Divide input by {DivisorRep}
    div rcx                     ; Run the division. Division result stored in rax, modulo result (remainder) stored in rdx.
    cmp rdx, 0                  ; Compare rdx to 0
    jne {FailJump}  ; Jump here if result is not equal to 0
    jmp {SuccessJump}   ; Jump here if result is equal to 0
        ]],
            {
                Divisor = i(1, '4'),
                DivisorRep = rep(1),
                FailJump = i(2, 'jump_here_if_not_equal'),
                SuccessJump = i(3, 'jump_here_if_equal'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
