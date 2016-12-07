function error = calculate_error_normal(F, input, error, isChopping, check)
    format long
    syms a b c d e f
    

    aStr = num2str(input(1));
    bStr = num2str(input(2));
    cStr = num2str(input(3));
    dStr = num2str(input(4));
    eStr = num2str(input(5));
    fStr = num2str(input(6));
    
    errAStr = num2str(error(1));
    errBStr = num2str(error(2));
    errCStr = num2str(error(3));
    errDStr = num2str(error(4));
    errEStr = num2str(error(5));
    errFStr = num2str(error(6));
    
    errA = chap1.calculate_absolute_error(aStr, errAStr, isChopping);
    errB = chap1.calculate_absolute_error(bStr, errBStr, isChopping);
    errC = chap1.calculate_absolute_error(cStr, errCStr, isChopping);
    errD = chap1.calculate_absolute_error(dStr, errDStr, isChopping);
    errE = chap1.calculate_absolute_error(eStr, errEStr, isChopping);
    errF = chap1.calculate_absolute_error(fStr, errFStr, isChopping);
    
    
    a = str2double(aStr);
    b = str2double(bStr);
    c = str2double(cStr);
    d = str2double(dStr);
    e = str2double(eStr);
    f = str2double(fStr);
    
   
    if(errA < 0)
        errA = 'errA';
    end
    if(errB == -1)
        errB = 'errB';
    end
    if(errC == -1)
        errC = 'errC';
    end
    if(errD == -1)
        errD = 'errD';
    end
    if(errE == -1)
        errE = 'errE';
    end
    if(errF == -1)
        errF = 'errF';
    end
    
    if(check == 0)
        F(isspace(F)) = [];
        F = chap1.Parentheses2(F); 
    end

    A = str2num(F);
    if(isnumeric(A) == 1 && isempty(A) == 0)
        error = 0;
        return
    end
    if(F == 'a')
        error = errA;
        return
    end
    if(F == 'b')
        error = errB;
        return
    end
    if(F == 'c')
        error = errC;
        return
    end
    if(F == 'd')
        error = errD;
        return
    end
    if(F == 'e')
        error = errE;
        return
    end
    if(F == 'f')
        error = errF;
        return
    end
    
    
    fIn = F(2:length(F)-1);
    openCounter = 0;
   
    for i = 1 : length(F)
       if(fIn(i) == '(')
           openCounter = openCounter + 1;
       end
       
       if(fIn(i) == ')')
           openCounter = openCounter - 1;
       end
       
       if(fIn(i) == '+' && openCounter == 0)
           error = eval(subs(chap1.calculate_error_normal(fIn(1:i-1), input, error, isChopping, 1) + chap1.calculate_error_normal(fIn(i+1:length(fIn)), input, error, isChopping, 1)));
%             display(fIn);
%             display(error);
           return;
       end
       if(fIn(i) == '-' && openCounter == 0)
            error = chap1.calculate_error_normal(fIn(1:i-1), input, error, isChopping, 1) + chap1.calculate_error_normal(fIn(i+1:length(fIn)),input, error, isChopping, 1);
%              display(fIn);
%             display(error);
            return;

       end
       if(fIn(i) == '*' && openCounter == 0)
           error = abs(chap1.calculate_error_normal(fIn(i+1:length(fIn)), input, error, isChopping, 1) * eval(subs(fIn(1:i-1)))) + abs(chap1.calculate_error_normal(fIn(1:i-1), input, error, isChopping, 1) * eval(subs(fIn(i+1:length(fIn)))));
%             display(fIn);
%             display(error);
           return;
       end
       if(fIn(i) == '/' && openCounter == 0  )
           error =  (abs(chap1.calculate_error_normal(fIn(i+1:length(fIn)), input, error, isChopping, 1) * eval(subs(fIn(1:i-1)))) + abs(chap1.calculate_error_normal(fIn(1:i-1), input, error, isChopping, 1) * eval(subs(fIn(i+1:length(fIn)))))) / (eval(subs(fIn(i+1:length(fIn)))) ^ 2);
           
%             display(fIn);
%             display(error);
           return;
       end
        if(fIn(i) == '^' && openCounter == 0  )
           error = abs((chap1.calculate_error_normal(fIn(1:i-1), input, error, isChopping, 1) * eval(subs(fIn(1:i-1)))) * eval(subs(fIn(i+1:length(fIn)))));
%            display(fIn);
%             display(error);
           return;
        end
       if(openCounter == 0 && i == length(fIn))
            error = chap1.calculate_error_normal(fIn,input, error, isChopping, 1);
%              display(fIn);
%             display(error);
            return;
       end
    end
    
    
end