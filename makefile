all: fibonacci fibonacci.o
	@echo "Instalação concluída com sucesso!"

fibonacci.o: fibonacci
	@echo "- Compilando binários"
	ld fibonacci.o -o fibonacci
	@echo "Finalizando a instalação..."

fibonacci:
	@echo "Instalando app Fibonacci..."
	@echo "- Criando arquivo objeto"
	as fibonacci.s -o fibonacci.o

clean:
	@echo "Realizando limpeza de arquivos..."
	rm -f *.o
	@echo "Limpeza concluída com sucesso!"
