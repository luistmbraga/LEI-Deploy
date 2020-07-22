#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

//Ficha 3
//Paulo Araújo

//Definição de tipos

//1******************************

typedef struct metodoA{

	int mini[6];
	int exame,teste;
}META;

typedef struct metodoB{

	int exame,teste;	
}METB;

typedef union{
    META mA;
    METB mB;
}AVAL;


typedef struct Aluno{

	char *nome;
	int numero;
	char metodo;
	AVAL nota;
}Aluno;

typedef struct Turma *t;

typedef struct Turma{

	int size;
	Aluno alu[100];
}Turma;
	


//2******************************

int acrescentaAluno(t turma, Aluno a){

	if(turma->size>100) return -1;

	turma->alu[turma->size]=a;
	turma->size++;

	return 0;
}
	
void imprimeturma(t turma){

	int i;
	for(i=0;turma->alu[i].nome!=NULL;i++){
	printf("%s %d\n",turma->alu[i].nome,turma->alu[i].numero);
					}
}					

//3******************************

int procura(t turma, int numero){

	int i;
	for(i=0;i<turma->size;i++){
				if(turma->alu[i].numero==numero) {
								printf("%d\n",i);
								return i;}
				}
	return -1;

}

//4******************************

float nota_final(Aluno a){

	float res=0.0;
	int min=a.nota.mA.mini[0],i;
	if(a.metodo=='A'){
			for(i=0;i<6;i++){
					res+=(float)a.nota.mA.mini[i];
					if(a.nota.mA.mini[i]<min) min=a.nota.mA.mini[i];
					}
			res-=(float)(min);
			res=(res/5)*0.4+((float)a.nota.mA.teste*0.6)/5;
									}else{
										if(a.metodo=='B') res=(float)a.nota.mB.teste;}
	return res;
}


//5******************************

int quantospassaram(t turma){

	int i,res=0;
	for(i=0;i<turma->size;i++){
				if(nota_final(turma->alu[i])>10) res++;
				}

	return res;
}

//Listas Ligadas

typedef struct slist *LInt;
	
typedef struct slist{

	int valor;
	LInt prox;
}Nodo;


typedef struct difl{
	LInt inicio, fim;
}Diflist;


//1******************************


LInt upto(int n){

	LInt l,aux;
	l=NULL;
	while(n>0){
			aux=l;
			l=(LInt)malloc(sizeof(Nodo));
			l->valor=n;
			l->prox=aux;
			n--;
	}
	return l;
}



//2-a******************************
int length(LInt l){

	int i;
	while(l){
		l=l->prox;
		i++;
		}
	
	printf("tam:%d\n",i);
	return i;
}

//2-b******************************
LInt clone3(LInt l) {

	if (l == NULL) return NULL;

	LInt nova = (LInt)malloc(sizeof(Nodo));
	nova->valor = l->valor;
	nova->prox = clone3(l->prox);

	return nova;
}
	
LInt clone(LInt l){

	LInt nova=NULL;
	LInt aux2=NULL;

	while(l){

        LInt elem = (LInt)malloc (sizeof(Nodo));

        elem->valor = l->valor;
	elem->prox = NULL;
	if (nova == NULL) {
			nova = elem;
			aux2 = elem;
          }
          	else {
			aux2->prox = elem;
			aux2 = elem;
          }

	l = l->prox;
	}

    return nova;
}

//2-c******************************
void destroi(LInt l){

	LInt aux;
	while(l){
		aux=l->prox;
		free(l);
		l=aux;
		}

}


//2-d******************************

void imprime(LInt l){

	if(l){
	while(l){
		printf("%d\t",l->valor);
		l=(l->prox);
	}}else{
		printf("lista vazia\n");}
		printf("\n");
}


//2-e******************************
void snoc(LInt *l,int e);


void inverte(LInt *l){

	LInt tail;
	if(*l){
		tail=(*l)->prox;
		inverte(&tail);
		snoc(&tail,(*l)->valor);
		free(*l),
		*l=tail;
		}
}

void inverte2(LInt *l){

	LInt aux=NULL;
	LInt xyz;
	while(*l){
		xyz=(*l)->prox;
		(*l)->prox=aux;
		aux=*l;
		*l=xyz;
		}
	*l=aux;
}

//2-f******************************

void insere(LInt *l,int e){
	
	LInt anterior = NULL;
	LInt atual = *l;
	LInt novo = (LInt)malloc(sizeof(Nodo));
	novo->valor=e;
	while(atual && atual->valor<e){
					anterior=atual;
					atual=atual->prox;
					}
	novo->prox=atual;
	if(anterior){
			anterior->prox=novo;}else{
						*l=novo;
						}
}


//2-g******************************

void remove2(LInt *l,int e){

	LInt anterior=NULL,atual;

	for(atual=*l; atual!=NULL;anterior=atual,atual=atual->prox){
		if(atual->valor==e){
			if(anterior==NULL){
				*l=atual->prox;
				} else {
					anterior->prox = atual->prox;
					}
			free(atual);

			return;
				}
	}
}

//3******************************

LInt merge(LInt a,LInt b){

	LInt head, last;
	if(a==NULL) return b;
	if(b==NULL) return a;
	if(a->valor < b->valor){
		head=last=a;
		a=a->prox;
	} else {
		head=last=b;
		b=b->prox;
	}
	while(a && b){
		if(a->valor < b->valor){
			last->prox=a;
			a=a->prox;
			last=last->prox;
		} else {
			last->prox=b;
			b=b->prox;
			last=last->prox;
		}
	}
	if(a==NULL) last->prox=b;
	if(b==NULL) last->prox=a;
	
	return head;
}

//4******************************

LInt split(LInt l){

	int tam=0,metade;
	LInt aux=l, parte2=NULL,anterior=NULL;
	while(aux){
		tam++;
		aux=aux->prox;
	}
	metade=tam/2;
	while(metade>0){
		anterior=l;
		l=l->prox;
		metade--;
	}
	anterior->prox=NULL;
	parte2=l;
	
	return parte2;
}

LInt mergeSort1(LInt l){
	LInt x;
	if((l==NULL) || (l->prox)==NULL) return l;
	else {
		x=split(l);
		x=mergeSort1(x);
		l=mergeSort1(l);
		l=merge(l,x);
	}
}


//5-a******************************

void removet(LInt *l,int e){

	LInt anterior=NULL,atual,libertar=NULL;
	atual=*l;
	while(atual){
		if(atual->valor==e){
				libertar=atual;
			if(anterior==NULL){
				*l=atual->prox;
			} else {
				anterior->prox = atual->prox;
				atual=atual->prox;
				}
			free(libertar);
		} else {
			anterior=atual;
			atual=atual->prox;
			}
	}
}

//5-b******************************

void remove_dups(LInt *l){
   
	LInt atual = *l;
   	LInt seg, ant;

   	while(atual){
		seg = atual->prox;
     	 	ant = atual;

      	while(seg){
         	if(seg->valor == atual->valor){
            		ant->prox = seg->prox;
            		free(seg);
            		seg = ant->prox;
         	} else {
            		ant = seg;
            		seg = seg->prox;
         		}
      		}
      	atual = atual->prox;
   		}
}

//5-c******************************

void removeMaior(LInt *l){

	LInt atual=*l, maior=NULL, anterior=NULL;	
	if(atual->prox){
		maior=atual;
		anterior=atual;
		atual=atual->prox;
	while(atual){
		if(maior->valor <= atual->valor){
			maior=atual;
			anterior=atual->prox;
			}
		}
	}
}


//6-a******************************

void init(LInt *l){
	
	LInt atual=*l,anterior=NULL;
	if(atual && atual->prox){
	while(atual->prox){
			anterior=atual;
			atual=atual->prox;
				}
	free(atual);
	anterior->prox=NULL;
	} else {
		return;
		}
}


//6-b******************************

void snoc(LInt *l,int e){

	LInt last=(LInt)malloc(sizeof(Nodo));
	LInt aux;
	last->valor=e;
	last->prox=NULL;
	aux=*l;
	while(aux && aux->prox){
				aux=aux->prox;
				}
	if(aux) aux->prox=last; else *l=last;
}



void cons(LInt *l,int e){
	
	LInt head=(LInt)malloc(sizeof(Nodo));
	head->valor=e;
	head->prox=*l;
	*l=head;
}


//6-c******************************

void concat(LInt *a, LInt b){

	LInt atual=*a,nova;
	if(b && atual){
		while(atual->prox){
			atual=atual->prox;
			}
		while(b){
			nova=(LInt)malloc(sizeof(Nodo));
			nova->valor=b->valor;
			nova->prox=NULL;
			atual->prox=nova;
			atual=atual->prox;
			b=b->prox;
			}
		}
}


//Outra struct(DifList)

void imprime2(Diflist l){
	while(l.inicio){
		printf("%d\n",(l.inicio)->valor);
		l.inicio=(l.inicio)->prox;
	}
}

void destroi2(Diflist l){

	while(l.inicio){
		l.fim=l.inicio;
		l.inicio=(l.inicio)->prox;
		free(l.fim);
	}
}


//7******************************
void snoc2(Diflist *l, int x){

	LInt new=malloc(sizeof(Nodo));
	new->valor=x;
	new->prox=NULL;
	if(l->inicio){
		l->fim->prox=new;
		l->fim=new;
	} else {
		l->inicio=new;
		l->fim=new;
	}
}

//8******************************
void concat2(Diflist *a,Diflist b){
	
	if(a->inicio){
		a->fim->prox=b.inicio;
	} else {
		a->inicio=b.inicio;
	}
	if(b.inicio){
		a->fim=b.inicio;	
	}
}



Diflist clone2(Diflist l){

	Diflist new={NULL,NULL};
	LInt nodo;
	while(l.inicio){
		nodo=(LInt)malloc(sizeof(Nodo));
		nodo->valor=(l.inicio)->valor;
		nodo->prox=NULL;
		if(new.inicio){
			(new.fim)->prox=nodo;
		} else {
			new.inicio=nodo;
		}
		new.fim=nodo;
		l.inicio=(l.inicio)->prox;
	}

	return new;
}	



//Outro tipo de struct(*DList)

typedef struct node *DList;

typedef struct node {
	int value;
	DList prev, next;
} Node;

//12******************************

void addInt (DList *l, int x){

	DList aux=(*l),nova,anterior;
	nova=(DList)malloc(sizeof(Node));
	nova->value=x;
	if((*l)==NULL){
		(*l)=nova;
		nova->prev=NULL;
		nova->next=NULL;
	} else {
		while(aux && aux->value < x ){
			anterior=aux;
			aux=aux->next;
			}
		anterior->next=nova;
		nova->prev=anterior;
		nova->next=aux;
		if(aux) aux->prev=nova;
	}
}



//13******************************

DList lookLeft(DList l, int x){

	if(l->value == x) return l;
	while(l){
			if(l->value==x) return l;
			else l=l->prev;
	}
	return NULL;
}

DList lookRight(DList l, int x){

	if(l->value == x) return l;
	while(l){
			if(l->value==x) return l;
			else l=l->next;
	}
	return NULL;
}



DList exists(DList l, int x){

	DList left=lookLeft(l,x), right=lookRight(l,x);
	if(left) return left;
	else return right;
}

		
//14******************************

void removedl(DList *l,int x){

	DList aux=(*l),ant=NULL; 
	while(aux){
		if(aux->value==x) break;
		else aux=aux->next;
	}
	if(aux==NULL) return;
	if(aux->prev != NULL) aux->prev->next=aux->next; else (*l)=aux->next;
	if(aux->next != NULL) aux->next->prev=aux->prev; else aux->prev->next=NULL;
	free(aux);
}


void printuma(DList l){

	if(l) printf("%d\n",l->value);
}

//15******************************

DList rewind1(DList l){

	if(l){
		while(l->prev) l=l->prev;
	}

	return l;
}

//16******************************


DList foward(DList l){

	if(l){
		while(l->next) l=l->next;
	}

	return l;
}


void imprime3(DList l){

	while(l){
		printf("%d\n",l->value);
		l=l->next;
	}
}



void destroi3(DList l){

	DList anterior;
	while(l){
		anterior=l;
		l=l->next;
		free(anterior);
	}
}


//Arvores Binárias


typedef struct nodo *ABin;

struct nodo{
		int valor;
		ABin esq,dir;
}Nodot;

//1-a******************************
int altura(ABin t){

	int e,d;
	if(!t) return 0;
	else{
		e=altura(t->esq);
		d=altura(t->dir);

		if(e>d) return e+1;
		else return d+1;
	}
}	

ABin arvCopia(ABin t){

	ABin p=NULL;
	if(!t) return NULL;
	else{
		p=(ABin)malloc(sizeof(ABin));
		p->valor=t->valor;
		p->esq=arvCopia(t->esq);
		p->dir=arvCopia(t->dir);
		return p;
	}
}


void invertetree(ABin t){

	ABin p;
	if(t){
		p=t->esq;
		t->esq=t->dir;
		t->dir=p;
		invertetree(t->esq);
		invertetree(t->dir);
	}
}

LInt preorderAcc(ABin a, LInt l){

	LInt r,p;
	if(!a) r=l;
	else{
		p=preorderAcc(a->dir,l);
		r=(LInt)malloc(sizeof(LInt));
		r->valor=a->valor;
		r->prox=preorderAcc(a->esq,p);
	}

	return r;
}

LInt preorder(ABin a){

	return(preorderAcc(a,NULL));
}

LInt postorderAcc(ABin a, LInt l){

	LInt r;
	if(!a) r=l;
	else{
		r=(LInt)malloc(sizeof(LInt));
		r->valor=a->valor;
		r->prox=l;
		r=postorderAcc(a->dir,r);
		r=postorderAcc(a->esq,r);
	}

	return r;
}

LInt postorder(ABin a){

	return(postorderAcc(a,NULL));
}



LInt inorderAcc (ABin a, LInt l) {
	
	LInt r;
	if (a == NULL) r = l;
	else { 
		r = (LInt) malloc (sizeof(struct slist));
		r->valor = a->valor;
		r->prox = inorderAcc (a->dir, l);
		r = inorderAcc (a->esq, r);
	}

	return r;
}

LInt inorder (ABin a) {

	return (inorderAcc (a, NULL));
}

int maior(ABin t){

	ABin r;
	r=t;
	while(r){
		r=r->dir;
	}
	return r->valor;
}

void destroitree(ABin t){


	if(t){
   		destroitree(t->esq);
   		destroitree(t->dir);
  		free(t);
  	}
}


ABin insereREC(ABin t, int x){

	ABin p;
	if(!t){
		p=(ABin)malloc(sizeof(ABin));
		p->valor=x;
		p->esq=p->dir=NULL;
		return p;
	}
	else if(x<t->valor) t->esq=insereREC(t->esq,x);
	else if(x>t->valor) t->dir=insereREC(t->dir,x);

	return t;
}

void insereREC2(ABin *t, int x){

	ABin p=NULL;

	if(!(*t)){
		p=(ABin)malloc(sizeof(ABin));
		p->valor=x;
		p->esq=p->dir=NULL;
		(*t)=p;
		return;
	}
	else if(x<(*t)->valor) insereREC2(&(*t)->esq,x);
	else if(x>(*t)->valor) insereREC2(&(*t)->dir,x);

	return;
}

void insereIT(ABin *t, int x){

	ABin aux=(*t),anterior,novo;
	novo=(ABin)malloc(sizeof(ABin));
	novo->valor=x;
	novo->dir=novo->esq=NULL;

	if(!(*t)){
		*t=novo;
		return;
	}
	
	while(aux){
		anterior=aux;
		if(x > aux->valor) aux=aux->dir;
		else aux=aux->esq;
	}
		if(anterior->valor > novo->valor) anterior->esq=novo;
		else anterior->dir=novo;
}

void printtree(ABin l){

	if(l->esq) printtree(l->esq);
	printf("%d\n",l->valor);
	if(l->dir) printtree(l->dir);
}

void inseretree(ABin *l,ABin nt){

	if(!(*l)){
		*l=nt;
		return;
	}
	if(nt->valor < (*l)->valor)
		inseretree(&(*l)->esq,nt);
	else if(nt->valor>(*l)->valor)
		inseretree(&(*l)->dir,nt);
}


ABin minimo(ABin t){
    if(t){   
    	while((t->esq)){   
          	t = t->esq;   
       	}   
	}   
    return t;
}
 

void remover(ABin *raiz, int x){   
    
    ABin aux;

    if(*raiz){   
    	if(x < (*raiz)->valor){    
           	remover(&((*raiz)->esq), x);
        }else{
        	if(x > (*raiz)->valor){    
           		remover(&((*raiz)->dir), x);
            }else{ 
               	if((*raiz)->esq && (*raiz)->dir){    
               		aux = minimo((*raiz)->dir);    
                    (*raiz)->valor = (aux->valor);   
                    remover(&(*raiz)->dir, (*raiz)->valor);   
                }else{    
                   	aux = (*raiz);    
                    if(!(*raiz)->esq){    
                    	*raiz = (*raiz)->dir;   
                    } else {   
                      	*raiz = (*raiz)->esq;                          
                    }   
                free(aux);   
                }   
            }        
       }    
    }     
}  

typedef struct fmap *Fmap;

typedef struct fmap {
	char *key;
	void *info;
	Fmap left, right;
} Nodef;

void addPair(Fmap *f, char *k, void *i){

	if(!(*f)){
		Fmap novo=(Fmap)malloc(sizeof(Nodef));
		novo->key=k;
		novo->info=i;
		novo->left=novo->right=NULL;
		(*f)=novo;
		return;
	}

	if(strcmp((*f)->key,k)>0){
		addPair(&(*f)->left,k,i);
	} else{
		if(strcmp((*f)->key,k)<0){
			addPair(&(*f)->right,k,i);
		} else return;
	}
}	


int comp(char *s){

	int i=(int)strlen(s);
	return i;
}


void mostrafmap(Fmap f){

	if(f){
		printf("%s\n",f->key);
		mostrafmap(f->left);
		mostrafmap(f->right);
	}
}

int main(){

	Fmap teste=NULL;
	addPair(&teste,"Paulo",comp);
	addPair(&teste,"Pedro",comp);
	addPair(&teste,"Silvia",comp);
	addPair(&teste,"Rosa",comp);

	mostrafmap(teste);

	return 0;

}
















