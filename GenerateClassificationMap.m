function [ ClassificationMap ] = GenerateClassificationMap( LINES, SAMPLES, COLORTABLE, DATA )
%	CreatClassificationMap函数说明
%   本函数是根据cls头文件的信息和分类结果绘制bmp格式的分类结果图
%   参数说明：
%   LINES：原始数据的行数
%   SAMPLES：原始数据的列数
%   COLORTABLE：颜色表。格式为n*3，其中n代表类别数，即原数据共分为多少类
%   DATA：原数据每一个点的类别信息，大小为（LINES*SAMPLES）*1
%%
lines = LINES;
samples = SAMPLES;
clsnum = max(DATA);
ClassificationMap = uint8(ones(lines, samples, 3));%所有的由cls文件生成的BMP格式文件导入matlab中均为uint8格式，若在声明中不加入uint8，声明出来的格式为double，得到的最终分类结果图基本上都是错误的

for i = 1 : lines;
    for j = 1 : samples;
        ClassificationMap(i, j, :) = COLORTABLE(DATA((i - 1) * samples + j, 1), :);
    end;
end;

% imwrite(ClassificationMap, 'file.bmp', 'bmp'); 

end

