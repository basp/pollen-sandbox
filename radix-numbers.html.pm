#lang pollen

◊section{
    ◊hgroup{
        ◊h2{Radix ◊${\beta} numbers}
        ◊h4{Where things get a little bit messy}
    }

    In this section we will start using ◊${\beta} instead of ◊${x} in a lot of cases. Without going into much math, there is a real distinction between ◊${P(x)} and ◊${P(\beta)}. The main thing to keep in mind is that when we use ◊${x} we usually don't care too much about the actual value of ◊${x}. However, when we use ◊${\beta} we ◊strong{do} care about the actual value of ◊${\beta} for reasons that will become soon apparent.

    The only thing we need to do to go from a polynomial to a ◊em{positional number system} is to replace ◊${x} with some value of ◊${\beta} and limit the coefficients to values where ◊${a_i < \beta}. We will also call this value ◊${\beta} the ◊em{radix} or ◊em{base} of the number system.

    Let's start with the familiar decimal system.
    ◊$${
        2435 = 2{\beta^3} + 4{\beta^2} + 3{\beta} + 5
    }

    where ◊${\beta = 10}. 
    
    So far so good since this is exactly like the polynomials from the previous section. However, a strange thing happens when an operation between two coefficients yields a result ◊${c} where ◊${c \le -{\beta}} or where ◊${c \ge {\beta}}

    ◊$${
        \begin{align}
        P(\beta) &= 5{\beta^0}\\
        Q(\beta) &= 5{\beta^0}\\
        P(\beta) + Q{\beta} &= 1{\beta^1} + 0{\beta^0}
        \end{align}
    }

    Since our coefficients are limited to values between (but excluding) ◊${-{\beta}} and ◊${\beta} something needs to happen when a result falls outside this range.
}

◊section{
    ◊h4{Modulus}

    We will stay in the decimal system where ◊${\beta = 10} but try to make things a bit more abstract. We start with ◊em{monomials} of the form

    ◊$${
        \begin{align}
        P(\beta) &= a_0{\beta^0}\\
        Q(\beta) &= b_0{\beta^0}
        \end{align}
    }

    where ◊${-\beta \lt a_i \lt \beta} and ◊${-\beta \lt b_i \lt \beta}.

    Suppose that we are in a weird system where we are limited to monomials. We will also focus on positive coefficients for now (although everything translates naturally to negative coefficients).
    
    Now what happens when ◊${a_i + b_i \le -\beta} or when ◊${a_i + b_i \ge \beta}? Suppose we have ◊${a_0 = 5} and ◊${b_0 = 5} and we want to calculate

    ◊$${
        \begin{align}
        c_0{\beta^0} &= a_0{\beta^0} + b_0{\beta^0}\\
                     &= 5{\beta^0} + 5{\beta^0}\\
                     &= 0{\beta^0}
        \end{align}
    }

    So what's going on here? Instead of having ◊${10{\beta^0}} like in the case with polynomials we suddenly face the weird fact that when we add up two coefficients ◊${a} and ◊${b} the result equals zero.

    We have been a bit nonchalant in our math. Instead of saying that ◊${c_0{\beta^0} = a_0{\beta^0} + b_0{\beta^0}} we should have said that

    ◊$${
        \begin{align}
        c_0{\beta^0} &\equiv a_0{\beta^0} + b_0{\beta^0}\pmod \beta
        \end{align}
    }

    Which meants that ◊${c_0{\beta^0}} and ◊${a_0{\beta^0} + b_0{\beta^0}} are ◊em{congruent modulo} ◊${\beta}.

    ◊aside{
        ◊h5{Modular arithmetic}

        The statement ◊${a \equiv b\pmod n} means that ◊${a} and ◊${b} have the same ◊em{remainder} when divided by ◊${n} so that

        ◊$${
            \begin{align}
            a &= pn + r\\
            b &= qn + r
            \end{align}
        }

        where ◊${0 \le r \lt n} is the common remainder and ◊${n = \beta} in our case.

        The fact that these numbers are congruent modulo ◊${n} (or ◊${\beta}) is something that we enforce and it's a consequence of having our ◊em{coefficients} (the digits in our numbers) be limited to ◊${0 \le d \lt \beta} where ◊${d} is the value of a single coefficient or digit. 
        
        With this restriction, any answer to an operation that might ◊em{overflow} the max (or ◊em{underflow} the min) value will still have to produce a reasonable answer.

        For example

        ◊$${
            \begin{align}
            9 &+ 9 \equiv 8\pmod \beta\\
            5 &+ 5 \equiv 0\pmod \beta\\
            4 &+ 5 \equiv 9\pmod \beta
            \end{align}
        }

        where ◊${\beta = 10}.

        This restriction is necessary because our hardware is limited to numbers of only certain amount of ◊em{precision} (limited by amount of bits in the CPU registers). This means we have to deal with those limits at some point. 
        
        However, our goal is to work with numbers that are so large they don't even fit into the hardware anymore so we will have to deal with a bit of low level computer arithmetic involving the infamous ◊em{carry} value.
    }
}

◊section{
    ◊hgroup{
        ◊h4{A different base}
        ◊h5{Where things get a little bit more messy}
    }

    So far we've been seeing a lot of ◊${\beta} and in all of those cases we've been dealing with examples where ◊${\beta = 10} which is a very nice base but a little bit too easy. We need to get comfortable with the fact that ◊${\beta} can be any value of our choosing. And also keep in mind that the algorithms that we desing will work regardless of our ◊${\beta} value.   

    Writing our algorithms to cope with any constant ◊${\beta} will not only make them more useful. For example, we can make it run on various kind of hardware just by tweaking the ◊${\beta} value according to the register size of the machine. But it also helps with testing our algorithms since it's easier to force interesting things to happen when ◊${\beta} is small.
    
    In production we are going to deal with pretty large values of ◊${\beta} but if you want to test your algorithms it quickly becomes a bit messy to deal with these very large numbers so in those cases it helps to limit ◊${\beta} to some small value so they are a bit more friendly to work with. We will see examples of this soon enough.

    Before we continue with the last (but certainly not least) piece of the puzzle we will quickly take a look at a number that is in an unfamiliar base. Let's say that ◊${\beta = 5}. This is a base 5 system.

    ◊aside{
        From now on, when there might be confusion about the base of a number we will denote it as ◊${a_{\beta}} where ◊${a} is an integer and ◊${\beta} is some kind of base. So when you see

        ◊$${
            2_3 + 2_3 = 11_3 = 4_{10}
        }

        that means that ◊${2 + 2} equals ◊${11} in base ◊${3} which equals ◊${4} in base ◊${10}. Note that ◊${11_3} is ◊strong{not equal} to ◊${11_{10}}. If we were to write both numbers as polynomials ◊${P} and ◊${Q} respectively we get

        ◊$${
            \begin{align}
            P &= 11_3    = 1\cdot 3 + 1 = 4_{10}\\
            Q &= 11_{10} = 1\cdot 10 + 1 = 11_{10}
            \end{align}
        }

        Be careful! We will only use this convention in conjuction with literal integers and only when there might be confusion. When we refer to variables such as ◊${a_i} or ◊${b_i} we will always be referring to the ◊em{index} of the variable and not to the base or radix of its number system. When in doubt, assume a decimal system (i.e. ◊${\beta = 10}). Also note that we might not always be explicitly showing the implicit ◊${\beta} components (but they are always there).
    }
}

◊section{
    ◊hgroup{
        ◊h4{The burden of carrying}
        ◊h5{Where we will fix the final kink}
    }

    We have only one issue to deal with before we can wrap this up and start coding. We need to take an look wat what happens when we perform an ◊em{underflow} or ◊em{overflow} operation when we are not limited to working with ◊em{monomials}. This means we need to worry about the ◊em{carry} value and maybe even think back to some grade school arithmetic.

    Suppose we have two polynomials where ◊${\beta} is some kind of value we don't really care about. Except that we have the same restrictions in place as before when dealing with polynomials that have ◊${\beta} variables.

    ◊aside[#:class "todo"]{
        We should probably state these restrictions somewhere more prominently and formally.
    }

    Let's focus on adding two coefficients first and then we see about the other operations. When we have two coefficients ◊${a_i} and ◊${b_i} we saw earlier that in our ◊${\beta} radix system all the coefficients have to be

    ◊$${
        c_i \equiv (a_i + b_i) \pmod \beta
    }

    but this still leaves us with the situation when ◊${a_i + b_i \ge \beta}. We need to do something with that overflow. 
    
    ◊aside{
        An interesting question we can ask ourselves as this point is: what is the max value that we can get from an arithmetic operation involving ◊${a_i} and ◊${b_i}?

        Well, since we're still asuming only zero or positive coefficients we can say that

        ◊$${
            \begin{align}
            0 &\le a_i \lt \beta\\
            0 &\le b_i \lt \beta\\
            0 &\le a_i + b_i \le {2{\beta} - 2}
            \end{align}
        }

        And while we are at it might as well sneak peak into the future. What happens when we perform a multiplication?

        ◊$${
            \begin{align}
            0 &\le a_{i}b_{i} \le (\beta - 1)(\beta - 1)\\
            0 &\le a_{i}b_{i} \le \beta^2 - 2{\beta} + 1
            \end{align}
        }

        Note the wonderful ◊${{\beta^2} - 2{\beta} + 1} polynomial that appears.
    }
}