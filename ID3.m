% returns a decision tree
function  [node,child_value,child_node_num]=ID3(trainData)
    clear clear global node child_value child_node_num;
    global node child_value child_node_num
    
    % training data
    no_features = length(trainData'*trainData)-1;
    DValue=trainData(:,1:end-1);    
    
    CN=trainData(:,end);
    CN=num2str(CN);
    for i=1:length(CN)
        A(i)=i;
    end
    ClassPNum=1:1:(length(trainData'*trainData)-1);
    m=0;
    [node,child_value,child_node_num]=TreeNode( DValue, CN, A, ClassPNum,m ); 

end

function [node,child_value,child_node_num]=TreeNode( DValue, CN, A, ClassPNum,m)
    global node child_value child_node_num
    n=length(node);
    if m>0
        % if the parent node exist, put the serial number into the parent
        k=length(child_node_num{m});
        child_node_num{m}(k+1)=n+1;  
    end     
    % empty
    if isempty(DValue)
        node{ n+1 }=[];
        child_value{ n+1 }=[];
        child_node_num{ n+1 }=[];
        return;
    end 
    % 2、The remaining attributes used for division are empty, and the class where the majority of tuples are located is selected as the node
    if isempty( ClassPNum ) 
       node{ n+1 }=find_most( CN,A );
       child_value{ n+1 }=[];
       child_node_num{ n+1 }=[];
       return;
    end 
    % 3、All data in the sample belong to the same class, use this class as a node
    CNRowNum=CN_sta( CN, A);
    if length( find(CNRowNum==0) )>=2
        node{ n+1 }=CN(A(1));
        child_value{ n+1 }=[];
        child_node_num{ n+1 }=[];
        return;
    % 4、All data in the sample do not belong to the same class
    else
        I=Exp( CN,A );
        for i=1:length( ClassPNum )            
            Entropy(i)=avg_entropy( DValue(:,ClassPNum(i)), A, CN);
            Gain(i)=I-Entropy(i);
        end
        % 4.1、The information gain of each attribute is less than 0, and the class where the majority of tuples are located is selected as the node
        if max(Gain)<=0
            node{ n+1 }=find_most( CN,A );
            child_value{ n+1 }=[];
            child_node_num{ n+1 }=[];
        return;
        % 4.2、Divide on the attribute with the greatest information gain
        else
            maxG=find( Gain==max(Gain) );
            [PValue RowNum]=type_sta( DValue(:,ClassPNum(maxG(1))), A );
            node{ n+1 }=ClassPNum(maxG(1));
            child_value{ n+1 }=PValue;
            child_node_num{ n+1 }=[];
            ClassPNum(maxG)=[];    
            for i=1:length(PValue)
                [node,child_value,child_node_num]=TreeNode( DValue, CN, RowNum{i}, ClassPNum,n+1 );
            end
            return;
        end
    end
end

% A-Line number involved in division
function most_type=find_most( CN,A )
    TypeName={'1','2','3'};
    CNRowNum=CN_sta( CN, A);
    n=max(CNRowNum);
    maxn=find( CNRowNum==n );
    most_type=TypeName{maxn};
end

% Compute the entropy of property P
function entropy=avg_entropy( Attri, A, CN )
    k=0;entropy=0;
    n=length(A);
    I=Exp( CN,A );
    [PValue,RowNum]=type_sta( Attri, A );
    for i=1:length( PValue )
        CI=Exp( CN, RowNum{i});
        entropy=entropy-length( RowNum{i} )/n*CI;
    end
end

% Calculate the expectation of sample classification

function I=Exp(CN,A)
    CNRowNum=CN_sta( CN, A );
    n=length(A);
    I=0;
    for i=1:3
        if CNRowNum(i)>0
            P(i)=CNRowNum(i)/n;
            I=I-P(i)*log2( P(i) );
        end
    end
end

% The value of the statistical attribute and the set of line numbers corresponding to each value

function [PValue,RowNum]=type_sta( Attri, A)
    k=1;
    PValue=Attri( A(1) );
    RowNum{1}=A(1);
    for i=2:length(A)
        n1=find( PValue==Attri( A(i) ) );
        if isempty(n1)
            k=k+1;
            PValue(k)=Attri( A(i) );
            RowNum{k}=A(i);
        else
            n2=length( RowNum{n1} );
            RowNum{n1}(n2+1)=A(i);
        end
    end            
end

% The value of the statistical category attribute and the set of line numbers corresponding to each value

function CNRowNum=CN_sta( CN, A)
    CNRowNum=[0 0 0];
    TypeName={'1','2'};
    for i=1:length( A )
        if strcmp( CN(A(i)),TypeName{1})
            CNRowNum(1)=CNRowNum(1)+1;
        elseif strcmp( CN(A(i)),TypeName{2} )
            CNRowNum(2)=CNRowNum(2)+1;
        else CNRowNum(3)=CNRowNum(3)+1;
        end
    end            
end