function result = GramSchmidt(base)
	f = @(a, b) (dot(a,b)./dot(b,b)).*b;

	[m, n] = size(base);
	result = double(zeros(m, n));
	result(:, 1) = base(:, 1);

	for i = 2:n
		soma = double(zeros(m, 1));
		atual = base(:, i);
		for j = 1:(i-1)
			soma = soma .+ f(atual, result(:, j));
		endfor
		result(:, i) = atual .- soma;
	endfor
endfunction

function VerificaBase(novaBase)
	[m, n] = size(novaBase);
	r = 0;
	for i = 1:(n-1)
		if (r != 1)
			for j = (i+1):n
				if (dot(novaBase(:, i), novaBase(:, j)) != 0)
					r = 1;
				endif
			endfor
		endif
	endfor

	#Devido a problemas de precisão decimal, o resultado, não necessariamente será verdadeiro
	if (r == 1)
		disp("A nova base não é ortogonal");
	else
		disp("A nova base é ortogonal");
	endif

endfunction

basei = [1 3 2 -1;2 -1 0 1;2 -2 3 0;5 1 -1 4];
disp("Base testada:"), disp(basei);

novaBase = GramSchmidt(basei);
disp("Base resultante:"), disp(novaBase);
VerificaBase(novaBase);