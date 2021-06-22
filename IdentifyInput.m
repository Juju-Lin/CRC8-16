%
% RCR循环冗余码实验
% 模式选择： 'CRC8' . 'CRC16'
% CRC8 1000，0111
% CRC16 1100，0000，0000，0101
%
% TranferedData：转换后得到的二进制数据----字符型
% （Binary Data---‘Char’Type）
% ===========================
% 开发者：Lim （林政扬）    |  Author: Lim
% 开发时间：2021-04-08      |  Time: 04/08/2021
% 版本：210408.1            |  Version: 210408.1
% ===========================
%
% Base Conversion Function
function [TranferedData]=IdentifyInput(Data)
global language
if ~(strcmp(Data(1:2),'0x')||strcmp(Data(1:2),'0X')||strcmp(Data(1:2),'01')...
        ||strcmp(Data(1:2),'10')||strcmp(Data(1:2),'11'))
        switch language
        case 'English'
        errordlg('Oops! Please check the databox!','Warning!');
        error('Warning!');        
        case 'Simplified Chinese'
        errordlg('出错了! 请检查数据是否输入错误!','警告!');
        error('警告!');        
        case 'Spanish'
        errordlg('Se produjo un error. Compruebe si los datos fueron introducidos incorrectamente!',...
            'Advertencia!');
        error('Advertencia!')        
        case 'Traditional Chinese'
        errordlg('出錯了！請檢查數據是否輸入錯誤！','警告！');
        error('警告！');        
        otherwise 
        errordlg('Oops! Please check the databox!','Warning!');    
        error('Warning!');        
        end
end
if length(Data)==1
    TranferedData=Data;
else
    if strcmp(Data(1:2),'0x')||strcmp(Data(1:2),'0X')%Hexadecimal Base
        newdata=Data(3:end);%Remove '0X'
        lon=length(newdata);
        TranferedData=[];
        %Transfer to Binary
        for i=1:lon
            Hex2Bin=[];
            Character=newdata(i);
            [Hex2Bin]=CheckTable(Character);
            TranferedData=[TranferedData,Hex2Bin];
        end
    else
        TranferedData=Data;% Transfered Code
    end  
end