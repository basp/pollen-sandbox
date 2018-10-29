#lang pollen

◊section{     
    ◊hgroup{
        ◊h2{Polynomials}
        ◊h4{A foundation for multiple precision arithmetic}
    }

    Since arithmetic on polynomials and numbers in positional notation is so closely related we will first take a look at polynomials in order to develop a foundation for later chapters. We will only deal with polynomials with radixes and coefficients that are integers. We will allow negative powers of ◊${x} since these will be essential later when we need to model fractional numbers.

    We can write the general definition for a polynomial as

    ◊$${
        P(x) = a_{m}x^{m} + a_{m-1}x^{m-1} + \cdots + a_{l}x^{l}
    }

    with ◊${a_i\in\mathbb{Z}} and ◊${-\infty \lt l \le i \le m \lt \infty}. This just means that every ◊${a_i} is an integer and that ◊${l} and ◊${m} are respectively less than and greater than ◊${i} and not infinite. The coefficients ◊${a_m} and ◊${a_l} may be zero but in general we will only display non-zero coefficients. 
    
    ◊aside{
        If ◊${m = l} we call ◊${P(x)} a ◊em{monomial} (which is just a polynomial with one term ◊${a_{i}x^{i}} where ◊${l = m = i}).

        Sometimes these polynomials where the powers are allowed to go negative are called ◊em{extended polynomials}. Likewise, a monomial with a negative power can be called an ◊em{extended monomial}.
    }

    There are a few key aspects that are attractive about polynomials for our purpose of modeling very large numbers. They can have as many terms as you desire (except not infinitely many) and we know how to do addition and multiplication with them which is bound to be useful.

    In the rest of this book we will look at systems where ◊${x} is known have some value ◊${\beta} which is also known as the ◊strong{base} or ◊em{radix} of our number system. Before we do that however, let's take a look at polynomial arithmetic first.
}

◊section{
    ◊h4{Adding polynomials}

    Let's start with some concrete examples first since the previous section was pretty abstract. We have the polynomials

    ◊$${
        \begin{align}
        P(x) &= 3x^2 + 5x + 3\\
        Q(x) &= 5x^2 + 3x + 2
        \end{align}
    }

    with ◊${x\in\mathbb{Z}} (i.e. it's an integer) and we can calculate the sum of the polynomials
   
    ◊$${
        \begin{align}
        S(x) &= P(x) + Q(x)\\
             &= 3x^2 + 5x^2 + 5x + 3x + 3 + 2\\
             &= 8x^2 + 8x + 5
        \end{align}
    }

    without even worrying about the actual value of ◊${x}. We can write the polynomials more generally as

    ◊$${
        \begin{align}
        P(x) &= a_{m}x^{m} + a_{m-1}x^{m-1} + \cdots + a_{l}x^{l}\\
        Q(x) &= a_{n}x^{n} + a_{n-1}x^{n-1} + \cdots + a_{k}x^{k}
        \end{align}
    }

    and with ◊${p = max(m, n)} and ◊${q = min(l, k)} we can write

    ◊$${
        \begin{align}
        S(x) &= P(x) + Q(x)\\ 
             &= (a_p + b_p)x^p + (a_{p-1} + b_{p-1})x^{p - 1} + \cdots + (a_q + b_q)x^q
        \end{align}
    }

    which is the generalized form of polynomial addition. 
    
    ◊h4{Subtracting polynomials}

    Subtraction works the same way as addition except we have: 

    ◊$${
        \begin{align}
        S(x) &= P(x) - Q(x)\\ 
             &= (a_p - b_p)x^p + (a_{p-1} - b_{p-1})x^{p - 1} + \cdots + (a_q - b_q)x^q
        \end{align}
    }

    which we mention mostly for completeness but it should also intuitively make sense.
}

◊section[#:class "code"]{
    ◊h4{Code: adding polynomials}
    Now that we covered addition and subtraction we can take a small detour and write a bit of code to verify all of the above. L
    
    Let's start with two polynomials 
    ◊$${
        \begin{align}
        P(x) &= 5x^2 + 3x + 1\\
        Q(x) &= 2x^2 + x + 4
        \end{align}
    }

    represented as two arrays:
    ◊pre{◊code[#:class "cs"]{
        var p = new[] { 1, 3, 5 };
        var q = new[] { 4, 1, 2 };
    }}

    These arrays can be thought of polynomials in a very straightforward way. Every element ◊code{a[i]} in the arrays ◊code{p} and ◊code{q} represents a term of ◊${a_{i}x^{i}} in the polynomials ◊${P} and ◊${Q} respectively. 
    
    ◊aside{
        Note that the literal form of ◊code{p} and ◊code{q} appears reversed since we specify arrays like ◊code{new [] { x0, x1, ..., xn }} in code but conventionally write them the opposite way when doing math.
    }

    The code to perform an addition then:
    ◊pre{◊code[#:class "cs"]{
        public int[] PolyAdd(int[] p, int[] q)
        {
            Debug.Assert(p.Length >= 0);
            Debug.Assert(q.Length >= 0);
            Debug.Assert(p.Length >= q.Length);

            var c = new int[p.Length];
            var i = 0;
            
            for(; i < q.Length; i++)
            {
                c[i] = p[i] + q[i];
            }

            for(; i < p.Length; i++)
            {
                c[i] = p[i];
            }

            return c;
        }
    }}
}

◊section{
    ◊h4{Multiplying polynomials}

    Multiplying polynomials is a bit harder than just adding them but not too much. We'll do the same thing as before and start with a concrete example and then build up to a more generalized form.

    We have the same two polynomials

    ◊$${
        \begin{align}
        P(x) &= 5x + 4\\
        Q(x) &= 3x + 2
        \end{align}
    }

    and when we multiply them we get

    ◊$${
        \begin{align}
        R(x) &= P(x) \cdot Q(x)\\
             &= 5x \cdot 3x + 5x \cdot 2 + 4 \cdot 3x + 4 \cdot 2\\
             &= 15x^2 + 10x + 12x + 8\\
             &= 15x^2 + 22x + 8
        \end{align}
    }

    And more generally, remembering that we can write ◊${P} and ◊${Q} as
    ◊$${
        \begin{align}
        P(x) &= a_{m}x^{m} + a_{m-1}x^{m-1} + \cdots + a_{l}x^{l}\\
        Q(x) &= a_{n}x^{n} + a_{n-1}x^{n-1} + \cdots + a_{k}x^{k}
        \end{align}
    }

    with ◊${p = max(m, n)} and ◊${q = min(l, k)} we can write
    ◊$${
        \begin{align}
        R(X) &= P(x) \cdot Q(x)\\
             &= c_{m+n}x^{m+n} + c_{m+n-1}x^{m+n-1} + \cdots + c_{l+k}x^{l+k}
        \end{align}
    }
    
    where
    
    ◊$${
        \begin{align}
        c_j = a_{l}b_{j-l} + a_{l+1}b_{j-l-1} + \cdots + a_{j-k}b_{k}
        \end{align}
    }
}

◊section[#:class "code"]{
    ◊h4{Code: multiplying polynomials}

    The code to multiply two polynomials actually is a lot less daunting than the math notation from the previous section. Basically we multiply all the terms from ◊code{p} with all the terms of ◊code{q} in a nested loop:

    ◊pre{◊code[#:class "cs"]{
        public static int[] PolyMultiply(int[] p, int[] q)
        {
            Debug.Assert(p.Length >= 0);
            Debug.Assert(q.Length >= 0);
            Debug.Assert(p.Length >= q.Length);
            
            var len = Math.Max(0, p.Length + q.Length - 1);
            var c = new int[len];
            
            for(var i = 0; i < p.Length; i++)
            {
                for(var j = 0; j < q.Length; j++)
                {
                    c[i + j] = p[i] * q[j];
                }
            } 

            return c;    
        }
    }}
}

◊section{
    ◊h4{Onwards!}

    If you made it so far or even only skimped it then you are ready for the next section. Don't worry if the math does not make much sense yet. Keep reading and just glare over the parts that make no sense. Most of this is just quick notes but if you really want to understand it, the tools are out there; just start googling.

    In the next chapter we will be focussing at an interesting ◊em{subset} of polynomials that is equivalent to the ◊em{fixed radix number systems} that we mostly use today.
}