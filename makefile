all: fibonacci
	@echo "Instalação concluída com sucesso!"

fibonacci: fibonacci.o
	@echo "- Compilando binários"
	ld fibonacci.o -o fibonacci
	@echo "Finalizando a instalação..."

fibonacci.o: fibonacci.s
	@echo "Instalando app Fibonacci..."
	@echo "- Criando arquivo objeto"
	as fibonacci.s -o fibonacci.o

clean:
	@echo "Realizando limpeza de arquivos..."
	rm -f *.o
	@echo "Limpeza concluída com sucesso!"
