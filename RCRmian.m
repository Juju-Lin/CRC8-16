% RCR循环冗余码实验
% 模式选择： 'CRC8' . 'CRC16'
% CRC8 1000，0111
% CRC16 1100，0000，0000，0101
% BinResult：二进制输出-----字符型
% DecResult：十进制输出-----字符型
% HexResult：十六进制输出---字符型
% BinResult、DecResult、HexResult：All ‘Char’Type
% TranferedData：转换后得到的二进制数据----字符型
%  TranferedData：（Binary Data---‘Char’Type）
% ===========================
% 开发者：Lim （林政扬）    |  Author: Lim
% 开发时间：2021-04-08      |  Time: 04/08/2021
% 版本：210408.1            |  Version: 210408.1
% ===========================
function [BinResult,DecResult,HexResult,TranferedData]=RCRmian(data,mode)
global CRC8;
global CRC16;
global Totaldata;
global BinResult;
global DecResult;
global HexResult;
global OptDeveloper;
global TranferedData;

if OptDeveloper==0
    CRC8=[0 0 0,0 1 1 1];
    CRC16=[1 0 0,0 0 0 0, 0 0 0 0,0 1 0 1];
end

% 
% fprintf('Data you want to sent (Hexadecimal or Binary)\n');
% fprintf('Please start with 0x if you sent in hexadecimal format\n');
% data=input('Waiting Input!-----','s');
% % Transfer to Binary
% fprintf('\nBinary :\n')
[TranferedData]=IdentifyInput(data);%Convert to Binary
BiData=zeros(1,length(TranferedData));
for ii=1:length(TranferedData)
    BiData(ii)=str2num(TranferedData(ii));%Binary Data=>digit;
end

% fprintf('\n mode you want \n');
% fprintf('Input CRC8 or CRC16\n');
% mode=input(' ','s');
[BinResult,DecResult,HexResult]=OptMode(mode,BiData);
end
%
%
%%
%
% % Subfunction we used
% % Redundancy code under different mode
% % Core Algorithm
% function [BinResult,DecResult,HexResult]=OptMode(ModeString,Data)
% %
% global CRC8;
% global CRC16;
% global Totaldata;
% CRC8=[0 0 0,0 1 1 1];
% CRC16=[1 0 0,0 0 0 0, 0 0 0 0,0 1 0 1];
% BinResult=[];
% 
% % Debug Data to Modulata
% % Data=[1,1,1,0,1,1,0,1,0,1,0,1,0,1,1,0,0,1,1,1];
% %
% %
% % CRC8 Mode
% if strcmp(ModeString,'CRC8')
%     
%     m=length(CRC8);
%     remain=zeros(1,m+1);
%     Totaldata=[Data,remain];
%         %jude the case like 00110101101 mode2 
%         while ~Totaldata(1) 
%             Totaldata(1)=[];
%             if isempty(Totaldata)
%                 msgbox('Input data is invalid!');
%                 error('Input data is invalid!');
%             end
%         end
% 
%     versus=Totaldata(2:(m+1));
%     MaxRecu=length(Totaldata)-m-1;
%     Totaldata(1:8)=[];
%     for i=1:MaxRecu
%         
%         relay=xor(versus,CRC8);
%         
%         
%         if sum(relay)
%             fir=min(find(relay~=0));%fist none-zero position
%             k=fir+1;%remain 
%             fillcount=fir;%count of filled num
%             
%             versus(1:(7-fir))=double(relay(k:end));
%             %
%             %Judge whether the divisor is enough
%             if length(Totaldata)>=fillcount
%                 versus((8-fir):end)=Totaldata(1:fillcount);
%                 Totaldata(1:fillcount)=[];               
%             else
%                 result=relay(k-1:end);
%                 result=[result,Totaldata];
%                 preparecount=8-length(result);
%                 if preparecount
%                     result=[zeros(1,preparecount),result]; 
%                 end
%                 break;
%                 
%             end
%             
%         else  %case:xor(versus,CRC8)=0;
%                 %Judge whether it's just the end of the division 
%                 if isempty(Totaldata) 
%                     result=zeros(1,m+1);
%                     break;
%                 else  %Judge whether the divisor is enough
%                     %Enough
%                     if length(Totaldata)>=8
%                         versus=Totaldata(2:(m+1));
%                         Totaldata(1:8)=[];
%                     else
%                         %Not enough                        
%                         result=Totaldata;
%                         preparecount=8-length(result);
%                         if preparecount
%                             result=[zeros(1,preparecount),result]; 
%                         end
%                         break;
%                     end
%                         
%                 end            
%             
%             
%             
%         end
% 
%             
%     end
%     BinResult=num2str(result(1));
%     
%     for i=2:8
%         BinResult=strcat(BinResult,num2str(result(i)));
%     end
%     DecResult=bin2dec(BinResult);
%     HexResult=dec2hex(DecResult);
%     if length(HexResult)==1
%         HexResult=strcat('0x0',HexResult);
%     else
%         HexResult=strcat('0x',HexResult);
%     end
% end
% %
% %
% % CRC16 Mode
% if strcmp(ModeString,'CRC16')
%     
%     m=length(CRC16);
%     remain=zeros(1,m+1);
%     Totaldata=[Data,remain];
%         %jude the case like 00110101101 mode2 
%         while ~Totaldata(1) 
%             Totaldata(1)=[];
%             if isempty(Totaldata)
%                 msgbox('Input data is invalid!');
%                 error('Input data is invalid!');
%             end
%         end
%     versus=Totaldata(2:(m+1));
%     MaxRecu=length(Totaldata)-m-1;
%     Totaldata(1:16)=[];
%     for i=1:MaxRecu
%         
%         relay=xor(versus,CRC16);
%         
%         
%         if sum(relay)
%             fir=min(find(relay~=0));%fist none-zero position
%             k=fir+1;%remain 
%             fillcount=fir;%count of filled num
%             
%             versus(1:(15-fir))=double(relay(k:end));
%             %
%             %Whether the remain is enough
%             if length(Totaldata)>=fillcount
%                 versus((16-fir):end)=Totaldata(1:fillcount);
%                 Totaldata(1:fillcount)=[];
%             else
%                 result=relay(k-1:end);
%                 result=[result,Totaldata];
%                 preparecount=16-length(result);
%                 if preparecount
%                     result=[zeros(1,preparecount),result];       
% 
%                 end
%                 break;
%             end
%             
%         else  %case:xor(versus,CRC16)=0;
%                 %Judge whether it's just the end of the division 
%                 if isempty(Totaldata) 
%                     result=zeros(1,m+1);
%                     break;
%                 else  %Judge whether the divisor is enough
%                     %Enough
%                     if length(Totaldata)>=16
%                         versus=Totaldata(2:(m+1));
%                         Totaldata(1:16)=[];
%                     else
%                         %Not enough                        
%                         result=Totaldata;
%                         preparecount=16-length(result);
%                         if preparecount
%                             result=[zeros(1,preparecount),result]; 
%                         end
%                         break;
%                     end
%                         
%                 end  
%         end
%     end
%     BinResult=num2str(result(1));
%     
%     for i=2:16
%         BinResult=strcat(BinResult,num2str(result(i)));
%     end
%     DecResult=bin2dec(BinResult);
%     HexResult=dec2hex(DecResult);
%     switch length(HexResult)
%         case 1
%             HexResult=strcat('0x000',HexResult);
%         case 2
%             HexResult=strcat('0x00',HexResult);
%         case 3
%             HexResult=strcat('0x0',HexResult);
%         case 4
%             HexResult=strcat('0x',HexResult);
%         otherwise
%                 error('Something Wrong! Please call the administer to fix');
%     end
% end
% 
% end


% % Base Conversion Function
% function [TranferedData]=IdentifyInput(Data)
% if strcmp(Data(1:2),'0x')||strcmp(Data(1:2),'0X')
%     newdata=Data(3:end);
%     lon=length(newdata);
%     TranferedData=[];
%     %Transfer to Binary
%     for i=1:lon
%         Hex2Bin=[];
%         Character=newdata(i);
%         [Hex2Bin]=CheckTable(Character);
%         TranferedData=[TranferedData,Hex2Bin];
%     end
% else
%     TranferedData=Data;
% end   
%   
% end
%
%
% Hexadecimal 2 Binary
% function [Hex2Bin]=CheckTable(Character)
% switch Character
%     case '1'
%         Hex2Bin='0001';
%     case '2'
%         Hex2Bin='0010';
%     case '3'
%         Hex2Bin='0011'; 
%     case '4'
%         Hex2Bin='0100';
%     case '5'
%         Hex2Bin='0101';
%     case '6'
%         Hex2Bin='0110';
%     case '7'
%         Hex2Bin='0111';
%     case '8'
%         Hex2Bin='1000';
%     case '9'
%         Hex2Bin='1001';
%     case {'A','a'}
%         Hex2Bin='1010';
%     case{'B','b'}
%         Hex2Bin='1011';
%     case{'C','c'}
%         Hex2Bin='1100';
%     case {'D','d'}
%         Hex2Bin='1101';
%     case{'E','e'}
%         Hex2Bin='1110';
%     case{'F','f'}
%         Hex2Bin='1111';
%     otherwise
%         error('Input Argument!  Check the Input Format!');
% end        
% end
%
%
% Check the result 
% function [BinRecovery,DecRecovery,HexRecovery]=CheckResult(binresul,ModeString)
% global CRC8;
% global CRC16;
% global Totaldata;
% CRC8=[0 0 0,0 1 1 1];
% CRC16=[1 0 0,0 0 0 0, 0 0 0 0,0 1 0 1];
% BinRecovery=[];
% 
% % Debug Data to Modulata
% % binresul=[1,1,0,1,0,1,0,0,0,1,1,0];
% % ModeString='CRC8';
% %
% %
% % CRC8 Mode
% if strcmp(ModeString,'CRC8')
%     FillNumber=0;
%     m=length(CRC8);
%     Totaldata=[binresul];
%         %jude the case like 00110101101 mode2 
%         while ~Totaldata(1) 
%             Totaldata(1)=[];
%             FillNumber=FillNumber+1;%Fill the zero number
%             if isempty(Totaldata)
%                 msgbox('Input data is invalid!');
%                 error('Input data is invalid!');
%             end
%         end
% 
%     versus=Totaldata(2:(m+1));
%     MaxRecu=length(Totaldata)-m-1;
%     Totaldata(1:8)=[];
%     %plus 4 to make sure enough loops
%     for i=1:MaxRecu+4
%         
%         relay=xor(versus,CRC8);
%         
%         
%         if sum(relay)
%             fir=min(find(relay~=0));%fist none-zero position
%             k=fir+1;%remain 
%             fillcount=fir;%count of filled num
%             
%             versus(1:(7-fir))=double(relay(k:end));
%             %
%             %Judge whether the divisor is enough
%             if length(Totaldata)>=fillcount
%                 versus((8-fir):end)=Totaldata(1:fillcount);
%                 Totaldata(1:fillcount)=[];               
%             else
%                 result=relay(k-1:end);
%                 result=[result,Totaldata];
%                 preparecount=8-length(result);
%                 if preparecount
%                     result=[zeros(1,preparecount),result]; 
%                 end
%                 break;
%                 
%             end
%             
%         else  %case:xor(versus,CRC8)=0;
%                 %Judge whether it's just the end of the division 
%                 if isempty(Totaldata) 
%                     result=zeros(1,m+1);
%                     break;
%                 else  %Judge whether the divisor is enough
%                     %Enough
%                     if length(Totaldata)>=8
%                         versus=Totaldata(2:(m+1));
%                         Totaldata(1:8)=[];
%                     else
%                         %Not enough                        
%                         result=Totaldata;
%                         preparecount=8-length(result);
%                         if preparecount
%                             result=[zeros(1,preparecount),result]; 
%                         end
%                         break;
%                     end
%                         
%                 end            
%             
%             
%             
%         end
% 
%             
%     end
%     BinRecovery=num2str(result(1));
%     
%     for i=2:8
%         BinRecovery=strcat(BinRecovery,num2str(result(i)));
%     end
%     DecRecovery=bin2dec(BinRecovery);
%     HexRecovery=dec2hex(DecRecovery);
%     if length(HexRecovery)==1
%         HexRecovery=strcat('0x0',HexRecovery);
%     else
%         HexRecovery=strcat('0x',HexRecovery);
%     end
% end
% %
% %
% % CRC16 Mode
% if strcmp(ModeString,'CRC16')
%     
%     m=length(CRC16);
%     FillNumber=0;
%     Totaldata=[binresul];
%         %jude the case like 00110101101 mode2 
%         while ~Totaldata(1) 
%             FillNumber=FillNumber+1; %Count the zero number
%             Totaldata(1)=[];
%             if isempty(Totaldata)
%                 msgbox('Input data is invalid!');
%                 error('Input data is invalid!');
%             end
%         end
%     versus=Totaldata(2:(m+1));
%     MaxRecu=length(Totaldata)-m-1;
%     Totaldata(1:16)=[];
%     %Plus 4 to make sure enough loops
%     for i=1:MaxRecu+4
%         
%         relay=xor(versus,CRC16);
%         
%         
%         if sum(relay)
%             fir=min(find(relay~=0));%fist none-zero position
%             k=fir+1;%remain 
%             fillcount=fir;%count of filled num
%             
%             versus(1:(15-fir))=double(relay(k:end));
%             %
%             %Whether the remain is enough
%             if length(Totaldata)>=fillcount
%                 versus((16-fir):end)=Totaldata(1:fillcount);
%                 Totaldata(1:fillcount)=[];
%             else
%                 result=relay(k-1:end);
%                 result=[result,Totaldata];
%                 preparecount=16-length(result);
%                 if preparecount
%                     result=[zeros(1,preparecount),result];       
% 
%                 end
%                 break;
%             end
%             
%         else  %case:xor(versus,CRC16)=0;
%                 %Judge whether it's just the end of the division 
%                 if isempty(Totaldata) 
%                     result=zeros(1,m+1);
%                     break;
%                 else  %Judge whether the divisor is enough
%                     %Enough
%                     if length(Totaldata)>=16
%                         versus=Totaldata(2:(m+1));
%                         Totaldata(1:16)=[];
%                     else
%                         %Not enough                        
%                         result=Totaldata;
%                         preparecount=16-length(result);
%                         if preparecount
%                             result=[zeros(1,preparecount),result]; 
%                         end
%                         break;
%                     end
%                         
%                 end  
%         end
%     end
%     BinRecovery=num2str(result(1));
%     
%     for i=2:16
%         BinRecovery=strcat(BinRecovery,num2str(result(i)));
%     end
%     DecRecovery=bin2dec(BinRecovery);
%     HexRecovery=dec2hex(DecRecovery);
%     switch length(HexRecovery)
%         case 1
%             HexRecovery=strcat('0x000',HexRecovery);
%         case 2
%             HexRecovery=strcat('0x00',HexRecovery);
%         case 3
%             HexRecovery=strcat('0x0',HexRecovery);
%         case 4
%             HexRecovery=strcat('0x',HexRecovery);
%         otherwise
%                 error('Something Wrong! Please call the administer to fix');
%     end
% end
% 
% end
