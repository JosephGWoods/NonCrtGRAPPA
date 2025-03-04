function mask = mloc2mask(mloc, dims)
% discretize mloc by round(), i.e. nearest ngb, embed the result into a mask
[m, loc] = deal(mloc(:,1), mloc(:,2:end));
if ~exist('dims','var'), dims = round(max(loc,[],1))-round(min(loc,[],1))+1; end
dims = dims(1:(size(mloc,2)-1));
loc= loc(~~m,:);

cSub = ctrSub(dims);
sub = bsxfun(@plus, round(loc), cSub);
sub(any(bsxfun(@gt, sub, dims),2), :) = [];
% sub(any(bsxfun(@lt, sub, zeros(size(dims))),2), :) = [];
sub(any(bsxfun(@le, sub, zeros(size(dims))),2), :) = []; % JGW Changed to le from lt
sub_c = num2cell(sub, 1);

mask = false(dims);
mask(sub2ind(dims, sub_c{:})) = true;

end

