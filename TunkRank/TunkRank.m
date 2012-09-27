n=100;
a=zeros(n);
influence=zeros(n,1);
p=0.25;
error=1;

%% Generate Graph

for i=1:n
    for j=1:n
        if i==j
            a(i,j)=0;
        else
            a(i,j)=rand;
            if a(i,j)>0.5
                a(i,j)=1;
            else
                a(i,j)=0;
            end;
        end;
    end;
end;


%% Calculate TunkRank 

%Following(i): a(i,*): People that are following i
%Follower(j): a(*,j): People j is following

while error > 0
    infold=influence;
    for i=1:n
        influence_sum=0;
        for j=1:n
            following=sum(a(:,j));
            influence_sum=influence_sum+ a(i,j)*(1+p*influence(j))/following;
        end;
        influence(i)=influence_sum;
    end;
    error=1/2*(influence-infold)'*(influence-infold);
end;

%% Analysis of influence

boxplot(influence);
