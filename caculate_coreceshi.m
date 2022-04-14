file{1,6} = 'USAir';
training_set = load(['基本数据/data' num2str(1) '/' file{1,6} '/training.txt'],'-ascii');
core = core_true(training_set);