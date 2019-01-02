function myans=PSO_insertone(population)%used in pso.m line 423
    load('insert_one_diceng_50_50.mat');
    insert_one_1=fftmatrix;
    load('insert_one_diceng_50_50_2.mat');
    insert_one_2=insert_one;
    final_insert_one=[insert_one_1 insert_one_2];
    population(1,:)=final_insert_one;
    myans= population;
end