
a = 0;
b = 1;
tol = 1e-6;     % Error

function val = fun(x)
    val = exp(-x^2) + 1/(x^2+1) - 1;
endfunction

function [sol, niter, error] = biseccion(a, b, cotaerror)

    cont = 0;
    xant = a;
    xsig = b;

    while abs(xsig-xant) > cotaerror
        cont = cont+1;
        if fun(xant) * fun(xsig) < 0
            xmed = (xant+xsig) / 2;
            if fun(xmed) * fun(xant) < 0
                xsig = xmed;
            elseif fun(xsig) * fun(xmed) < 0
                xant = xmed;
            else
                sol = xmed;
                error = 0;
                niter = cont;
                break
            end
        elseif fun(xant) * fun(xsig) > 0
            disp('Intervalo Incorrecto')
            break
        elseif fun(xant) == 0
            sol = xant;
            error = 0;
            niter = cont;
            break
        else
            sol = xsig;
            error = 0;
            niter = cont;
            break
        end
    end

    sol = xmed;
    niter = cont;
    error = abs(xsig-xant);
endfunction

[sol, iter, error] = biseccion(a, b, tol);

disp('Solution:');
disp(sol);
disp('Number of iterations:');
disp(iter);
disp('Error:');
disp(error);
