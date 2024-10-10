; subtask 1 - qsort
section .text
    global quick_sort
    ;; no extern functions allowed

partition:
    push ebp
    mov ebp, esp
    ;edx = buff
    mov edx, [ebp + 8]  
    ;ecx = start
    mov ecx, [ebp + 12] 
    ;ebx = end
    mov ebx, [ebp + 16] 

    ;pivot = buff[end]
    mov edi, [edx + ebx * 4] 

    ;i = start - 1
    mov eax, ecx
    dec eax

    dec ecx
partition_loop:
    ;j = ecx
    inc ecx 
    cmp ecx, ebx
    jg partition_done

    ; if (buff[j] < pivot)
    ; buff[j]
    mov esi, [edx + ecx * 4]
    cmp esi, edi
    jge partition_loop
swap1:
    ;i++
    inc eax
    ;swap(buff[i], buff[j])
    push ebx
    xor ebx, ebx
    ;buff[i]
    mov ebx, [edx + eax * 4]
    ;swap
    push esi
    push ebx

    pop esi
    pop ebx
    ;4 = size of int
    mov [edx + eax * 4], ebx
    ;4 = size of int
    mov [edx + ecx * 4], esi

    pop ebx
    jmp partition_loop

partition_done:
    ;swap(buff[i + 1], buff[end])
    xor esi, esi 
    xor edi, edi

    ;buff[i+1]
    inc eax
    ;4 = size of int
    mov esi, [edx + 4 * eax] 
    ;buff[end]
    ;4 = size of int
    mov edi, [edx + 4 * ebx] 

    ;swap
    push esi
    push edi
    pop esi
    pop edi
    ;4 = size of int
    mov [edx + eax * 4], esi
    ;4 = size of int
    mov [edx + ebx * 4], edi

    leave
    ret

quick_sort:

    push ebp
    mov ebp, esp
    pusha

    ;edx = buff
    mov edx, [ebp + 8]  
    ;ebx = start
    mov ebx, [ebp + 12] 
    ;ecx = end
    mov ecx, [ebp + 16] 

    cmp ebx, ecx
    jge quick_sort_done

    ; pi = partition(buff, start, end)
    push ecx
    push ebx
    push edx
    call partition
    pop edx
    pop ebx
    pop ecx
    ; quick_sort(buff, start, pi - 1)
    dec eax
    push eax
    push ebx
    push edx
    call quick_sort
    pop edx
    pop ebx
    pop eax

    ; quick_sort(buff, pi + 1, end)
    add eax, 2
    push ecx
    push eax
    push edx
    call quick_sort
    pop edx
    pop eax
    pop ecx

quick_sort_done:

    popa
    leave
    ret
