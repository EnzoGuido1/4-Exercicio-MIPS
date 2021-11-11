#-----------------------------------------------------------------------------------------------------------------------------
# ALUNO: ENZO GUIDO AMERICANO DA COSTA       MATRICULA: 202000560432
#-----------------------------------------------------------------------------------------------------------------------------

.data #cont�m as mensagens de texto que ser�o printadas no programa e os valores a serem utilizados no programa

msg1: .asciiz "Entre o valor inteiro positivo 'N' = "
msg2: .asciiz "\nO valor digitado precisa, necessariamente, ser maior que 0.\n\n"
msg3: .asciiz "\nO n�mero digitado � primo.\n"
msg4: .asciiz "\nO n�mero digitado n�o � primo.\n"
msg5: .asciiz "\nN�meros primos at� N: "
msg6: .asciiz "\nN primeiros n�meros primos: "
msg7: .asciiz ", "

.text #cont�m as fun��es que ser�o utilizadas no programa

main: #cont�m as fun��es que ser�o utilizadas no programa
	add $t0,$zero,$zero #zera o valor contido em $t0, $t0 ir� servir como resposta da fun��o de verificar se um n�mero � primo ou n�o (1 == primo, 0 == n�o primo)
	add $t1,$zero,$zero #zera o valor contido em $t1, $t1 ir� armazenar o valor N inserido no terminal
	add $t2,$zero,$zero #zera o valor contido em $t2, $t2 ir� armazenar o valor do n�mero a ser testado como primo
	add $t3,$zero,$zero #zera o valor contido em $t3, $t3 ir� servir como condicional para o aumento da vari�vel $s4

	add $t6,$zero,$zero #zera o valor contido em $t6, $t6 ir� servir para salvar endere�os e n�o perder refer�ncias nos loops
	add $t7,$zero,$zero #zera o valor contido em $t7, $t7 ir� servir para salvar endere�os e n�o perder refer�ncias nos loops
	add $t8,$zero,$zero #zera o valor contido em $t8, $t8 ir� servir para salvar endere�os e n�o perder refer�ncias nos loops
	add $t9,$zero,$zero #zera o valor contido em $t9, $t9 ir� servir para salvar endere�os e n�o perder refer�ncias nos loops

	add $a1,$zero,$zero #zera o valor contido em $a1, $a1 ir� quardar o valor do divisor de uma divis�o (4/5, $a1 = 5)
	add $a2,$zero,$zero #zera o valor contido em $a2, $a2 ir� quardar o valor de restos de divis�o
	add $a3,$zero,$zero #zera o valor contido em $a3, $a3 ir� servir como valor reserva e auxiliar de $t1 (N)

	add $s0,$zero,5 #armazena 5 no valor de s0, s0 ir� servir como determinante da parada de um loop para conferir se um n�mero � primo (check_prime)
	add $s1,$zero,$zero #armazena o valor de $s0 mais 2
	add $s2,$zero,$zero #armazena o valor de $s0 vezes ele mesmo
	add $s3,$zero,$zero #armazena o valor da subtra��o de $a3 menos $s2
	add $s4,$zero,$zero #zera o valor contido em $s4, $s4 ir� armazenar o contador para printrar os N primeiros primos
	add $s5,$zero,$zero #zera o valor contido em $s5, $s5 ir� servir como auxiliar para $a3 - $s4
	
	add $k0,$zero,$zero #zera o valor contido em $k0, $k0 ir� servir como verificador se N > 0
	
	j read #pula para a branch "read"
	
	read: #branch read, realiza a leitura de N que ser� inserido no terminal
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg1 #carrega o endere�o de msg1 em a0
		syscall #emite uma chamada do sistema
		li $v0,5 #c�digo syscall para ler inteiros, far� a leitura de N
		syscall #emite uma chamada do sistema
		
		add $t1,$v0,$zero #valor de $t1 recebe $v0 (N)
		j compare #pula para a branch "compare"
		
	compare: #compara se o valor contido em $t1 (N) � maior do que 0
		add $k0,$zero,$zero #zera o valor contido em $k0, $k0 ir� servir como condicional para caso N > 0
		sub $k0,$t1,$zero #k0 recebe o valor de t1 (N)
		blez $k0,error #caso o valor em $k0 seja menor ou igual a 0, pula para a branch "error"
		
		add $a3,$t1,$zero #$a3 recebe $t1 (N)
		jal compare_prime #pula para a branch "compare_prime" caso o valor N em $t1 seja v�lido e salva o endere�o para a volta da branch
		beq $t0,1,case_is_prime #caso o valor em $t0 alterado pela branch compare_prime seja 1 (� primo) vai para a branch case_is_prime
		beq $t0,$zero,case_isnt_prime #caso o valor em $t0 alterado pela branch compare_prime seja o (n�o � primo) vai para a branch case_isnt_prime
		
	error: #caso o valor N inserido em $t0 seja menor ou igual a zero
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg2 #carrega o endere�o de msg2 em a0
		syscall #emite uma chamada do sistema
		j read #pula para a branch "read", realiza outra leitura de N at� ser um valor v�lido
		
	compare_prime: #a branch compare_prime retorna em $t0: 1 caso o valor em $a3 (neste caso N inserido no terminal) seja primo ou 0 caso o valor em $a3 n�o seja primo
		beq $a3,0,isnt_prime #n�o � primo caso $a3 == 0
		beq $a3,1,isnt_prime #n�o � primo caso $a3 == 1
		beq $a3,2,is_prime #� primo caso $a3 == 2
		beq $a3,3,is_prime #� primo caso $a3 == 3
		
		add $a1,$zero,2 #$a1 recebe o valor do divisor 2
		div $a3,$a1 #realizo a divis�o de $a3 por 2
		mfhi $a2 #$a2 recebe o resto da divis�o de $a3 por 2
		beq $a2,0,isnt_prime #caso o resto da divis�o seja igual a zero, $a3 n�o � primo
		
		add $a1,$zero,3 #$a1 recebe o valor do divisor 3
		div $a3,$a1 #realizo a divis�o de $a3 por 3
		mfhi $a2 #$a2 recebe o resto da divis�o de $a3 por 3
		beq $a2,0,isnt_prime #caso o resto da divis�o seja igual a zero, $a3 n�o � primo
		
		add $s0,$zero,5 #$s0 vai funcionar como um contador inicializado em 5, esse contador vai servir tanto para ferificar a parada quanto para verificar se um n�mero � ou n�o � primo de acordo com o resto de suas divis�es, mais detalhes em https://en.wikipedia.org/wiki/Primality_test
		j check_prime #pula para a branch "check_prime"

		check_prime: #fun��o para verificar, de acordo com meu contador $s0 se o n�mero guardado em $a3 � ou n�o primo
			add $s2,$zero,$zero #$s2 recebe zero
			add $s3,$zero,$zero #$s3 recebe zero
			mul $s2,$s0,$s0 #$s2 recebe o valor de $s0 (5, 11, 17, 23, 29...) ao quadrado ($s0 * $s0)
			sub $s3,$a3,$s2 #$s3 recebe o valor de $a3 (n�mero a ser verificado se � primo) menos $s2 ($s0 * 2)
			bltz $s3,is_prime #caso $s3 seja menor que zero, retorna o n�mero como primo, terminando o loop
	
			div $a3,$s0 #hi recebe o resto da divis�o de $a3 por $s0
			mfhi $a2 #$a2 recebe o resto da divis�o de $a3 por $s0
			beq $a2,0,isnt_prime #caso o resto da divis�o resulte em 0, o n�mero n�o � primo
		
			add $s1,$zero,$zero #$s1 recebe zero
			add $s1,$s0,2 #vari�vel auxiliar $s1 recebe $s0 mais 2 (7, 13, 19, 25, 31...)
		
			div $a3,$s1 #hi recebe o resto da divis�o de $a3 por $s1
			mfhi $a2 #$a2 recebe o resto da divis�o de $a3 por $s1
			beq $a2,0,isnt_prime #caso o resto da divis�o resulte em 0, o n�mero n�o � primo
		
			add $s0,$s0,6 #$s0 cont�m o valor inicialmente de 5, essa fun��o ir� realizar um loop acrecentando seu valor em 6 a cada chamada
		
			j check_prime #retorna para o loop de verifica��o se � um primo at� $s0*$s0 ser maior que $s3
		
	print_is_prime: #imprime a mensagem 3 caso o n�mero inserido N ($t1) seja primo
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg3 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
		jr $ra #volta para a parte onde essa branch foi chamada
		
	print_isnt_prime: #imprime a mensagem 4 caso o n�mero inserido N ($t1) n�o seja primo
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg4 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
		jr $ra #volta para a parte onde essa branch foi chamada
		
	is_prime: #caso o valor em $a3 seja primo
		add $t0,$zero,1 #t0 recebe o valor 1
		jr $ra #volta para a parte onde essa branch foi chamada
	
	isnt_prime: #caso o valor em $a3 n�o seja primo
		add $t0,$zero,$zero #t0 recebe o valor 0	
		jr $ra #volta para a parte onde essa branch foi chamada
		
	case_is_prime: #caso o n�mero inserido N ($t1) seja primo
		jal print_is_prime #pula para a branch "print_is_prime" e salva o endere�o para a volta da branch
		
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg5 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
		add $s4,$zero,$zero #valor de $s4 recebe 0 (ir� servir como contador para o loop de busca de n�meros primos)
		add $a3,$zero,2 #valor de a3 come�a com 2 (primeiro n�mero primo)
		add $t3,$zero,1 #$t3 recebe o valor um ($t3 == 1 � o caso de achar os n�meros primos at� N), funciona como um verificador para incrementar o valor de s4
		jal loop_first_N_primes #pula para a branch "loop_first_N_primes" e salva o endere�o para a volta da branch
		
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg6 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
		add $s4,$zero,1 #valor de $s4 recebe 0 (ir� servir como contador para o loop de busca de n�meros primos)
		add $a3,$zero,2 #valor de a3 come�a com 2 (primeiro n�mero primo)
		add $t3,$zero,$zero #$t3 recebe o valor zero ($t3 == 0 � o caso de achar os N primeiros n�meros primos), funciona como um verificador para incrementar o valor de s4
		jal loop_first_N_primes #pula para a branch "loop_first_N_primes" e salva o endere�o para a volta da branch
		
		j exit #pula incondicionalmente para a branch exit
		
	case_isnt_prime: #caso o n�mero inserido N ($t1) n�o seja primo
		jal print_isnt_prime #pula para a branch "print_isnt_prime" e salva o endere�o para a volta da branch
		
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg6 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
		add $s4,$zero,1 #valor de $s4 recebe 0 (ir� servir como contador para o loop de busca de n�meros primos)
		add $a3,$zero,2 #valor de a3 come�a com 2 (primeiro n�mero primo)
		add $t3,$zero,$zero #$t3 recebe o valor zero ($t3 == 0 � o caso de achar os N primeiros n�meros primos), funciona como um verificador para incrementar o valor de s4
		jal loop_first_N_primes #pula para a branch "loop_first_N_primes" e salva o endere�o para a volta da branch
		
		j exit #pula incondicionalmente para a branch exit
		
	loop_first_N_primes: #branch que realiza o loop para achar os n�meros primos desejados
		la $t9,($ra) #carrega o endere�o de $ra (armazenado a cada jal) em $t9 (para n�o perder refer�ncia em futuros jal)
		
		j loop #pula incondicionalmente para a branch loop
		
		loop: #branch que realiza o loop para achar os n�meros primos desejados	
			sub $s5,$t1,$s4 #$s5 (funciona como vari�vel auxiliar para parada do loop) recebe $t1 (n�mero N inserido no terminal) menos $s4 (contador para parada do loop)
			bltz $s5,finish_loop #caso $s5 seja menor do que 0, encerra o loop pulando para a branch finish_loop
		
			jal compare_prime #pula para a branch "compare_prime" e salva o endere�o para a volta da branch
			jal print_msg7 #pula para a branch "print_msg7" e salva o endere�o para a volta da branch
			
			add $a1,$zero,2 #$a1 recebe o valor do divisor 2
			div $a3,$a1 #realizo a divis�o de $a3 por 2
			mfhi $a2 #$a2 recebe o resto da divis�o de $a3 por 2
			beq $a2,0,add_one #caso o n�mero inserido seja par, pula para a branch add_one (pois quero come�ar a comparar os n�meros impares, j� que n�o existem n�meros pares primos alem do n�mero 2)
			beq $a2,1,add_two #caso o n�mero inserido seja �mpar, pula para a branch add_two
			
			add_one: #branch que adiciona em $a3 (n�mero que quero verificar se � primo) uma unidade
				add $a3,$a3,1 #$a3 � adicionado em um
				jal add_$s4_a3 #pula para a branch "add_$s4_a3" e salva o endere�o para a volta da branch
				j loop #pula incondicionalmente para a branch loop
				
			add_two: #branch que adiciona em $a3 (n�mero que quero verificar se � primo) duas unidades
				add $a3,$a3,2 #$a3 � adicionado em dois
				jal add_$s4_a3 #pula para a branch "add_$s4_a3" e salva o endere�o para a volta da branch
				j loop #pula incondicionalmente para a branch loop
		
			finish_loop: #branch que retorna para o local da chamada da fun��o
				jr $t9 #volta para a parte onde essa branch foi chamada
		
	print_msg7: #branch que imprime a mensagem 7 e o primo desejado
		la $t8,($ra) #carrega o endere�o de $ra (armazenado a cada jal) em $t8 (para n�o perder refer�ncia em futuros jal)
		
		beq $t0,1,print #caso o valor salvo em $a3 seja primo pula para a branch print
		
		jr $t8 #volta para a parte onde essa branch foi chamada
		
		print: #imprime o primo desejado
			jal add_$s4_1 #pula para a branch "add_$s4_1" e salva o endere�o para a volta da branch
			
			li $v0,1 #c�digo syscall para imprimir inteiros
			add $a0,$a3,$zero #$a0 recebe o valor de $t2 (contador dos valores inteiros de 1 at� B) e imprime no terminal
			syscall #emite uma chamada do sistema
		
			li $v0,4 #c�digo syscall para imprimir strings
			la $a0,msg7 #carrega o endere�o de msg4 em a0
			syscall #emite uma chamada do sistema
			jr $t8 #volta para a parte onde essa branch foi chamada
		
	add_$s4_1: #branch que adiciona em uma unidade o contador $s4 na fun��o loop
		la $t7,($ra) #carrega o endere�o de $ra (armazenado a cada jal) em $t7 (para n�o perder refer�ncia em futuros jal)
	
		beq $t3,$zero,add_1 #caso de achar os n�meros primos at� N
		
		jr $t7 #volta para a parte onde essa branch foi chamada
		
		add_1: #branch para adicionar em $s4 uma unidade
			add $s4,$s4,1 #$s4 � adicionado em um
			jr $t7 #volta para a parte onde essa branch foi chamada
			
	
	add_$s4_a3: #branch que adiciona no o valor de $a3 o contador $s4 na fun��o loop
		la $t6,($ra)#carrega o endere�o de $ra (armazenado a cada jal) em $t6 (para n�o perder refer�ncia em futuros jal)
	
		beq $t3,1,add_a3 #caso de achar os N primeiros n�meros primos
		
		jr $t6 #volta para a parte onde essa branch foi chamada
			
		add_a3: #branch para adicionar em $s4 o valor de $a3 (n�mero a ser verificado como primo ou �o)
			add $s4,$a3,$zero #$s4 � adicionado no o valor de $a3
			jr $t6 #volta para a parte onde essa branch foi chamada
		
	exit: #branch que finaliza todo o programa
		li $v0,10 #c�digo syscall para encerrar o programa
		syscall #emite uma chamada do sistema
