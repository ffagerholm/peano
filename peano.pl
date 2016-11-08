
zero. 						% zero exists 

nat(zero).					% zero is a natural number
nat(s(N)) :- nat(N). 				% s is the successor function, e.g. s(0) = 1,
						% the successor of a natural number
						% is a natural number

% Conversion between representations
						% from peano repr. to an integer
to_number(zero, 0) :- !.			% zero represents 0
to_number(s(X), Y) :- 				% If X represents n, then s(X) represents n + 1
	!, to_number(X, Z), 
	Y is Z+1.

						% from integer to peano repr.
to_peano(0, zero) :- !.				% zero represents 0
to_peano(X, s(Y)) :- 				% If s(a) represents n, then a represents n - 1
	number(X), X > 0, !, 
	Z is X-1, to_peano(Z, Y).


%%% Relations %%%
						% Equality
						% The natural numbers are closed under equality
eq(zero, zero).					% Base case
eq(s(A), s(B)) :- eq(A, B).			% Equality, the successros of two numbers are equal if the
						% two numbers are equal

						% Divides
%div(_N, zero, _Q) :- !.			% division with 0 not defined
div(zero, s(_D), zero).				% 0 / a = 0
div(A, B, s(C)) :- 				% If d = a - b and d / b = c then a / b = c + 1
	diff(A, B, D),				% => (a - b)/b = c => a/b - b/b = c 
	div(D, B, C).				% => a/b - 1 = c => a/b = c + 1
						% a / b = 1 + (a - b)/b
% wrapper
div(A, B):- div(B, A, _C).
	
	
						% Order
						% Larger than
grt(_N, zero).					% Every natural number is larger than 0
grt(s(N), s(M)):- 				% a > b => (a + 1) > (b + 1) 
	grt(N, M), N \= M.
									
						% Less than
lst(zero, _N).					% 0 is the smallest natural number
lst(s(N), s(M)):-				% a < b => (a + 1) < (b + 1) 
	lst(N, M), N \= M.



%%% Arithmetic %%%

						% Addition
						% Base case,
						% 0 is the id. element for addition 
sum(zero, A, A).				% 0 + a = a
sum(s(A), B, s(C)) :- 				% If a + b = c then (a+1) + b = (c+1)
	sum(A, B, C).				% a + (b + 1) = c <=> (a + b) + 1 = c
						% associativity

						% Subtraction
diff(A, zero, A).				% a - 0 = a
diff(A, s(B), C) :- 				% If a - b = (c + 1) then a - (b + 1) = c
	diff(A, B, s(C)).				

						% Multiplication
prod(zero, _M, zero).				% 0 is the annihilator for multiplication, 0 * a = 0
prod(s(A), B, C) :- 				% If a * b = c and d + b = e then (a+1) * b = e
	prod(A, B, D), sum(D, B, C).    	% (a+1) * b = c <=>  a*b + b = c 
						% distributivity

						% Exponentiation
pow(zero, zero, s(zero)).			% Base case: 0^0 = 1
pow(zero, s(_), s(zero)).			% Base case: n^0 = 1
pow(s(A), B, C) :- 				% If b^a = d and d*b = c then b^(a+1) = c
	pow(A, B, D), 
	prod(D, B, C).

