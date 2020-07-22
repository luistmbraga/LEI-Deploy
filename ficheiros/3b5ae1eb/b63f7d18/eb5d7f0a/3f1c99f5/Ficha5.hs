-- 1)

--a)
id * id = id
<=> Def - x
id.pi1 split id.pi2 = id
<=> Def - id
pi1 split pi2 = id
<=> Reflexao - x
id = id

f * g = f.pi1 split g.pi2

--b)
pi1.(f * g) = f.pi1
<=> Def - cancel - x
f = f.pi1
<=> Def - x
f = f 

--d)
(f * g).(h split j) = f.h split g.j
<=> Def - x
(f.pi1 split g.pi2).(h split j)


<=> absor - x
f.h split g.j = f.h split g.j
-- tem que se provar a propria lei. nao pode ser assim

--e)
(f * g).(h * j) = f.h * g.j
<=>absor-*
f.h*g.

--f)
swap.(f*g) = (g * f).swap

-- 2)

--a)
id + id = id
<=> Def - +
i1.id ▽ i2.id
<=> Def - id
i1 ▽ i2
<=> Reflex - +
id

--b)
(f + g).i1 = i1.f
<=> Def - +
(i1.f ▽ i2.g).i1
<=> Cancel - +
i1.f

--d)
(f ▽ g).(h + j) = f.h ▽ g.j
<=> Def - +
(f ▽ g).(i1.h ▽ i2.j)
<=> Fusion - +
(f ▽ g).i1.h ▽ (f ▽ g).i2.j
<=> Cancel - +
f.h ▽ g.j

--e)
(f + g).(h + j) = f.h + g.j
<=> Def - +, Def - +
(i1.f ▽ i2.g).(i1.h ▽ i2.j) = i1.(f.h) ▽ i2.(g.j)

--f)
coswap.(f + g) = (g + f).coswap
<=> Def - coswap
(i2 ▽ i1).(f + g) = (g + f).(i2 ▽ i1)
<=> Absor - +, Fusion - +
i2.f ▽ i1.g = (g + f).i2 ▽ (g + f).i1
<=> Def - +
i2.f ▽ i1.g = (i1.g ▽ i2.f).i2 ▽ (i1.g ▽ i2.f).i1
<=> Cancel - +
i2.f ▽ i1.g = i2.f ▽ i1.g

-- 3)
a * (b * c) ∼= (a * b) * c
--a)
assocl :: a * (b * c) -> (a * b) * c

assocr :: (a * b) * c -> a * (b * c)

--b)
assocr.assocl = id
<=> Def - assocr 
((pi1.pi1) △ (pi2 * id)).assocl
<=>Fusion - *
pi1.pi1.assocl △ (pi2 * id).assocl

===>>> pi1.pi1.assocl
<=>
pi1.pi1.((id * pi1) △ pi2.pi2)
<=>
pi1.(id * pi1)
<=>
p1.(pi1 △ pi1.pi1)
<=>
pi1

===>>>(pi2 * id).assocl
<=> Def - assocl
(pi2.id)((id * pi1) △ (pi2.pi2))
<=> Absor - *
(pi2.(id * pi1)) △ (pi2.pi2)
<=> Def - *
pi2.(pi1 △ pi1.pi2) △ pi2.pi2
<=> Cancel - *
pi1.pi2 △ pi2.pi2
<=> Fusion - * 
(pi1 △ pi2).pi2
<=> Reflex - *
pi2






--c)
