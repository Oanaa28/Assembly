; Interpret as 32 bits code
[bits 32]
section .text
; int check_parantheses(char *str)

extern printf
global check_parantheses

check_parantheses:
    push ebp
    mov ebp, esp
    ; sa-nceapa concursul
    pusha
    xor ecx, ecx
    xor eax, eax
    ; 8=pozitia sirului pe stiva 
    mov eax, [ebp + 8] 

verificare_paranteza:
    mov bl, byte [eax]
    test bl, bl 
    jz final_sir

p_rotunda:
    cmp bl, '('
    je adauga_in_stiva_1
    jmp p_patrata
adauga_in_stiva_1:
    movzx edx, bl
    push edx
    inc ecx
    inc eax
    jmp verificare_paranteza

p_patrata:
    cmp bl, '['
    je adauga_in_stiva_2
    jmp acolada
adauga_in_stiva_2:
    movzx edx, bl
    push edx
    inc ecx
    inc eax
    jmp verificare_paranteza

acolada:    
    cmp bl, '{'
    je adauga_in_stiva_3
    jmp p_rotunda_inchisa
adauga_in_stiva_3:
    movzx edx, bl
    push edx
    inc ecx
    inc eax
    jmp verificare_paranteza

p_rotunda_inchisa:
    cmp bl, ')'
    je extragere_din_stiva_1
    jmp p_patrata_inchisa

extragere_din_stiva_1:
    ;0=stiva goala
    cmp ecx, 0
    je continuare
    dec ecx
    pop edx
    mov bl, dl
    cmp bl, '('
    jne parantezare_incorecta
    inc eax
    jmp verificare_paranteza

p_patrata_inchisa:
    cmp bl, ']'
    je extragere_din_stiva_2
    jmp acolada_inchisa

extragere_din_stiva_2:
    ;0=stiva goala
    cmp ecx, 0
    je continuare
    dec ecx
    pop edx
    mov bl, dl
    cmp bl, '['
    jne parantezare_incorecta
    inc eax
    jmp verificare_paranteza

acolada_inchisa:    
    cmp bl, '}'
    je extragere_din_stiva_3
    inc eax
    jmp verificare_paranteza
extragere_din_stiva_3:
    ;0=stiva goala
    cmp ecx, 0
    je continuare
    dec ecx
    pop edx
    mov bl, dl
    cmp bl, '{'
    jne parantezare_incorecta
    inc eax
    jmp verificare_paranteza

final_sir:
    popa
    jmp parantezare_corecta
parantezare_incorecta:
    ;return 0 ( r = 0 )

golire_stiva:
    ;0=stiva goala
    cmp ecx, 0
    je continuare
    dec ecx
    pop ebx
    jmp golire_stiva
continuare:
    popa
    xor eax, eax
    ;return 0 ( r = 0 )
    mov eax, 1
    jmp end
parantezare_corecta:
    ;return 1 ( r = 1 )
    mov eax, 0
end:
    leave
    ret
