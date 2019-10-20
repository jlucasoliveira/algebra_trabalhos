pkg load image;

global I;
global m;
global n;
global k;
global d;

args_l = argv();

k = str2double(args_l{1});
arq_entrada = args_l{2};
arq_saida = args_l{3};

im = imread(arq_entrada);
imGray = rgb2gray(im);

I = double(imGray);
[m, n] = size(I);
d = randi([1 3], 1, 1);

m_star = floor(m*k);
n_star = floor(n*k);

I_star = zeros(m_star, n_star);

function i_str = TransLinha(linha)
	global m;
	global k;
	i_str = floor(1 + (linha - 1) * ((m - 1) / ((m * k) - 1)));
endfunction

function j_str = TransColuna(coluna)
	global n;
	global k;
	j_str = floor(1 + (coluna - 1) * ((n - 1) / ((n * k) - 1)));
endfunction

function media_cor = MediaRed(linha, coluna)
	global d;
	global I;
	global m;
	global n;

	soma = zeros(1);
	for p = -d:d
		lin = linha + p;
		for q = -d:d
			col = coluna + q;
			if (lin > 0 && col > 0 && lin <= m && col <= n)
				soma = soma + I(lin, col);
			else
				soma = soma + I(linha, coluna);
			endif
		endfor
	endfor

	media_cor = soma/(((2 * d) + 1)^2);
endfunction

for i = 1:m_star
	i_cur = TransLinha(i);
	for j = 1:n_star
		j_cur = TransColuna(j);
		if (k < 1)
			I_star(i, j) = MediaRed(i_cur, j_cur);
		else
			I_star(i, j) = I(i_cur, j_cur);
		endif
	endfor
endfor

imwrite(uint8(I_star), arq_saida);