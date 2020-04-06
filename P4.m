'(ch4p1)'                               % Display label.
p1 = [1 3 + 7*i];                       % Define polynomial containing first
                                        % pole.
p2 = [1 3 - 7*I];                       % Define polynomial containing second
                                        % pole.
deng = conv(p1,p2);                     % Multiply the two polynomials to find
                                        % the 2nd order polynomial, as^2+bs+c.
omegan = sqrt(deng(3) / deng(1))        % Calculate the natural frequency,
                                        %sqrt(c/a).
                                  
zeta = (deng(2) / deng(1)) / (2*omegan) % Calculate damping ratio, ((b/a)/2*wn).
Ts = 4 / (zeta*omegan)                  % Calculate settling time, (4/z*wn).
                                        
Tp = pi / (omegan*sqrt(1 - zeta^2))     % Calculate peak time, pi/wn*sqrt(1-z^2).
                                        
pos = 100*exp(-zeta*pi /sqrt(1-zeta^2)) % Calculate percent overshoot
                                        % 100*e^(-z*pi/sqrt(1-Z^2)).
pause

'(ch4p2) Example 4.8'                   % Display label.
'Test Run'                              % Display label.
clf                                     % Clear graph.
numt1=[24.542];                         % Define numerator of T1.
dent1=[1 4 24.542];                     % Define denominator of T1.
'T1(s)'                                 % Display label.
T1=tf(numt1,dent1)                      % Create and display T1(s).
step(T1)                                % Run a demonstration step response plot
title ('Test Run of T1 (s) ')           % Add title to graph.
pause
'Complete Run'                          % Display label.
[y1,t1]=step(T1);                       % Run step response of T1 and collect 
                                        % points.
numt2=[245.42];                         % Define numerator of T2.
p1=[1 10];                              % Define (s+10) in denominator of T2.
p2=[1 4 24.542];                        % Define (s^2+4s+24.542) in denominator 
                                        % of T2.
dent2=conv(p1,p2);                      % Multiply (s + 10)(s^2+4s+24.542)
                                        % for denominator of T2.
'T2(s)'                                 % Display label.
T2=tf(numt2, dent2)                     % Create and display T2.
[y2,t2]=step(T2);                       % Run step response of T2 and
                                        % collect points.
numt3=[73.626];                         % Define numerator of T3.
p3=[1 3];                               % Define (s+3) in denominator of T3.
dent3=conv(p3,p2);                      % Multiply (s+3) (s^2+4s+24.542)
                                        % for denominator of T3.
'T3(s)'                                 % Display label.
T3=tf(numt3,dent3)                      % Create and display T3.
[y3,t3]=step(T3);                       % Run step response of T3 and collect
                                        % points.
clf                                     % Clear graph.
plot(t1,y1,t2,y2,t3,y3)                 % Plot acquired points with all three
                                        % plots on one graph.
title ('Step Responses of T1(s),T2 (s), and T3(s)')
                                        % Add title to graph.
xlabel('Time(seconds)')                 % Add time axis label.
ylabel ('Normalized Response ')         % Add response axis label.
text(0.7,0.7,'c3(t)')                   % Label step response of T1.
text(0.7,1.1,'c2(t)')                   % Label step response of T2.
text(0.5,1.3,'c1(t)')                   % Label step response of T3.
pause
step(T1,T2,T3)                          % Use alternate method of plotting
                                        % step responses.
title ('Step Responses of T1(s), T2(s), and T3(s)')
                                        % Add title to graph.
pause

'(ch4p3)'                               % Display label.
clf                                     % Clear graph.
A=[0 1 0; 0 0 1; -24 -26 -9];           % Generate A matrix.
B=[0; 0; 1];                            % Generate B vector.
C=[2 7 1];                              % Generate C vector.
D=0;                                    % Generate D.
T=ss(A,B,C,D)                           % Generate LTI object, T, in state
                                         space and display.
t=0:0.1:10;                             % Define range of time for plot.
step(T,t)                               % Plot step response for given
                                         range of time.
grid on                                 % Turn grid on for plot.
pause

'(ch4p4) Antenna Control Case Study'    % Display label.
clf                                     % Clear graph.
numg=2,0,0.83;                          % Define numerator of G(s).
deng=[1,101.71,171];                    % Define denominator of G(s).
'G(s)'                                  % Display label.
G=tf (numg,deng)                        % Form and display transfer
                                        % Function G(s).
step(G);                                % Generate step response.
title('Angular Velocity Response')      % Add title.
pause

'(ch4p5) UFSS Case Study'               % Display label.
clf                                     % Clear graph.
'(a)'                                   % Display label.
numg=0.0169;                            % Define numerator of 2nd order
                                        % approximation of G(s).
deng=[1 0.226 0.0169];                  % Define 2nd order term of
                                        % denominator of G(s).
'G(s)'                                  % Display label.
G=tf(numg,deng);                        % Create and display G(s).
omegan=sqrt(deng(3))                    % Find natural frequency.
zeta=deng(2)/(2 *omegan)                % Find damping ratio.
Ts=4/(zeta*omegan)                      % Find settling time.
Tp=pi/(omegan*sqrt(1-zeta^2))           % Find peak time.
pos=exp(-zeta*pi/sqrt(1-zeta^2))*100;   % Find percent overshoot.
t=0:0.1:35;                             % Limit time to find rise time. t=0
                                        % to 35 in steps of 0.1.
[y,t]=step(G,t);                        % Generate and save points of step
                                        % response over defined range of t.
Tlow=interp1(y,t,0.1);                  % Search table for time when
                                        % y=0 . 1*finalvalue.
Thi=interp1(y,t,0.9);                   % Search table for
                                        % time=0.9*finalvalue.
Tr=Thi-Tlow                             % Calculate rise time.
'(b)'                                   % Display label.
numc=0.125*[1 0.435];                   % Define numerator of C(s).
denc=conv(poly([0-1.23]),[1 0.226 0.0169]);
                                        % Define denominator of C(s).
[K,p,k]=residue(numc, denc)             % Find partial-fraction expansion.
'(d)'                                   % Display label.
numg=0.125*[1 0.435];                   % Define numerator of G(s).
deng=conv([11.23],[1 0.226 0.0169]);    % Define denominator of G(s).
'G(s)'                                  % Display label.
G=tf(numg,deng)                         % Create and display G(s).
[y,t]=step(G);                          % Generate complete step response
                                        % and collect points.
plot(t,y)                               % Plot points.
title ('Pitch Angle Response ')         % Add title.
xlabel('Time (seconds)')                % label time axis.
ylabel ('Pitch Angle (radians) ')       % Label y-axis.
pause