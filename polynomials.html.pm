#lang pollen

◊hgroup{
    ◊h2{Polynomials}
    ◊h4{A foundation for multiple precision arithmetic}
}

◊section{     
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

◊section{
    ◊hgroup{
        ◊h4{A small detour}
        ◊h5{Where we verify the above statements with code}
    }

    Now that we covered addition and subtraction we can take a small detour and write a bit of code to verify all of the above. L
    
    Let's start with two semi random arrays of integers:

    ◊pre{◊code[#:class "cs"]{
        var p = new[] { 5, 3, 1 };
        var q = new[] { 2, 1, 4 };
    }}

    These arrays can be thought of polynomials in a very straightforward way. Every element ◊code{a[i]} in the arrays above represents a term of ◊${a_{i}x^{i}} in a polynomial where the position in the array corresponds to a power of ◊${i} in the variable ◊${x}.
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

    ◊aside{
        Later on we will start using ◊${\beta} instead of ◊${x}. Without going into much math, there is a real distinction between ◊${P(x)} and ◊${P(\beta)}. The main thing to keep in mind is that when we use ◊${x} we usually don't care too much about the actual value of ◊${x}. However, when we use ◊${\beta} we ◊strong{do} care about the actual value of ◊${\beta} for reasons that will become apparent by then.
    }
}