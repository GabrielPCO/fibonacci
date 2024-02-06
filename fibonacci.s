// Fibonacci em assembly A64
// O programa a seguir converte frases (escolhidas pelo usuário) para a sequência fibonacci
// Cada palavra da frase é convertida no próximo número da sequência

.global _start // Inicialização

.section .data // Sessão de dados (declarando variáveis)
    	num: .byte 0 // Declaração de variável numérica

	msg: .ascii "Sequencia Fibonacci (" // Texto mensagem 1
	mlen = . - msg // Comprimento do texto

	msg2: .ascii " dígitos): " // Texto mensagem 2
	m2len = . - msg2 // Comprimento do texto

	space: .ascii " "// Texto 'espaço'
	slen = . - space // Comprimento do texto

	jump: .ascii "\n"// Texto 'pular linha'
	jlen = . - jump // Comprimento do texto

	err: .ascii "Erro: Parâmetro não encontrado. Digite o tamanho da sequência desejada no commando: ex. './fibonacci 6'" // Texto mensagem 3
	elen = . - err // Comprimento do texto

.section .text // Sessão de texto
_start:
    	// Função inicial
	ldr x0, [sp] // Carrega o argumento 'argc' (que é o número de argumentos encontrados na linha de comando) para x0

	// Validação do comando
	cmp x0, 2    // Compara x0 com o número 2 para verificar se ao menos um argumento foi passado para o comando ./fibonacci
	bge _main    // Pula para main em caso positivo

	b _error     // pula para a finalização do programa com menssagem de erro (caso o comando não tenha nenhum argumento)

_main:
	// Função principal
	// Subitrai 1 de x0 para armazenar o valor correto de argumentos (palavras da frase) da função e armazena em x0
	sub x0, x0, 1

	// Inicialização dos registradores
    	mov x7, x0     // Tamanho da sequência
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
	mov x0, x3
	bl _printUInt

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
