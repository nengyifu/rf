function [type] = statistics(tree_no,rnode,rchild_value,rchild_node_num,data)
    % support upto 9
    TypeName={'1','2','3','4','5','6','7','8','9'};
    TypeNum=zeros(9,1); 
    
    for i=1:tree_no
        [type]=vote(rnode,rchild_value,rchild_node_num,data,i);
        tmp = str2num(type);
        TypeNum(tmp) = TypeNum(tmp) + 1;
    end
    
    index =find( TypeNum==max(TypeNum) );
    type=str2num(TypeName{index(1)});
end
    
    
function [type] = vote(rnode,rchild_value,rchild_node_num,data,j)
    n=1;       %start from the node
    k=0;   
    while ~isempty(rchild_node_num{j,1}{n})%if is not empty(not end of the tree)
         for i=1:length(rchild_value{j,1}{n})
                if data(rnode{j,1}{n})==rchild_value{j,1}{n}(i)
                    n=rchild_node_num{j,1}{n}(i);
                    k=0;
                    break;
                end                    
         end
        
        if i==length(rchild_value{j,1}{n})
            % if this value is not in the end
           data(rnode{j,1}{n})=data(rnode{j,1}{n})+0.1*k;
           data=roundn(data,-1);
        end     
        k=(-1)^k*( abs(k)+1 );     
    end
    type=rnode{j,1}{n};                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  type=rnode{j,1}{n};
    end
