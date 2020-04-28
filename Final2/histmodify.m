function modifyhis = histmodify( input_image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 %embedding
 j=(0:255);
 Hi = imhist(input_image);
 Id, Is, Ir;
 I= Hi(0:255);
 Ir=max(I);
 Is=max(I+1);
 modified_hist = Hi(1:254);
 
 %location map
 l_map;
 
 
 
 for i:hi
     if (i:Is)
     i=i-1;
     end    
     if (i=Is)
     i=Is-bk;
     end
     if (Is<i<Ir)
         i=i;
     end
     if(i=Ir)
        i=Ir+bk;
     end
     if (i>Ir)
         i=i+1;
     end    

 end
for l_map:j
     if (id=Is-1)
     bk=1;
     end    
     if (id=Is)
     bk=0;
     end
     if (id=Ir)
         bk=0;
     end
     if(id=Ir+1)
        bk=1;
     end
end

%extraction
for i:hi
     if (id:Is-1)
     id=id+1;
     end    
     if (id=Is-1||id=Is)
     id=Is;
     end
     if (id=Iri||id=Ir)
         id=Ir;
     end
     if(id>Ir+1)
        id=id-1;
     end
     
end     