function qpsk_str = letters2QPSK(ascii_str)
len = length(ascii_str);     % get length of ascii string
num = double(ascii_str);    % convert characters to decimal equivalent
bin_str = dec2bin(num);      % convert decimal values to binary equivalent

arr = zeros(len,1);         % initialize array to use to pad with zeros 
arr = dec2bin(arr);          % convert to binary representation
padded_str = [arr,bin_str];  % pad array with leading zero

str = padded_str(1,:);              % reshape array into one row
for i = 2:len
    str = [str,padded_str(i,:)];    % reshape array into one row
end
N = length(str);                    % get len for for loop
out_arr = zeros(1,(N/2));                       %initialize
j = 1;                              % j is indexing var
for k = 1:(N/2)
    sym_bin = [str(1,j),str(1,j+1)];    % grab 2 bin values at a time 
    sym = bin2dec(sym_bin);             % convert to decimal equivalent
    switch(sym)
        case 0                          % value 0 --> 1+0i
            num = complex(1,0);
            out_arr(1,k) = num;
        case 1                          % value 1 --> 0+i
            num = complex(0,1);
            out_arr(1,k) = num;
        case 2                          % value 2 --> 0-i (gray code)
            num = complex(0,-1);
            out_arr(1,k) = num;
        case 3                          % value 3 --> -1+0 (gray code)
            num = complex(-1,0);
            out_arr(1,k) = num;
    end
    j=j+2;                              
    
end
    qpsk_str = out_arr;
    end