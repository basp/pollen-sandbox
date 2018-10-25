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
        S(x) = P(x) + Q(x) = (a_p + b_p)x^p + (a_{p-1} + b_{p-1})x^{p - 1} + \cdots + (a_q + b_q)x^q
    }

    which is the generalized form of polynomial addition.
    
    ◊aside{
        Without going into much math there is a real distinction between a ◊${P(x)} and ◊${P(\beta)}. The main thing to keep in mind is that when we use ◊${x} we usually don't care too much about the actual value of ◊${x}. However, when we use ◊${\beta} we ◊strong{do} care about the actual value for reasons that will be come apparent soon.
    }
}

◊section{
    ◊h4{Multiplying polynomials}

    Multiplying polynomials is a bit harder than just adding them but not too much. We'll do the same thing as before and start with a concrete example and then build up to a more generalized form.

    We have the same two polynomials

    ◊$${
        \begin{align}
        P(x) &= 3x^2 + 5x + 3\\
        Q(x) &= 5x^2 + 3x + 2
        \end{align}
    }

    and when we multiply them we get

    ◊$${
        \begin{align}
        R(x) &= P(x) \cdot Q(x)\\
             &= (3x^2 + 5x + 3) \cdot (5x^2 + 3x + 2)\\
             &= 3x^2 \cdot 5x^2 + 3x^2 \cdot 3x + 3x^2 \cdot 2 + 5x \cdot 5x^2 + 5x\cdot 3x + 5x \cdot 2 + 3 \cdot 5x^2 + 3 \cdot 3x + 3 \cdot 2
        \end{align}
    }

    When you look at that last expansion you can quickly see why naive multiplication is ◊${O(n^2)}. In this case ◊${n = 3} since our ◊em{largest} polynomial has 3 terms (actually they both have 3 terms) which means ◊${O(3^2) = 9}. The last line in the expansion of ◊${R(x)} above contains exactly 9 terms which are summed up.
}