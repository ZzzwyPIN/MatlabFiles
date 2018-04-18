function adpcm_y = adpcm_encoder(raw_y)
IndexTable = [-1, -1, -1, -1, 2, 4, 6, 8, -1, -1, -1, -1, 2, 4, 6, 8];%索引调整表
StepSizeTable = [7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 21, 23, 25, 28, 31, 34, 37, 41, 45, 50, 55, 60, 66, 73, 80, 88, 97, 107, 118, 130, 143, 157, 173, 190, 209, 230, 253, 279, 307, 337, 371, 408, 449, 494, 544, 598, 658, 724, 796, 876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066, 2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358, 5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899, 15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767];%步长索引表
prevsample = 0;
previndex = 1;
Ns = length(raw_y);
adpcm_y=zeros(1,Ns);
n = 1;
raw_y = 32767 * raw_y;%将输入信号变为16bit
while (n <= Ns)
    predsample = prevsample;%预测值传递
    index = previndex;%索引指针
    step = StepSizeTable(index);%取出当前量化阶
    diff = raw_y(n)-predsample;%信号现在值与预测值差
    
    if (diff>= 0) %如果差值大于0，则负号位为0，否则为3
        code = 0;
    else
        code = 8;
        diff = -diff;%取正值
    end;
    tempstep = step;%步长,量化级
    if (diff>= tempstep)
        code = bitor(code, 4);%按位或运算，将第三位编码为1
        diff = diff - tempstep;
    end;
    tempstep = bitshift(tempstep, -1);%二进制移位操作，目的是变成1/2
    if (diff >= tempstep)
        code = bitor(code, 2);%按位或运算，第二位编码为1
        diff = diff - tempstep;
    end;
    tempstep = bitshift(tempstep, -1);
    if (diff >= tempstep)
        code = bitor(code, 1);%第一位编码为1
    end;

    %逆量化器解出当前预测值与实际值差值。
    diffq = bitshift(step, -3);
    if (bitand(code, 4))%按位与运算，提取第三位
        diffq = diffq + step;
    end;
    if (bitand(code, 2))
        diffq = diffq + bitshift(step, -1);
    end;
    if (bitand(code, 1))
        diffq = diffq + bitshift(step, -2);
    end;
    if (bitand(code, 8))
        predsample = predsample - diffq;
    else
        predsample = predsample + diffq;
    end;

    %防止预测值溢出
    if (predsample > 32767)
        predsample = 32767;
    elseif (predsample < -32768)
        predsample = -32768;
    end;

    index = index + IndexTable(code+1);%更新量化阶索引

    if (index < 1)
        index = 1;
    end
    if (index > 89)
        index = 89;
    end

    prevsample = predsample;
    previndex = index;

    adpcm_y(n) = bitand(code, 15);
    %adpcm_y(n) = code;
    n = n + 1;
end
