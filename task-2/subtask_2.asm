; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers

    ;; recursive bsearch implementation goes here
    push esi
    push ebx 
    ; ecx = buff
    ; edx = needle

    ;ebx = start
    mov ebx, [ebp + 8] 
    ;esi = end
    mov esi, [ebp + 12] 
    cmp esi, ebx
    jl binary_search_done1
    ;mid
    xor eax, eax
    mov eax, esi
    sub eax, ebx
    ;1 = mutarea cu un bit la dreapta <=> /2
    shr eax, 1
    add eax, ebx
    ;4 = size of int
    mov edi, [ecx + 4 * eax]
    cmp edi, edx 
    je return
    jg return_left
    jmp return_right
return: 
    jmp done

binary_search_done1:
    xor eax, eax
    ; -1 = numarul cautat nu a fost gasit
    mov eax, -1
    jmp done

;left
;binary_search(buff, needle, start, mid - 1)
return_left: 
    ;scop utilizare ecx:
    ;actualizeaza valoarea lui eax in functia curenta
    ;cu vloarea lui eax din apelul recursiv
    push ecx
    dec eax
    ;mid
    push eax 
    ;start
    push ebx
    call binary_search
    mov ecx, eax
    pop ebx
    pop eax
    mov eax, ecx
    pop ecx
    jmp done
;right
;binary_search(buff, needle, mid + 1, end)
return_right: 
    ;scop utilizare ecx:
    ;actualizeaza valoarea lui eax in functia curenta
    ;cu vloarea lui eax din apelul recursiv
    push ecx
    inc eax
    push esi
    push eax
    call binary_search
    mov ecx, eax
    pop eax
    mov eax, ecx
    pop esi
    pop ecx
    jmp done
done:
    ;; restore the preserved registers
    pop ebx
    pop esi
    leave
    ret
