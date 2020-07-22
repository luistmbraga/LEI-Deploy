// Teste 2 (2016/2017) Nota: 18.0 (ou seja, algumas funções vão estar incorretas)

// Resolução da parte B (com algumas alterações em relação à do teste)

// 1
int push(StackC *s, int x)
{
    CList novo;
    if (s->sp == MAXc) {
        if ((novo = (CList)malloc(sizeof(struct chunck))) == NULL)
            return 1;
        novo->vs[0] = x;
        novo->prox = s->valores;
        s->valores = novo;
        s->sp = 1;
    } else {
        s->valores->vs[(s->sp)++] = x;
    }
    return 0;
}

// 2
int pop(StackC *s, int *x)
{
    CList aux;
    if (s->valores == NULL) return 1;
    *x = s->valores->vs[--(s->sp)];
    if (s->sp == 0) {
        s->sp = MAXc;
        aux = s->valores;
        s->valores = s->valores->prox;
        free(aux);
    }
    return 0;
}

// 3
int size(Stack s) {
    int r;
    if (s->valores == NULL)
        r = 0;
    else
        r = s.sp + MAXc * (length(s.valores) - 1);
    return r;
}

// 4
void reverse(Stack *s)
{
    int i;
    int len = size(*s);
    int v[len];
    for (i = 0; i < len; i++)
        pop(s, v + i);
    for (i = 0; i < len; i++)
        push(s, v + i);
}

// 5

// Função que indica o endereço na stack do elemento na posição n.
int *find(StackC *s, int n)
{
    int sp = s->sp;
    Clist l = s->valores;
    if (l == NULL)
        return NULL;
    while (n > sp) {
        n -= sp;
        l = l->prox;
        sp = MAXc;
    }
    return (l->vs) + n;
}

void reverse(StackC *s)
{
    int i, tmp, *init, *end;
    int len = size(*s);
    for (i = 0; i < (len / 2); i++) {
        init = find(s, i);
        end = find(s, len - i - 1);
        tmp = *init;
        *init = *end;
        *end = tmp;
    }
}
