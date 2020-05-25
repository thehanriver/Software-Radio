% pulseshape.m: applying a pulse shape to a text string
str='EC415';                             % message to be transmitted
m=letters2QPSK(str);                  % convert to QPSK symbols
N=length(m);                          % N = length of message
Ts=1/1000;                            % sampling interval
t=Ts:Ts:N;                            % define a 'time' vector
fc=10; csig=exp(2*pi*fc*t);           % carrier signal
M=1/Ts; mup=zeros(1,N*M); mup(1:M:N*M)=m;   % oversample by M
ps=rectwin(M);                            % blip pulse of width M
x=filter(ps,1,mup);                       % convolve pulse shape with data
y_real = x.*cos(2*pi*fc*t);               % multiply baseband by cos for real
y_imag = x.*sin(2*pi*fc*t);               % multiply basebad by sin for imag
y = y_real - y_imag;                      % sum compoonents together: passband
%y = x.*exp(1i*2*pi*fc*t);
subplot(4,1,1), plot(t,real(x))
xlabel('Real component of pulse-shaped signal')
subplot(4,1,3),plot(t,imag(x))
xlabel('Imaginary component of pulse-shaped signal')
subplot(4,1,2),plot(t,real(y))
xlabel('Real component of modulated signal "EC415"!')
subplot(4,1,4),plot(t,imag(y))
xlabel('Imaginary component of modulated signal "EC415"!')

