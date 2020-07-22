--1
create or replace
procedure actualizapreco(ano varchar2, percentagem number) is
begin
  declare medias number;
          cursor c1 is select e from especialidades;
          ex varchar2(10);
          ult number;
          p number;
  begin
    fetch c1 into ex;
    
    while c1%found loop
    
      select avg(con.preco) into medias from consultas con, medicos med where med.m = con.m
                                                                        and med.e = ex
                                                                        and to_char(con.dh, 'yyyy') = ano;
      p := percentagem;                                                                  
      if(p > 1)
      then
        p := p/100;
      end if;
      
      if(medias is null) then select pr into medias from especialidades where e = ex; end if;
        
      ult := medias + (medias * percentagem);
      
      update especialidades set pr = ult where e = ex;
      commit;
      
      fetch c1 into ex;
    end loop;
    close c1;
  end;
end actualizapreco;  

--2
create or replace
function tem_consultas(medico varchar2)
return number is encontra number;
begin
  
  select m into encontra from consultas where m = medico;
  
  if(encontra is null)
  then
    delete from medicos where medico = m;
  end if;
  
end;

--3
create or replace function cp_usado(cp varchar2) 
return number is removido number; notpac number; notmed number;
begin
  
  select count(*) into notpac from pacientes where pacientes.cp = cp;
  select count(*) into notmed from medicos where medicos.cp = cp;
  
  if(notmed is null AND notpac is null)
  then
    delete from cod_postal where cod_postal.cp = cp;
    removido := 1;
  else 
    removido := 0;
  end if;
end;

--4
alter table MEDICOS add (facturacao number(10,2));

create or replace
trigger acumula
after insert on consultas referencing new as newrow for each row
declare n number;
begin
  
  select facturacao into n from medicos where medicos.m = :newrow.m;
  
  if(n is null)
  then 
    update medicos set facturacao = :newrow.preco where medicos.m = :newrow.m;
  else
    update medicos set facturacao = facturacao + :newrow.preco where medicos.m = :newrow.m;  
  end if;
end acumula;
--5
