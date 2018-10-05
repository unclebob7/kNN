function [acc, confM]=wkCalAcc(label_pred, label_true, classes)

% Zeros in the labels mean 'unlabeled'
% All the lables are preferred to have <1 x nsamp> format

% Zeros in 'label_true' mean that they are unlabeled samples
% Zeros in 'label_pred' mean that the classifier couldn't determine which
% class it goes. <=> Classifier's failure <=> A kind of misclassification
% <=> Zeros in 'label_pred' are just wrongly classified labels.

% 1. Reformat
if size(label_pred, 2) == 1
    label_pred=label_pred';
end
if size(label_true, 2) == 1
    label_true=label_true';
end

% 2. Check the length of the two inputs
% if ~issame(length(label_pred), length(label_true))
if length(label_pred)~=length(label_true)
    error(' The length of two vectors should match');
end

% 3. Exclude zero labels in label_true
ind0=find(label_true == 0);
label_pred(ind0)=[];
label_true(ind0)=[];

% 4. Counting
n_correct=sum( label_pred == label_true);
n_wrong = sum( label_pred ~= label_true);
n_effective=length(label_pred);
if (n_correct+n_wrong) ~= n_effective
    error(' Something is wrong');
end

% 5. Accuracy
acc=n_correct/n_effective;

% 6. Calculate confusion matrix
n=length(label_true);
if nargin < 3
    classes=setdiff(unique(union(label_pred,label_true)), 0);
end
nclass=length(classes);
confM=zeros(nclass,nclass);

for i=1:nclass
    classi=classes(i);
    indi=find(label_true == classi);
    for j=1:nclass
        classj=classes(j);
        indj=find(label_pred == classj);
        indij=intersect(indi, indj);
        confM(j,i)=length(indij);
    end
end
