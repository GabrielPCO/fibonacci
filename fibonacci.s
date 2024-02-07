// Fibonacci em assembly A64
// O programa a seguir imprime a sequência fibonacci do tamanho escolhido pelo usuário no terminal

.global _start // Inicialização

.section .data // Sessão de dados (declarando variáveis)
    	num: .byte 0 // Declaração de variável numérica

	msg: .ascii "Sequência Fibonacci (" // Texto mensagem 1
	mlen = . - msg // Comprimento do texto

	msg2: .ascii " dígitos): " // Texto mensagem 2
	m2len = . - msg2 // Comprimento do texto

	space: .ascii " "// Texto 'espaço'
	slen = . - space // Comprimento do texto

	jump: .ascii "\n"// Texto 'pular linha'
	jlen = . - jump // Comprimento do texto

	err: .ascii "Erro: Parâmetro inválido! Digite o comando './fibonacci' seguido do tamanho da sequência desejada: ex. './fibonacci 6'" // Texto mensagem 3
	elen = . - err // Comprimento do texto

.section .text // Sessão de texto
_start:
    	// Função inicial
	ldr x0, [sp] // Carrega o argumento 'argc' (que é o número de argumentos encontrados na linha de comando) para x0

	// Validação do comando
	cmp x0, 2    // Compara x0 com o número 2 para verificar se ao menos um argumento foi passado para o comando ./fibonacci
	beq _loadPre // Pula para a função de carregamento dos argumentos em caso positivo (_loadPre)

	b _error     // pula para a finalização do programa com menssagem de erro (caso o comando não tenha nenhum argumento)

_loadPre:
        // Função para carregar os argumentos do comando
        mov x0, 0             // Move o valor 0 para x0
        mov w2, 0             // Move o valor 0 para w2
        mov w4, 10            // Move o valor 10 para w4 que multiplicará os dígitos recebidos para a conversão da string em inteiro
        ldr x1, [sp, 16]      // Carrega o valor presente no stack pointer para x1
_loadNum:
        ldrb w3, [x1, x0]     // Carrega o byte respectiv (x0) de x1 para w3
        cmp w3, 0             // Verifica se está no final da string
        beq _main             // Em caso positivo vai para a função _main
        sub w3, w3, 48        // Subtrai 48 do valor de w3 para convertem em inteiro
        madd w2, w2, w4, w3   // Multiplica o valor de w2 por 10 e soma com o valor em w3
        add x0, x0, 1         // Adiciona 1 a x0
        b _loadNum            // Retorna ao início da função _loadNum

_main:
	// Inicialização dos registradores
    	uxtw x7, w2    // Tamanho da sequência
	mov x6, xzr    // Contador inicializado em 0
    	mov x3, 1      // Primeiro número fibonacci
    	mov x4, 1      // Segundo número fibonacci

	ldr x1, =msg   // Mensagem 1
        ldr x2, =mlen  // Comprimento mensagem 1
        bl _print      // Pula para a função _print

	mov x0 , x7    // Prepara a impressão do tamanho da sequência
        bl _printUInt  // Imprime o tamanho da sequência

	ldr x1, =msg2  // Mensagem 2
        ldr x2, =m2len // Comprimento mensagem 2
        bl _print      // Pula para a função _print

	b _fib         // Pula para a função _fib

_fib:
    	// Imprime o número da vez
	mov x0, x3     // Move x3 para x0 (x3 contém o próximo número da sequência)
	bl _printUInt  // Pula para a função _printUInt

	ldr x1, =space // Espaço entre números
        ldr x2, =slen  // Comprimento do espaço
        bl _print      // Pula para a função _print

   	// Calcula o próximo número da sequência fibonacci
    	add x5, x3, x4 // x5 = x3 + x4
    	mov x3, x4     // x3 = x4
    	mov x4, x5     // x4 = x5

    	// Incrementa o contador
    	add x6, x6, 1  // x6 = x6 + 1

    	// Verifica se todos os números foram impressos
    	cmp x6, x7     // x6 < x7?
    	blt _fib       // Retorna para a função _fib em caso positivo

	b _jump        // Inicia finalização do programa

// --------- Trecho de código baseado no tutorial de CallousCoder ---------
// https://youtu.be/qHDGg0i-j7k?si=fIUtt4saVmnjmfey
_printUInt:
	// Função para impressão de inteiros
	// push
	stp x29, x30, [sp, #-16]!
        stp x5, x7, [sp, #-16]!
	stp x2, x3, [sp, #-16]!
        stp x0, x1, [sp, #-16]!

	mov x7, 10
	mov x5, #0
	sub sp, sp, 128

	cmp x0, #0
	beq _printUInt_Zero

_printUInt_Count:
	udiv x2, x0, x7
	msub x3, x2, x7, x0
	add x5, x5, #1
	strb w3, [sp, x5]
	mov x0, x2
	cmp x0, #0
	bne _printUInt_Count
	b _printUInt_print

_printUInt_Zero:
	add x5, x5, #1
	strb w0, [sp, x5]

_printUInt_print:
	ldrb w3, [sp, x5]
	add w3, w3, 48
	ldr x1, =num
	strb w3, [x1]
	mov x2, #1
	bl _print
	subs x5, x5, #1
	bne _printUInt_print

	// pop
	add sp, sp, #128
	ldp x0, x1, [sp], #16
	ldp x2, x3, [sp], #16
	ldp x5, x7, [sp], #16
	ldp x29, x30, [sp], #16
	ret

_print:
	// Função para impressão de strings
	// push
	stp x29, x30, [sp, #-16]!
        stp x2, x8, [sp, #-16]!
        stp x0, x1, [sp, #-16]!

        mov x0, 1
        mov x8, 64
        svc 0

	// pop
        ldp x0, x1, [sp], #16
        ldp x2, x8, [sp], #16
        ldp x29, x30, [sp], #16

	ret
// --------- Trecho de código baseado no tutorial de CallousCoder ---------

_error:
	// Função mensagem de erro
	ldr x1, =err
	ldr x2, =elen
	bl _print

	b _jump

_jump:
	// Função para pular linha
	ldr x1, =jump
        ldr x2, =jlen
        bl _print

	b _end

_end:
	// Encerrar programa
    	mov x8, 93     // Número de saída do sistema
    	mov x0, 0      // Status de saída
    	svc 0          // Chamada do sistema
