%% Resolver problema navide?o Inteligencia Inglesa
%%%Lucas Martin Gago
%% Meto los datos
tic
h = waitbar(0,'Generando todas las posibilidades...');
clear all
defmat=Init();
ch=0;
filas=datafilas();
columnas=datacolumnas();
%% Binarizo posibles filas y columnas
for i=1:25
    l=length(filas{i});
    s=sum(filas{i});
    posi=extract(l+1,25-s);
    comb{i}=posi;
    resu{i}=binarizar(filas{i},comb{i});
    ch=ch+1;
    waitbar(ch / 50)
end

for i=1:25
    l=length(columnas{i});
    s=sum(columnas{i});
    posi=extract(l+1,25-s);
    combi{i}=posi;
    resuc{i}=binarizar(columnas{i},combi{i});
    ch=ch+1;
    waitbar(ch / 50)
end
clc
disp ('Posibilidades restantes: ')
disp (contar(resu)+contar(resuc))
figure(1)
imshow(defmat,'InitialMagnification','fit')
count=0;
completo=zeros(25,25);
F = findall(0,'type','figure','tag','TMWWaitbar');
delete(F);
%% Empiezo a iterar en filas
count=0;
for ze=1:10
    %Dibujar columnas completas
    for i=1:25
        if (  any(completo(:,i)==0))
            x=resuc{i};
            
            if length(x)==1 && ~cellfun(@isempty,x)
                disp ('Otro listo')
                defmat(:,i)=x{1};
                figure (3)
                imshow(defmat,'InitialMagnification','fit')
                completo(:,i)=1;
                clc
                disp ('Posibilidades restantes: ')
                disp (contar(resu)+contar(resuc))
            end
        end
    end
    
    % Dibujar filas completas
    for i=1:25
        if (  any(completo(i,:)==0))
            x=resu{i};
            if length(x)==1 && ~cellfun(@isempty,x)
                disp ('Otro listo')
                defmat(i,:)=x{1};
                figure (3)
                imshow(defmat,'InitialMagnification','fit')
                completo(i,:)=1;
                
            end
        end
    end
    
    % Casillas que se repiten en posibilidades filas a 0
    
    for i=1:25
        if any(completo(i,:)==0)
            x=resu{i};
            if length(x)>1
                for j=1:25
                    compra=x{1,1};
                    compr=compra(j);
                    for k=1:length(x)
                        y=x{1,k};
                        if y(j)==compr
                            ig=1;
                            continue
                        else
                            ig=0;
                            break
                        end
                    end
                    if ig && compr==0
                        defmat(i,j)=0;
                        figure (3)
                        imshow(defmat,'InitialMagnification','fit')
                        ig=0;
                        
                    end
                end
            end
        end
    end
    
    
    % Casillas que se repiten en posibilidades columna a 0
    
    for i=1:25
        if   any(completo(:,i)==0)
            x=resuc{i};
            if length(x)>1
                for j=1:25
                    compra=x{1,1};
                    compr=compra(j);
                    
                    for k=1:length(x)
                        y=x{1,k};
                        
                        if y(j)==compr
                            ig=1;
                            continue
                        else
                            ig=0;
                            break
                        end
                    end
                    if ig && compr==0
                        defmat(j,i)=0;
                        
                        figure (3)
                        imshow(defmat,'InitialMagnification','fit')
                        ig=0;
                    end
                end
            end
        end
    end
    
    
    % Casillas que se repiten en posibilidades filas a 1
    
    for i=1:25
        if   any(completo(i,:)==0)
            x=resu{i};
            if length(x)>1
                for j=1:25
                    compra=x{1,1};
                    compr=compra(j);
                    for k=1:length(x)
                        y=x{1,k};
                        if y(j)==compr
                            ig=1;
                            continue
                        else
                            ig=0;
                            break
                        end
                    end
                    if ig && compr==1
                        defmat(i,j)=1;
                        figure (3)
                        imshow(defmat,'InitialMagnification','fit')
                        ig=0;
                        
                    end
                end
            end
        end
    end
    
    
    % Casillas que se repiten en posibilidades columna a 1
    
    for i=1:25
        if   any(completo(:,i)==0)
            x=resuc{i};
            if length(x)>1
                for j=1:25
                    compra=x{1,1};
                    compr=compra(j);
                    
                    for k=1:length(x)
                        y=x{1,k};
                        
                        if y(j)==compr
                            ig=1;
                            continue
                        else
                            ig=0;
                            break
                        end
                    end
                    if ig && compr==1
                        defmat(j,i)=1;
                        
                        figure (3)
                        imshow(defmat,'InitialMagnification','fit')
                        ig=0;
                    end
                end
            end
        end
    end
    
    %% Eliminar posibilidades filas
    
    for i=1:25
        if ( (any(defmat(i,:)==0))) &&  any(completo(i,:)==0)
            x=resu{i};
            if length(x)>1
                for k=1:length(x)
                    y=x{1,k};
                    for j=1:25
                        if    y(j)==1 && defmat(i,j)==0 || y(j)==0 && defmat(i,j)==1
                            count=count+1;
                            resu{1,i}{1,k}=[];
                            break
                        end
                    end
                end
            end
        end
    end
    
    
    
    
    %% Eliminar posibilidades columnas
    
    for i=1:25
        if ( (any(defmat(:,i)==0))) &&  any(completo(:,i)==0)  % Para no repetir sobre las completas
            x=resuc{i};
            if length(x)>1
                for k=1:length(x)
                    y=x{1,k};
                    for j=1:25
                        if  y(j)==1 && defmat(j,i)==0 || y(j)==0 && defmat(j,i)==1
                            count=count+1;
                            resuc{1,i}{1,k}=[];
                            break
                        end
                        
                    end
                end
            end
        end
    end
    
    
    
    
    
    %% Generar nuevas resu y resuc
    resi={};
    resic={};
    for i=1:25
        a=resu{1,i};
        if length(a)>1
            ne=find(~cellfun(@isempty,a));
            for j=1:length(ne)
                resi{1,i}{1,j}=resu{1,i}{1,ne(j)};
            end
        else
            resi{1,i}=resu{1,i} ;
        end
        
    end
    for i=1:25
        a=resuc{1,i};
        if length(a)>1
            ne=find(~cellfun(@isempty,a));
            for j=1:length(ne)
                resic{1,i}{1,j}=resuc{1,i}{1,ne(j)};
            end
        else
            resic{1,i}=resuc{1,i} ;
        end
    end
    resu=resi;
    resuc=resic;
    clc
    disp ('Posibilidades restantes: ')
    disp (contar(resu)+contar(resuc))
    figure (4)
    imshow(completo,'InitialMagnification','fit')
    
end
disp('YA')

toc
%imwrite(defmat,'qr.jpg')
%disp (count)
%disp('Numero de iteraciones: ')
%disp (counta)
