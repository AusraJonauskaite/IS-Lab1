%For this lab. you need to have Image Processing Toolbox.
%Main lab part for 8 pts.
%Classification using perceptron
clear all;
clc;

% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness
% 1.Duomenu paruosimas:
%Treniravimo duomenys:
%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
x2=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2];
% estimated features are stored in matrix P:
P=[x1;x2];
%Desired output vector
T=[1;1;1;-1;-1]; 
%Testavimo duomenys:
X1=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P3 hsv_value_P4];
X2=[metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P3 metric_P4];
%Desired output vector
T_test=[1;1;1;1;1;1;-1;-1];
%% train single perceptron with two inputs and one output
%2. parenkami pradiniai parametrai
% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);
Terr = 0;

%Create cycle for all 5 inputs to 
%calculate weighted sum with randomly generated parameters
%3.Tinklo atsako skaiciavimas
for index = 1:5
        v = x1(index)*w1 + x2(index)*w2 + b;
        % calculate current output of the perceptron 
        if v > 0
            y = 1;
        else
            y = -1;
        end
        %4.Skaiciuojamos klaidos
        % calculate the error
        e = T(index) - y;
        % calculate the total error
        Terr = Terr + abs(e);
end

%% Write training algorithm
n = 0.1;
Iteracija = 0;
while Terr ~= 0 % executes while the total error is not 0
    Terr = 0;
    for index = 1:5
        v = x1(index)*w1 + x2(index)*w2 + b;
        % calculate current output of perceptron
        %6. Persakiciuojami y
        if v > 0
            y = 1;
        else
            y = -1;
        end 
        %7.Skaiciuojama klaida
        % calculate the error value
        e = T(index) - y;
        %5. Atnaujinamo parametrai
        % update parameters
        w1 = w1 + n*e*x1(index);
        w2 = w2 + n*e*x2(index);
        b = b + n*e;
        % calculate the total error
        Terr = Terr + abs(e);
    end
    Iteracija = Iteracija + 1;
end
disp(['Iteracijos skaicius: ', num2str(Iteracija)]);

%% Testing with training data
for index = 1:5
        v = x1(index)*w1 + x2(index)*w2 + b;
        % calculate current output of the perceptron 
        if v > 0
            y = 1;
        else
            y = -1;
        end
        %8. Tikriname ar teisingas klasifikavimas
        % calculate the error
        e = T(index) - y;
        if e ~= 0
            disp('Klaidingas klasifikavimas');
        else
            disp('Teisingas klasifikavimas');
        end
end
%% Testing with testing data if we have right weights
disp('Testavimo su naujais duomenim, rezultatai: ');
%9.Tikriname testavimo duomenis
for index = 1:8
     v = X1(index)*w1 + X2(index)*w2 + b;
    % calculate current output of perceptron
    if v > 0
        y = 1;
    else
        y = -1;
    end 
    % calculate the error value
    e = T_test(index) - y;
    if e ~= 0
        disp('Nustatyta neteisinga klase');
    else
        disp('Nustatyta teisinga klase');
    end
end


