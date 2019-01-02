function newPopulation=deleteUnsuitable(state,options,nbrtocreate,n,nvars)
    suitableNum=1;
    sizeOfPopInitRange=size(options.PopInitRange);
    newPopulation=zeros(options.PopulationSize*2,sizeOfPopInitRange(1,2));
    while(true)
        sprintf('deleteUnsuitable....')
        state.Population(n-nbrtocreate+1:n,:) = ...
            repmat(options.PopInitRange(1,:),nbrtocreate,1) + ...
            repmat((options.PopInitRange(2,:) - options.PopInitRange(1,:)),...
            nbrtocreate,1).*rand(nbrtocreate,nvars) ;
        populationSize=size(state.Population);
        for i=1:1:populationSize(1,1)%对每一个个体，检查是否符合预置的要求
            population=state.Population(i,:);
            suitableOrNot=checkPic(population);
            if(suitableOrNot==1)
                newPopulation(suitableNum,:)=population;
                suitableNum=suitableNum+1;
            end
        end
        if(suitableNum>=populationSize(1,1))
            break;
        end
    end
    state.Population=newPopulation(1:options.PopulationSize,:);
    newPopulation=state.Population;
end