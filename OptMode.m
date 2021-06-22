% RCR循环冗余码实验
% 模式选择： 'CRC8' . 'CRC16'
% CRC8 1000，0111
% CRC16 1100，0000，0000，0101
%
% BinResult：二进制输出-----字符型
% DecResult：十进制输出-----字符型
% HexResult：十六进制输出---字符型
% *All outputs are ‘char’ types
% ===========================
% 开发者：Lim （林政扬）    |  Author: Lim
% 开发时间：2021-04-08      |  Time: 04/08/2021
% 版本：210408.1            |  Version: 210408.1
% ===========================
%
function [BinResult,DecResult,HexResult]=OptMode(ModeString,Data)
%
global CRC8;
global CRC16;
global Totaldata;
CRC8=[0 0 0,0 1 1 1];
CRC16=[1 0 0,0 0 0 0, 0 0 0 0,0 1 0 1];
BinResult=[];
in_break=0;
% Debug Data to Modulata
% Data=[1,1,1,0,1,1,0,1,0,1,0,1,0,1,1,0,0,1,1,1];
%
%
% CRC8 Mode
if strcmp(ModeString,'CRC8')
    
    m=length(CRC8);
    remain=zeros(1,m);
    Totaldata=[Data,remain];
        %jude the case like 00110101101 mode2 
        while ~Totaldata(1) 
            Totaldata(1)=[];
            if isempty(Totaldata)
                msgbox('Input data is invalid!');
                error('Input data is invalid!');
            end
        end

    versus=Totaldata(2:(m+1));
    MaxRecu=length(Totaldata)-m-1;
    Totaldata(1:8)=[];
    for i=1:MaxRecu+4
        
        relay=xor(versus,CRC8);
        
        
        if sum(relay)
            fir=min(find(relay~=0));%fist none-zero position
            k=fir+1;%remain 
            fillcount=fir;%count of filled num
            
            versus(1:(7-fir))=double(relay(k:end));
            %
            %Judge whether the divisor is enough
            if length(Totaldata)>=fillcount
                versus((8-fir):end)=Totaldata(1:fillcount);
                Totaldata(1:fillcount)=[];               
            else
                result=relay(k-1:end);
                result=[result,Totaldata];
                preparecount=7-length(result);
                if preparecount
                    result=[zeros(1,preparecount),result]; 
                end
                break;
                
            end
        
            
        else %case:xor(versus,CRC8)=0;
                %Judge whether it's just the end of the division 
                if isempty(Totaldata) 
                    result=zeros(1,m);
                    break;
                else  %Judge whether the divisor is enough
                    %Enough
                    if length(Totaldata)>=8 %jump the 0 
                         while ~Totaldata(1) 
                            Totaldata(1)=[];
                            if isempty(Totaldata)
                                result=zeros(1,m);
                                in_break=1;
                                break;
                            end
                         end
                         if in_break==1 %jude whether the remain is all 0 
                             break;
                         end
                        versus=Totaldata(2:(m+1));
                        Totaldata(1:8)=[];
                    else
                        %Not enough                        
                        result=Totaldata;
                        preparecount=7-length(result);
                        if preparecount
                            result=[zeros(1,preparecount),result]; 
                        end
                        break;
                    end
                        
                end            
            
            
            
        end

            
    end
    BinResult=num2str(result(1));
    
    for i=2:7
        BinResult=strcat(BinResult,num2str(result(i)));
    end
    DecResult=bin2dec(BinResult);
    HexResult=dec2hex(DecResult);
    if length(HexResult)==1
        HexResult=strcat('0x0',HexResult);
    else
        HexResult=strcat('0x',HexResult);
    end
end
%
%
% CRC16 Mode
if strcmp(ModeString,'CRC16')
    
    m=length(CRC16);
    remain=zeros(1,m);
    Totaldata=[Data,remain];
        %jude the case like 00110101101 mode2 
        while ~Totaldata(1) 
            Totaldata(1)=[];
            if isempty(Totaldata)
                msgbox('Input data is invalid!');
                error('Input data is invalid!');
            end
        end
        
        
    versus=Totaldata(2:(m+1));
    MaxRecu=length(Totaldata)-m-1;
    Totaldata(1:16)=[];
    for i=1:MaxRecu+4
        
        relay=xor(versus,CRC16);
        
        
        if sum(relay)
            fir=min(find(relay~=0));%fist none-zero position
            k=fir+1;%remain 
            fillcount=fir;%count of filled num
            
            versus(1:(15-fir))=double(relay(k:end));
            %
            %Whether the remain is enough
            if length(Totaldata)>=fillcount
                versus((16-fir):end)=Totaldata(1:fillcount);
                Totaldata(1:fillcount)=[];
            else
                result=relay(k-1:end);
                result=[result,Totaldata];
                preparecount=15-length(result);
                if preparecount
                    result=[zeros(1,preparecount),result];       

                end
                break;
            end
            
        else  %case:xor(versus,CRC16)=0;
                %Judge whether it's just the end of the division 
                if isempty(Totaldata) 
                    result=zeros(1,m);
                    break;
                else  %Judge whether the divisor is enough
                    %Enough
                         while ~Totaldata(1) 
                            Totaldata(1)=[];
                            if isempty(Totaldata)
                                result=zeros(1,m);
                                break;
                            end
                         end
                    if length(Totaldata)>=16
                         while ~Totaldata(1) 
                            Totaldata(1)=[];
                            if isempty(Totaldata)
                                result=zeros(1,m);
                                in_break=1;
                                break;
                            end
                         end
                         if in_break==1
                             break;
                         end
                        versus=Totaldata(2:(m+1));
                        Totaldata(1:16)=[];
                    else
                        %Not enough                        
                        result=Totaldata;
                        preparecount=15-length(result);
                        if preparecount
                            result=[zeros(1,preparecount),result]; 
                        end
                        break;
                    end
                        
                end  
        end
    end
    BinResult=num2str(result(1));
    
    for i=2:15
        BinResult=strcat(BinResult,num2str(result(i)));
    end
    DecResult=bin2dec(BinResult);
    HexResult=dec2hex(DecResult);
    switch length(HexResult)
        case 1
            HexResult=strcat('0x000',HexResult);
        case 2
            HexResult=strcat('0x00',HexResult);
        case 3
            HexResult=strcat('0x0',HexResult);
        case 4
            HexResult=strcat('0x',HexResult);
        otherwise
                error('Something Wrong! Please call the administer to fix');
    end
end

end
