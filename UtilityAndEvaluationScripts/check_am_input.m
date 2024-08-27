% 2019.01.09 - Created - Alex Salmon
% This is a hastily made script to check for inhomogeneities in an
% automontager input. It may have redundant outputs, and it could certainly
% be optimized and cleaned up and errors need handling, may only work on
% > 2016b

% Get images
img_path = uigetdir('.', 'Select folder with images');
contents = dir(fullfile(img_path, '*.tif'));
% Separate by modality
contents = {contents.name}';
confocals = contents(contains(contents, 'confocal'));
splits = contents(contains(contents, 'split_det'));
avgs = contents(contains(contents, 'avg'));

% Confocal
for ii=1:numel(confocals)
    split_check = strrep(confocals{ii}, 'confocal', 'split_det');
    avg_check = strrep(confocals{ii}, 'confocal', 'avg');
    if ~any(contains(splits, split_check))
        fprintf('Expected %s, not found\n', split_check);
    end
    if ~any(contains(avgs, avg_check))
        fprintf('Expected %s, not found\n', avg_check);
    end
end

% Split
for ii=1:numel(splits)
    confocal_check = strrep(splits{ii}, 'split_det', 'confocal');
    avg_check = strrep(splits{ii}, 'split_det', 'avg');
    if ~any(contains(confocals, confocal_check))
        fprintf('Expected %s, not found\n', confocal_check);
    end
    if ~any(contains(avgs, avg_check))
        fprintf('Expected %s, not found\n', avg_check);
    end
end

% Avg
for ii=1:numel(avgs)
    split_check = strrep(avgs{ii}, 'avg', 'split_det');
    confocal_check = strrep(avgs{ii}, 'avg', 'confocal');
    if ~any(contains(splits, split_check))
        fprintf('Expected %s, not found\n', split_check);
    end
    if ~any(contains(confocals, confocal_check))
        fprintf('Expected %s, not found\n', confocal_check);
    end
end




