clear all;
close all;
clc;

h=waitbar(0,'Loading...'); %Waitbar is here to measure time and show when initialization 
tic                                           %is over 
instrhwinfo('Bluetooth');                     %Command that gives back structure for communication with Bluetooth
instrhwinfo('Bluetooth','HC-06');             %Starting communication with Bluetooth
toc
commandwindow
close(h);

b = Bluetooth('HC-06',1);                     %Name of device and number of data that will be sent
                                              

fopen(b);                                     %Opening communication port for Bluetooth

k=0;
s=1;
EKG=zeros(500);                               %Initalization of matrix (dim: 500x500) where data will be stored
m=1;
i=1;
while(1)
    for i=i:5*m;                              %With this loop we read 5 digital points and then send them via Bluetooth
    EKG(s,i)=fscanf(b,'%f',1);
    end
    
    m=m+1;
    figure(1)
    plot((k*500+1)/100:0.01:((k+1)*500)/100,EKG(s,:));  %Plotting graph in real time, 
                                                        %with step 0.01s
                                                        %and plots graph
                                                        %with x-axis of 5s
                                                       
                                                                                                         
    grid minor
    title('ECG','FontSize',12);
    ylabel('Amplitude [mV]','FontSize',10);
    xlabel('time [s]','FontSize',10);
  
    if (i==500)    %With this loop we will store data in matrix, so all data will be saved after plotting
        k=k+1;     %All data will be saved in rows so we can see again any row that was ploted 
        s=s+1;     
        i=1;
        m=1;
    end
end

fclose(b);       %With this command we close Bluetooth communication port  
