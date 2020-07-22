#define MAXALUNO 100

typedef struct sAluno
{
	char *nome;
	int idade;
	int prox;
} Aluno;

typedef struct sListAluno
{
	int cabeca;
	int livre;
	Aluno lista[MAXALUNO];
} ListAluno;

// A função de inicialização que deverá inicializar uma estrutura do tipo ListAluno:
ListAluno initLista(ListAluno l);

// A função de procura que dada uma lista e um nome dá como resultado o índice onde esse aluno se encontra na lista (devolve -1 se o aluno não pertencer à lista):
int procuraAluno(ListAluno l, char* nome);

// A função de consulta que dada uma lista e um índice, escreve no monitor a informação relativa ao aluno armazenado nesse índice:
void consultAluno(ListAluno l, int indice);

// A função de inserção que recebe uma lista e um aluno e coloca o aluno na lista actualizando o índice (campo próximo) e devolvendo uma nova lista alterada:
ListAluno insereAluno(ListAluno l, Aluno a);

// A função de listagem que recebendo uma lista produz uma listagem ordenada alfabeticamente por nome dos alunos presentes na lista:
void listAluno(ListAluno l);

// A função de remoção que dada uma lista e um nome remove o respectivo aluno da lista devolvendo a lista alterada:
ListAluno removeAluno(ListAluno l, char *nome);